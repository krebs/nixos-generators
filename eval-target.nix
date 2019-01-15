{ nixpkgs ? <nixpkgs>
, configuration ? 
  import "${toString nixpkgs}/nixos/lib/from-env.nix" "NIXOS_CONFIG" <nixos-config>
, target
, system ? builtins.currentSystem
}:
let
  module = { lib, ... }: {
    options = {
      targetAttr = lib.mkOption {
        default = "toplevel";
        description = "Declare the default attribute to build";
      };
    };
  };
in
import "${toString nixpkgs}/nixos/lib/eval-config.nix" {
  inherit system;
  modules = [
    module
    target
    configuration
  ];
}