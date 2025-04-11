module "rabbitmq" {
  source = "./modules/rabbitmq"

  rabbitmq_namespace          = var.kubernetes_namespace
  rabbitmq_helm_version       = var.rabbitmq_helm_version
  rabbitmq_auth_password      = var.rabbitmq_auth_password
  rabbitmq_auth_erlang_cookie = var.rabbitmq_auth_erlang_cookie

  depends_on = [
    module.monitoring
  ]
}
