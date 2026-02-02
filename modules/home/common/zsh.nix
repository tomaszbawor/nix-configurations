{ lib, ... }:
{

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    # FNM - Node Version Manager and tmux autostart
    initContent = lib.mkOrder 1200 ''
      eval "$(fnm env --use-on-cd --shell zsh)"
    '';

    shellAliases = {
      ls = "eza";
      cat = "bat";
      lg = "lazygit";

      vim = "nvim";
      v = "nvim .";

      # Git
      gdc = "git diff --cached";
      glog = "git log --oneline";
      gs = "git status";
      gadd = "git add .";

      # Kubernetes
      k = "kubectl";
      kgp = "kubectl get pods";
      k8s-get-namespaced = "kubectl api-resources --verbs=list --namespaced -o name  | xargs -n 1 kubectl get --show-kind --ignore-not-found -n";
      # Docker
      doco = "docker compose";

      # Gradle
      gb = "./gradlew build";
      gkf = "./gradlew ktlintFormat";
      gsa = "./graldew spotlessApply";

      # Ultilities
      gites = "git add .; git commit --amend --no-edit; git push -f";
      runbg = ''bash -c '"$@" > /dev/null 2>&1 & disown' --'';
    };

  };
}
