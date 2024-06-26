variable "availability_zone" {
  type        = string
  description = "The availability zone to deploy the node group in"
}

variable "node_group_size" {
  type = object({
    desired_size = number
    min_size     = number
    max_size     = number
  })
  description = "The desired, minimum and maximum size of the node group in this availability zone"
}

variable "cluster_context" {
  type = object({
    ami_release_version        = string
    ami_type                   = string
    az_abbreviation_type       = string
    cluster_autoscaler_enabled = bool
    cluster_name               = string
    create_before_destroy      = bool
    # Obsolete, replaced by block_device_map
    #  disk_encryption_enabled    = bool
    #  disk_size                  = number
    instance_types    = list(string)
    kubernetes_labels = map(string)
    kubernetes_taints = list(object({
      key    = string
      value  = string
      effect = string
    }))
    kubernetes_version    = string
    module_depends_on     = any
    resources_to_tag      = list(string)
    subnet_type_tag_key   = string
    aws_ssm_agent_enabled = bool
    vpc_id                = string

    # block_device_map copied from cloudposse/terraform-aws-eks-node-group
    # Really, nothing is optional, but easier to keep in sync via copy and paste
    block_device_map = map(object({
      no_device    = optional(bool, null)
      virtual_name = optional(string, null)
      ebs = optional(object({
        delete_on_termination = optional(bool, true)
        encrypted             = optional(bool, true)
        iops                  = optional(number, null)
        kms_key_id            = optional(string, null)
        snapshot_id           = optional(string, null)
        throughput            = optional(number, null)
        volume_size           = optional(number, 20)
        volume_type           = optional(string, "gp3")
      }))
    }))
  })
  description = "The common settings for all node groups."
}
