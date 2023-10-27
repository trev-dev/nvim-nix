{ pkgs }:
let
  pluginList = p: [
    p.bash
    p.clojure
    p.css
    p.fennel
    p.html
    p.java
    p.javascript
    p.json
    p.markdown
    p.markdown_inline
    p.lua
    p.nix
    p.php
    p.python
    p.regex
    p.scheme
    p.sql
    p.svelte
    p.toml
    p.typescript
    p.vim
    p.vue
    p.xml
    p.yaml
  ];
in with pkgs.vimPlugins.nvim-treesitter; [
  (withPlugins pluginList)
]
