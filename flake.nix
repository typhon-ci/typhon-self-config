{
  inputs = {
    typhon.url = "github:typhon-ci/typhon/dev";
    flake-schemas.follows = "typhon/flake-schemas";
  };

  outputs = {
    self,
    typhon,
    flake-schemas,
  }: {
    typhonProject = typhon.lib.github.mkGithubProject {
      title = "Typhon";
      description = "Nix-based continuous integration";
      owner = "typhon-ci";
      repo = "typhon";
      secrets = ./secrets.age;
      typhon_url = "https://etna.typhon-ci.org";
    };
    schemas = {
      inherit (typhon.lib.schemas) typhonProject;
      inherit (flake-schemas.schemas) schemas;
    };
  };
}
