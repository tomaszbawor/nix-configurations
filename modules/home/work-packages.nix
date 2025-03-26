{ pkgs, ... }:
let
  vspherePlugin =
    import ./../custom-packages/kubectl-vsphere.nix { inherit pkgs; };
in
{ home.packages = [ vspherePlugin ]; }
