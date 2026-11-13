
variable "image_web" {
  description = "Image Docker du serveur web"
  type        = string
}

variable "bornes" {
  description = "Les bornes à déployer"
  type        = map(number)
}
