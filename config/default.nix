{ pkgs }:
let
  nixToLuaConfigStore = dir:
    builtins.map (file:
      pkgs.writeTextFile {
        name = pkgs.lib.strings.removeSuffix ".nix" file;
        text = import ./${dir}/${file} { inherit pkgs; };
      }) (builtins.attrNames (builtins.readDir ./${dir}));

  toLuaConfigStore = dir:
    let
      storeDirectory = pkgs.stdenv.mkDerivation {
        name = "nvim-${dir}-configs";
        src = ./${dir};
        installPhase = ''
          mkdir -p $out/
          cp ./* $out/
        '';
      };
    in builtins.map (file: "${storeDirectory}/${file}")
    (builtins.attrNames (builtins.readDir storeDirectory));

  init = toLuaConfigStore "init";
  package = toLuaConfigStore "package";
  filetype = toLuaConfigStore "filetype";
  nixFiletype = nixToLuaConfigStore "nix/filetype";

  sourceLuaConfigs = files:
    builtins.concatStringsSep "\n" (builtins.map (file: "luafile ${file}") files);

  in builtins.concatStringsSep "\n"
  (builtins.map (configs: sourceLuaConfigs configs) [
    init
    package
    filetype
    nixFiletype
  ])
