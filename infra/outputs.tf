
output "adresses" {
  description = "Adresse de chaque borne"

  value = {
    for nom, port in var.bornes :
    nom => "http://localhost:${port}"
  }
}
