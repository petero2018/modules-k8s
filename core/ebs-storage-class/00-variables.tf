################################################################################
# EBS Storage Class
################################################################################

variable "name" {
  description = "Storage Class Name."
  type        = string
}

variable "default" {
  description = "Is the default storage class to use."
  type        = bool
  default     = false
}

variable "reclaim_policy" {
  description = "It describes the Kubernetes action when the PV is released."
  type        = string
  default     = "Delete"

  validation {
    condition     = contains(["Retain", "Delete"], var.reclaim_policy)
    error_message = "Invalid reclaim policy, valid values are: Retain, Delete."
  }
}

variable "allow_volume_expansion" {
  description = "This feature when set to true, allows the users to resize the volume by editing the corresponding PVC object."
  type        = bool
  default     = true
}

variable "mount_options" {
  description = "Linux mount options to apply to PVCs created with this storage class."
  type        = list(string)
  default     = null
}

################################################################################
# https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/parameters.md
################################################################################

variable "file_system" {
  description = "File system type that will be formatted during volume creation: xfs, ext2, ext3, ext4."
  type        = string
  default     = "ext4"

  validation {
    condition     = contains(["xfs", "ext2", "ext3", "ext4"], var.file_system)
    error_message = "Invalid file system, valid values are: xfs, ext2, ext3, ext4."
  }
}

variable "volume_type" {
  description = "EBS volume type: io1, io2, gp2, gp3, sc1, st1, standard."
  type        = string
  default     = "gp3"

  validation {
    condition     = contains(["io1", "io2", "gp2", "gp3", "sc1", "st1", "standard"], var.volume_type)
    error_message = "Invalid volume type, valid values are: io1, io2, gp2, gp3, sc1, st1, standard."
  }
}

variable "iops_per_gb" {
  description = "I/O operations per second per GiB. Required when io1 or io2 volume type is specified."
  type        = number
  default     = null
}

variable "auto_iops" {
  description = "When true the CSI driver increases IOPS for a volume when iopsPerGB * <volume size> is too low to fit into IOPS range supported by AWS."
  type        = bool
  default     = false
}

variable "iops" {
  description = "I/O operations per second. Only effetive when gp3 volume type is specified."
  type        = number
  default     = null
}

variable "throughput" {
  description = "Throughput in MiB/s. Only effective when gp3 volume type is specified."
  type        = number
  default     = null
}

variable "encrypted" {
  description = "Whether the volume should be encrypted or not."
  type        = bool
  default     = true
}

variable "kms_key" {
  description = "The full ARN of the key to use when encrypting the volume."
  type        = string
  default     = null
}

################################################################################
# https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/tagging.md
################################################################################

variable "tags" {
  description = "Tags to apply to the volume."
  type        = map(string)
  default     = {}
}

################################################################################
# Labels / Annotations
################################################################################

variable "labels" {
  description = "Labels to be applied to K8S resources."
  type        = map(string)
  default     = {}
}

variable "annotations" {
  description = "Annotations to be applied to K8S resources."
  type        = map(string)
  default     = {}
}
