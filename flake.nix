{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nuenv.url = "github:DeterminateSystems/nuenv";
  };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      perSystem = { pkgs, lib, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ inputs.nuenv.overlays.nuenv ];
        };
        packages.default = pkgs.nuenv.writeScriptBin {
          name = "search-flake-inputs.nu";
          script = ''
            use ${./toolbox.nu} *
            use ${./search-flake-inputs.nu} *
            # search-flake-inputs: Recursively search for a given input
            def main [
              --flake (-f): string # The flake URL
             ,--input (-i): string # The flake input to search for
             ,--json (-j) # Generate JSON output
              ] {
              let metadata_json = get_metadata_json $flake
              if not $json {
                path_with_rev $metadata_json $input
              } else {
                path_with_rev $metadata_json $input | to json
              }
            }
          '';
        };
      };
    };
}

