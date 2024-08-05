variable "milestones" {
  type = map(object({
    title = string
    description = string
    due_date = string
  }))
}

variable "labels" {
  type = map(object({
    name = string
    color = string
  }))
}

variable "issues" {
  type = list(object({
    title = string
    body = string
    labels = list(string)
    milestone = string
  }))
}