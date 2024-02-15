{
  inputs = {
    typhon.url = "github:typhon-ci/typhon";
    flake-schemas.follows = "typhon/flake-schemas";
  };

  outputs = {
    self,
    typhon,
    flake-schemas,
  }: {
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
          value = typhon.lib.cachix.mkPush {name = "typhon";};
        }
      ];
    };
    schemas = {
      inherit (typhon.lib.schemas) typhonProject;
      inherit (flake-schemas.schemas) schemas;
    };
  };
}
