# A Neovim Flake

A super simple Nix flake for a highly reproducible Neovim.  The goal of this
configuration is to be able to have a consistent, stable Neovim configuration
that will always have its [dependencies satisfied](https://github.com/wbthomason/packer.nvim/issues/1229).

Thanks to *PrimaMateria* for the article on how to do this:

See [PrimaMateria's Blog](https://primamateria.github.io/blog/neovim-nix/)

## Features

- Built-in LSP support for Java (JDTLS), JavaScript/TypeScript, HTML/CSS, Vue3
  and [some other stuff](./runtimeDeps.nix), too.
- Debug adapter support for Java
- Built-in tree-sitter [parsers](./tree-sitter.nix) and [configs](./config/package/treesitter.lua) for numerous languages.
- Rich Markdown editing, powered by tree-sitter, [Mkdnflow](https://github.com/jakewvincent/mkdnflow.nvim) and [ZK](https://github.com/mickael-menu/zk)

## Usage

You can run this nix flake on the CLI executing `nix run
sourcehut:~trevdev/nvim-nix`.  You could create a shell alias and stop worrying
about installing the flake altogether:

```bash
nvim = "nix run sourcehut:~trevdev/nvim-nix --";
```

Alternatively you could clone the source code and run it from your local
machine.  This will give you the ability to change things with ease: `nix run
/path/to/nvim-nix`;

### With home-manager

If you're using home manager, you may just add this flake as an input and add it
to whatever package manifest you may have.

```nix
let
  nvim-nix = (builtins.getFlake "sourcehut:~trevdev/nvim-nix")
    .packages.x86_64-linux.default;
in {
  home.packages = [ nvim-nix ]; # along with your other packages
}
```
