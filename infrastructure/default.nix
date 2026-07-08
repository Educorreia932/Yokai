{
  system,
  pkgs,
  terranix,
  agenix,
}:

let
  tfConfig = terranix.lib.terranixConfiguration {
    inherit system;
    modules = [ ./tengu.nix ];
  };

  mkOpenTofuApp = command: {
    type = "app";
    program = toString (
      pkgs.writers.writeBash "infra-${command}" ''
        export TF_VAR_hcloud_token="$(cd ${../secrets} && ${agenix}/bin/agenix -d hetzner-cloud-api-key.age)"

        rm -f config.tf.json
        cp ${tfConfig} config.tf.json \
          && ${pkgs.opentofu}/bin/tofu init \
          && ${pkgs.opentofu}/bin/tofu ${command}
      ''
    );
  };
in
{
  infra-plan = mkOpenTofuApp "plan";
  infra-apply = mkOpenTofuApp "apply";
  infra-destroy = mkOpenTofuApp "destroy";
}
