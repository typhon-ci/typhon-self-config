{
  inputs.typhon.url = "github:typhon-ci/typhon";
  outputs = { self, typhon }: {
    typhonProject = typhon.lib.github.mkGithubProject {
      title = "Typhon";
      description = "Nix-based continuous integration";
      owner = "typhon-ci";
      repo = "typhon";
      secrets = ./secrets.age;
      typhon_url = "https://etna.typhon-ci.org";
    };
  };
}
