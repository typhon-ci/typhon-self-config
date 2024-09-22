{
  inputs = {
    typhon.url = "github:typhon-ci/typhon/pnm/webhooks";
    flake-schemas.follows = "typhon/flake-schemas";
  };

  outputs =
    {
      self,
      typhon,
      flake-schemas,
    }:
    {
      typhonProject = typhon.lib.github.mkProject {
        title = "Typhon";
        description = "Nix-based continuous integration";
        owner = "typhon-ci";
        repo = "typhon";
        secrets = ./secrets.age;
        typhonUrl = "https://etna.typhon-ci.org";
        deploy = [
          {
            name = "Push to Cachix";
            value = typhon.lib.cachix.mkPush { name = "typhon"; };
          }
          {
            name = "Deploy the documentation";
            value = typhon.lib.github.mkPages {
              owner = "typhon-ci";
              repo = "typhon";
              job = "doc";
              customDomain = "doc.typhon-ci.org";
            };
          }
        ];
      };
      schemas = {
        inherit (typhon.lib.schemas) typhonProject;
        inherit (flake-schemas.schemas) schemas;
      };
    };
}
