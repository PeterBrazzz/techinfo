resource "kubernetes_deployment" "app" {
  metadata {
    name = "spring-deployment"
    labels = {
      test = "MyExampleApp"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "MyExampleApp"
      }
    }

    template {
      metadata {
        labels = {
          test = "MyExampleApp"
        }
      }

      spec {
        container {
          image = "jbrisbin/spring-petclinic:latest"
          name  = "example"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "1024Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "mysql" {
  metadata {
    name = "mysql-deployment"
    labels = {
      test = "MySQL"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "MySQL"
      }
    }

    template {
      metadata {
        labels = {
          test = "MySQL"
        }
      }

      spec {
        container {
          image = "mysql:5.7.8"
          name  = "mysql"

          # env_from {
          #   config_map_ref {
          #     name = configmap
          #   }
          # }         

          resources {
            limits = {
              cpu    = "0.5"
              memory = "1024Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 3306

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}


# resource "helm_release" "mysql" {
#   name       = "mysql"

#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "mysql"

#   values = [
#     file("${path.module}/mysql.yaml")
#   ]
# }

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}