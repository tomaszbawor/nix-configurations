{
  config,
  lib,
  username,
  ...
}:
{
  # docker
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "${username}" ];
  virtualisation.docker.logDriver = "json-file";
}
