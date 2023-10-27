{ pkgs }:
with pkgs; [
  jdt-language-server
  lua-language-server
  nimlsp
  rnix-lsp

  vscode-extensions.vscjava.vscode-java-test
  vscode-extensions.vscjava.vscode-java-debug

  # node packages must be at the bottom
  nodePackages.bash-language-server
  nodePackages.typescript
  nodePackages.typescript-language-server
  nodePackages.volar
  nodePackages.vscode-langservers-extracted
  nodePackages.yaml-language-server
]
