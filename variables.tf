variable "tags" {}

variable "rootlevelfolder" {
  type    = list
  default = []
}

variable "sublevelfolder" {
  type    = list
  default = []
}

variable "bucketname" {
  type    = string
}

variable "acl" {
  type    = string
  default = "private"
}

variable "versioning" {
  default = "true"
}
