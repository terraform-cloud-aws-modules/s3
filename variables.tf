variable "rootlevelfolder" {
  type    = list
  default = ["foo", "bar", "baz"]
}

variable "sublevelfolder" {
  type    = list
  default = ["one", "two", "three", "four", "five", "six"]
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
