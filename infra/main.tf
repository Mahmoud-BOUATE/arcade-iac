
resource "docker_image" "web" {
  name         = var.image_web
  keep_locally = true
}

resource "docker_container" "borne" {
  for_each = var.bornes

  name    = "arcade-${each.key}"
  image   = docker_image.web.image_id
  restart = "unless-stopped"

  ports {
    internal = 80
    external = each.value
    ip       = "127.0.0.1"
  }

  upload {
    file        = "/usr/share/nginx/html/index.html"
    source      = "${path.module}/../app/index.html"
    source_hash = filesha256("${path.module}/../app/index.html")
  }

  upload {
    file        = "/usr/share/nginx/html/style.css"
    source      = "${path.module}/../app/style.css"
    source_hash = filesha256("${path.module}/../app/style.css")
  }

  upload {
    file        = "/usr/share/nginx/html/game.js"
    source      = "${path.module}/../app/game.js"
    source_hash = filesha256("${path.module}/../app/game.js")
  }
}
resource "docker_volume" "records" {
  name = "arcade-records"
}