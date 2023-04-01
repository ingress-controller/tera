resource "kubernetes_deployment" "task" {
  metadata {
    name = var.app_name
    labels = {
      app = var.app_name
    }
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          image = var.site_image
          name  = var.container_name
          port {
            name = "tcp"
            container_port = var.container_port
          }


          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
resource "kubernetes_ingress_v1" "task" {
  metadata {
    name = var.app_name
    namespace = var.namespace
  }

  spec {
    default_backend {
      service {
        name = var.app_name
        port {
            number = var.container_port
        }
      }
    }

    rule {
      http {
        path {
          backend {
            service {
              name = var.app_name
              port {
                number = var.container_port
              }
            }
          }

          path = var.path
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "task" {
  metadata {
    name = var.app_name
    namespace = var.namespace
  }
  spec {
    selector = {
      app = var.app_name
    }
    session_affinity = var.session_affinity
    port {
      name        = var.port_name
      port        = var.container_port
    }
    type = var.port_type
  }
}
resource "kubernetes_endpoints_v1" "task" {
    metadata {
        name = var.app_name
        namespace = var.namespace
    }
    subset {
        address {
            ip = "10.0.0.4"
        }
        port {
            name = "tcp"
            port = var.container_port
            protocol = "TCP"
        }
    }
}
