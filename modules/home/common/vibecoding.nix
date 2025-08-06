{ pkgs, ... }:
{

  home.packages = with pkgs; [
    aider-chat-full
    claude-code
  ];

}
