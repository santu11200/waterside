###IAM variable

variable "keypair_name" {}
variable "kms_id" {}
#variable "assume_role_policy" {}
#variable "profile_name" {}
#variable "profile_name_OrgAdmin" {}
#variable "policy_name" {}
#variable "art_ssm_policy" {}


variable "tags" {}
variable "default_tags" {
  type = map(string)

  default = {
    Automation           = "Yes"
    CloudServiceProvider  = "AWS"
    }
}
