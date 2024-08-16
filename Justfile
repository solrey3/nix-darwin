# just is a command runner, Justfile is very similar to Makefile, but simpler.

# TODO update hostname here!
armHostname := "delta"
intelHostname := "charlie"

############################################################################
#
#  Darwin related commands
#
############################################################################

#  TODO Feel free to remove this target if you don't need a proxy to speed up the build process
darwin-set-proxy:
  sudo python3 scripts/darwin_set_proxy.py

# darwin: darwin-set-proxy
darwin-arm: 
  nix build .#darwinConfigurations.{{armHostname}}.system \
    --extra-experimental-features 'nix-command flakes' --impure

  ./result/sw/bin/darwin-rebuild switch --flake .#{{armHostname}} --impure

# darwin-debug: darwin-set-proxy
darwin-arm-debug: 
  nix build .#darwinConfigurations.{{armHostname}}.system --show-trace --verbose \
    --extra-experimental-features 'nix-command flakes'

  ./result/sw/bin/darwin-rebuild switch --flake .#{{armHostname}} --show-trace --verbose

# darwin: darwin-set-proxy
darwin-intel: 
  nix build .#darwinConfigurations.{{intelHostname}}.system \
    --extra-experimental-features 'nix-command flakes' --impure

  ./result/sw/bin/darwin-rebuild switch --flake .#{{intelHostname}} --impure

# darwin-debug: darwin-set-proxy
darwin-intel-debug: 
  nix build .#darwinConfigurations.{{intelHostname}}.system --show-trace --verbose \
    --extra-experimental-features 'nix-command flakes'

  ./result/sw/bin/darwin-rebuild switch --flake .#{{intelHostname}} --show-trace --verbose
############################################################################
#
#  nix related commands
#
############################################################################


update:
  nix flake update

history:
  nix profile history --profile /nix/var/nix/profiles/system

gc:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

  # garbage collect all unused nix store entries
  sudo nix store gc --debug


fmt:
  # format the nix files in this repo
  nix fmt

clean:
  rm -rf result
