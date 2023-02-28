resource "aws_kms_key" "sops_key" {
  for_each                = local.keys
  description             = each.value.description
  deletion_window_in_days = each.value.deletion_window_in_days
  policy                  = each.value.policy
  enable_key_rotation     = each.value.enable_key_rotation
  tags                    = each.value.tags
}
