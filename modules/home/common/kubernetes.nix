{ pkgs, inputs, ... }:
let
  kubectl = inputs.krew2nix.packages.${pkgs.system}.kubectl;
in
{

  programs.k9s.enable = true;

  programs.kubecolor = {
    enable = true;
    enableAlias = true;
  };

  home.packages = with pkgs; [
    # Kubernetes
    (kubectl.withKrewPlugins (plugins: [
      plugins.ns
      plugins.ctx
    ]))
    argocd
    argocd-autopilot
    kustomize
    kubectx
    kubernetes-helm
    fluxcd
    lens
    talosctl
  ];

}
