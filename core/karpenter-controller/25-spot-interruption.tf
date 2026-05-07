################################################################################
# Spot Interruption Handling - SQS Queue and EventBridge Rules
################################################################################

locals {
  # EventBridge events for spot interruption handling
  interruption_events = {
    health_event = {
      name        = "HealthEvent"
      description = "Karpenter interrupt - AWS health event"
      event_pattern = {
        source      = ["aws.health"]
        detail-type = ["AWS Health Event"]
      }
    }
    spot_interrupt = {
      name        = "SpotInterrupt"
      description = "Karpenter interrupt - EC2 spot instance interruption warning"
      event_pattern = {
        source      = ["aws.ec2"]
        detail-type = ["EC2 Spot Instance Interruption Warning"]
      }
    }
    instance_rebalance = {
      name        = "InstanceRebalance"
      description = "Karpenter interrupt - EC2 instance rebalance recommendation"
      event_pattern = {
        source      = ["aws.ec2"]
        detail-type = ["EC2 Instance Rebalance Recommendation"]
      }
    }
    instance_state_change = {
      name        = "InstanceStateChange"
      description = "Karpenter interrupt - EC2 instance state-change notification"
      event_pattern = {
        source      = ["aws.ec2"]
        detail-type = ["EC2 Instance State-change Notification"]
      }
    }
  }
}

################################################################################
# SQS Queue for Spot Interruption Messages
################################################################################

resource "aws_sqs_queue" "interruption" {
  count = var.enable_spot_termination ? 1 : 0

  name                              = var.queue_name
  message_retention_seconds         = 300
  sqs_managed_sse_enabled           = var.queue_managed_sse_enabled
  kms_master_key_id                 = var.queue_kms_master_key_id
  kms_data_key_reuse_period_seconds = var.queue_kms_data_key_reuse_period_seconds

  tags = merge(var.tags, {
    Name    = var.queue_name
    Purpose = "karpenter-spot-interruption"
  })
}

# SQS Queue Policy
data "aws_iam_policy_document" "interruption_queue" {
  count = var.enable_spot_termination ? 1 : 0

  statement {
    sid       = "SqsWrite"
    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.interruption[0].arn]

    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com",
        "sqs.amazonaws.com",
      ]
    }
  }

  statement {
    sid       = "DenyHTTP"
    effect    = "Deny"
    actions   = ["sqs:*"]
    resources = [aws_sqs_queue.interruption[0].arn]

    condition {
      test     = "StringEquals"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_sqs_queue_policy" "interruption" {
  count = var.enable_spot_termination ? 1 : 0

  queue_url = aws_sqs_queue.interruption[0].url
  policy    = data.aws_iam_policy_document.interruption_queue[0].json
}

################################################################################
# EventBridge Rules for Spot Interruption Events
################################################################################

resource "aws_cloudwatch_event_rule" "interruption" {
  for_each = var.enable_spot_termination ? local.interruption_events : {}

  name_prefix   = "${var.rule_name_prefix}${each.value.name}-"
  description   = each.value.description
  event_pattern = jsonencode(each.value.event_pattern)

  tags = merge(var.tags, {
    Name        = "${var.rule_name_prefix}${each.value.name}"
    ClusterName = var.eks_cluster
    Purpose     = "karpenter-spot-interruption"
  })
}

resource "aws_cloudwatch_event_target" "interruption" {
  for_each = var.enable_spot_termination ? local.interruption_events : {}

  rule      = aws_cloudwatch_event_rule.interruption[each.key].name
  target_id = "KarpenterInterruptionQueueTarget"
  arn       = aws_sqs_queue.interruption[0].arn
}
