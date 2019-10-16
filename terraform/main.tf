module "egress_security_group" {
  source = "github.com/wellcometrust/terraform//network/prebuilt/vpc/egress_security_group?ref=v19.5.0"

  name = "${local.namespace}_requests"

  vpc_id     = "${local.vpc_id}"
  subnet_ids = "${local.private_subnets}"
}

module "logstash_transit" {
  source = "git::https://github.com/wellcometrust/terraform.git//ecs/prebuilt/default?ref=4ceb43fb9c08f5ac8ec3bc43b03f8c3c81621b97"

  security_group_ids = [
    "${module.egress_security_group.sg_id}",
    "${aws_security_group.interservice_security_group.id}",
  ]

  cluster_id   = "${aws_ecs_cluster.cluster.id}"
  namespace_id = "${aws_service_discovery_private_dns_namespace.namespace.id}"
  subnets      = "${local.private_subnets}"
  service_name = "requests_logstash_transit"

  env_vars = {
    XPACK_MONITORING_ENABLED = "false"
    NAMESPACE                = "requests"
  }

  env_vars_length = 2

  secret_env_vars = {
    ES_HOST = "catalogue/logstash/es_host"
    ES_USER = "catalogue/logstash/es_user"
    ES_PASS = "catalogue/logstash/es_pass"
  }

  secret_env_vars_length = 3

  cpu    = 1024
  memory = 2048

  container_image = "wellcome/logstash_transit:114"
}