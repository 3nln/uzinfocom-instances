{
  lib,
  inputs,
  config,
  ...
}:
let
  cfg = config.uzinfocom.apps.xinux.website;
in
{
  imports = [
    inputs.xinux-website.nixosModules.server
  ];

  options = {
    uzinfocom.apps.xinux.website = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        example = true;
        description = "Whether to host github:xinux-org/website project in this server.";
      };

      domain = lib.mkOption {
        type = lib.types.str;
        default = "xinux.uz";
        example = "example.com";
        description = "Domain for the website to be associated with.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      xinux.website = {
        enable = true;
        port = 51006;
        host = "127.0.0.1";

        proxy = {
          enable = true;
          proxy = "nginx";
          inherit (cfg) domain;
        };
      };
    };
  };
}
