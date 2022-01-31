locals {
  keys = {
    prod = {
      description             = "Key for prod env using SOPS"
      deletion_window_in_days = 10
      policy                  = templatefile("./policies/key-policy.tpl", { key_users = [var.my_aws_user], key_admins = [var.my_aws_user, var.root] })
      enable_key_rotation     = true
      tags = {
        use         = "SOPS for nix config"
        environment = "personal"
      }

    }
  }
}


