# Redis setup
module "redis" {
  source = "./modules/redis"

  depends_on = [
    time_sleep.kubeconfig_setup
  ]
}
