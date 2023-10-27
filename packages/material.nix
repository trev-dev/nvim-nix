{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "material";
  inherit src;
}
