{ lib, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "algolia-cli";
  version = "1.6.3";

  src = fetchFromGitHub {
    owner = "algolia";
    repo = "cli";
    rev = "v${version}";
    hash = "sha256-xRGWPJx4AVdUT9f7L2B5SHEOneuIlscFTHIk7XtPzS8=";
  };

  vendorHash = "sha256-cNuBTH7L2K4TgD0H9FZ9CjhE5AGXADaniGLD9Lhrtrk=";

  nativeBuildInputs = [ installShellFiles ];

  subPackages = [ "cmd/algolia" ];

  ldflags = [ "-s" "-w" "-X github.com/algolia/cli/pkg/version.Version=${version}" ];

  postInstall = ''
    installShellCompletion --cmd algolia \
      --bash <($out/bin/algolia completion bash) \
      --fish <($out/bin/algolia completion fish) \
      --zsh <($out/bin/algolia completion zsh)
  '';

  meta = with lib; {
    description = "Algolia’s official CLI devtool";
    homepage = "https://algolia.com/doc/tools/cli/";
    license = licenses.mit;
    maintainers = [ maintainers.marsam ];
  };
}
