{ ... }:
{

  programs.fish = {
    enable = true;
    generateCompletions = true;

    loginShellInit = ''
      fnm env --use-on-cd --shell fish | source
    '';

    interactiveShellInit = ''
      fnm env --use-on-cd --shell fish | source
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
