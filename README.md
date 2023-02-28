# Nix Home

This repository contains user configuration deployed using the helpful tool [Home Manager](https://github.com/rycee/home-manager).

It was forked from [Hugo Reeves](https://github.com/HugoReeves/nix-home)
A full explanation of his portable user configuration management (dotfiles) system can be found on his [blog](https://blog.hugoreeves.com/posts/2019/08/your-home-in-nix-dotfile-management/).

My adaptation are personal taste. I removed a bunch of stuff reducing complexity, but then again I wanted to also have the ability to restore all my secrets and keys,
so I added [Mozilla] Sops to encrypt those, maintaining keys with terraform in AWS.

For an explanation of how that can be achieved please read my blog at [calzone.proofofpizza.com](https://calzone.proofofpizza.com/tech/tutorial/using-sops-with-aws-and-terraform/)

