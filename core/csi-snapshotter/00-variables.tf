################################################################################
# EBS CSI
################################################################################

variable "csi_snapshotter_version" {
  description = "CSI Snapshotter version."
  type        = string
}

variable "default_class" {
  description = "Creates a default volume snapshot class."
  type        = bool
  default     = true
}

variable "default_class_labels" {
  description = "Labels to add to the default volume snapshot class."
  type        = map(string)
  default     = {}
}
