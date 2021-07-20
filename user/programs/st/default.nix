{ pkgs, ... }:

let readFile = builtins.readFile;
in {
  nixpkgs.overlays = [
    (self: super: {
      stCustom = super.st.override {
        conf = readFile ./config.h;
        patches = [
          ./st-anysize-0.8.4.diff
          ./st-scrollback-0.8.4.diff
          ./st-ligatures-scrollback-20200430-0.8.3.diff
        ];
        extraLibs = with pkgs; [ harfbuzz ];
      };
    })
  ];
}
