variable "topic-name" {
  type = string
  default = "order-placed-topic"
}

variable "queue-name" {
  type = string
  default = "main-queue"
}

variable "dl-queue-name" {
  type = string
  default = "dead-letter-queue"
}

