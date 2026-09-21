
{
  inputs = {
    artiq.url = "git+https://github.com/m-labs/artiq.git?ref=release-8";
    artiq-comtools.follows = "artiq/artiq-comtools";
    nixpkgs.follows = "artiq/nixpkgs";
    flake8-artiq = {
      url = "git+https://gitlab.com/duke-artiq/flake8-artiq.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs =
    { self, artiq, artiq-comtools, nixpkgs, flake8-artiq }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      artiqpkgs = artiq.packages.x86_64-linux // artiq-comtools.packages.x86_64-linux;
    in
    {
      # Default shell for `nix develop`
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [
          # Python packages
          (pkgs.python3.withPackages (ps: [
            artiqpkgs.artiq
            artiqpkgs.artiq-comtools
            ps.pytest
            # any other library used in ARTIQ-python scripts
          ]))
        ];
      };
      # Enables use of `nix fmt`
      formatter.x86_64-linux = pkgs.nixpkgs-fmt;
    };

  # Settings to enable substitution from the M-Labs servers (avoiding local builds)
  nixConfig = {
    extra-trusted-public-keys = [ "nixbld.m-labs.hk-1:5aSRVA5b320xbNvu30tqxVPXpld73bhtOeH6uAjRyHc=" ];
    extra-substituters = [ "https://nixbld.m-labs.hk" ];
  };
}