{
  inputs.typhon.url = "github:typhon-ci/typhon";
  outputs = { self, typhon }: {
    typhonProject = typhon.lib.github.mkGithubProject {
      owner = "typhon-ci";
      repo = "typhon";
      secrets = ./secrets.age;
      typhon_url = "https://etna.typhon-ci.org";
    };
  };
}
