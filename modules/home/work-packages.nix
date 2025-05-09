{ pkgs, ... }:
let
  vspherePlugin = import ./../derivations/kubectl-vsphere.nix { inherit pkgs; };
in
{
  home.packages = [ vspherePlugin ];
}
