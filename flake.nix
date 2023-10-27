{
  description = "A Neovim flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    material-src = {
      url = "github:marko-cerovac/material.nvim";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, neovim, material-src }:
    let
      overlayFlakeInputs = final: prev: {
        neovim = neovim.packages.x86_64-linux.neovim;
        vimPlugins = prev.vimPlugins // {
          material = import ./packages/material.nix {
            src = material-src;
            pkgs = final;
          };
        };
      };

      overlayCustomNeovim = final: prev: {
        customNeovim = import ./packages/custom-neovim.nix {
          pkgs = prev;
        };
      };

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ overlayFlakeInputs overlayCustomNeovim ];
      };

    in {
      packages.x86_64-linux.default = pkgs.customNeovim;
      apps.x86_64-linux.default = {
        type = "app";
        program = "${pkgs.customNeovim}/bin/nvim";
      };
    };
}
