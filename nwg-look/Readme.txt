default. nix is to build from source

just place default.nix in source dir


Terminal:
1. cd to source dir

2. nix-build -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'
