resource "aws_key_pair" "default" {
  count      = var.enable && var.enable_key_pair == true ? 1 : 0
  key_name   = format("%s-key-pair", module.labels.id)
  public_key = var.public_key == "" ? join("", tls_private_key.default[*].public_key_openssh) : var.public_key
}

resource "aws_default_security_group" "default" {
  vpc_id = var.vpc_id
  dynamic "ingress" {
    for_each = var.default_security_group_ingress
    content {
      self             = lookup(ingress.value, "self", true)
      cidr_blocks      = compact(split(",", lookup(ingress.value, "cidr_blocks", "")))
      from_port        = lookup(ingress.value, "from_port", 0)
      to_port          = lookup(ingress.value, "to_port", 0)
      protocol         = lookup(ingress.value, "protocol", "-1")
    }
  }
  dynamic "egress" {
    for_each = var.default_security_group_egress
    content {
      self             = lookup(egress.value, "self", true)
      cidr_blocks      = compact(split(",", lookup(egress.value, "cidr_blocks", "")))
      ipv6_cidr_blocks = compact(split(",", lookup(egress.value, "ipv6_cidr_blocks", "")))
      prefix_list_ids  = compact(split(",", lookup(egress.value, "prefix_list_ids", "")))
      security_groups  = compact(split(",", lookup(egress.value, "security_groups", "")))
      description      = lookup(egress.value, "description", null)
      from_port        = lookup(egress.value, "from_port", 0)
      to_port          = lookup(egress.value, "to_port", 0)
      protocol         = lookup(egress.value, "protocol", "-1")
    }
  }


resource "aws_instance" "default" {
  count                                = var.enable && var.default_instance_enabled ? var.instance_count : 0
  ami                                  = var.ami
  ebs_optimized                        = var.ebs_optimized
  instance_type                        = var.instance_type
  key_name                             = var.key_name == "" ? join("", aws_key_pair.default[*].key_name) : var.key_name
  vpc_id                               = var.vpc_id
  subnet_id                            = element(distinct(compact(concat(var.subnet_ids))), count.index)
  associate_public_ip_address          = var.associate_public_ip_address
  availability_zone                    = var.availability_zone
}