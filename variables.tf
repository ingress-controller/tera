variable "namespace" {
    type = string
    default = "web"
}

variable "app_name" {
    type = string
    default = "webapp"
}

variable "site_image" {
    type = string
    default = "nginx:alpine"
}

variable "container_name" {
    type = string
    default = "server"
}

variable "container_port" {
    type = string
    default = 80
}

variable "secret_name" {
    type = string
    default = "tls-secret"
}

variable "session_affinity" {
    type = string
    default = "ClientIP"
}

variable "target_port" {
    type = string
    default = 80
}

variable "port_type" {
    type = string
    default = "NodePort"
}

variable "path" {
    type = string
    default = "/"
}
