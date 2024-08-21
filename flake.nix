{
  description = "slide";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self
  , nixpkgs
  , systems
  , ... } @ inputs:
  let
    forEachSystems = nixpkgs.lib.genAttrs ( import systems );
  in
  {
    packages = forEachSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      rec {
        all = pkgs.symlinkJoin {
          name = "all";
          paths = [ example ];
        };
        default = all;
        example = pkgs.callPackage ./slide.nix { name = "example"; };
      }
      );
  };
}
