{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "mouse";
        geometry = "0x2-10+30";
        padding = 10;
        horizontal_padding = 5;
        frame_width = 2;
        frame_color = "#353535";
        font = "Hack 10";
      };

      urgency_low = {
        background = "#2b2b2b";
        foreground = "#b2b2b2";
        timeout = 5;
      };

      urgency_normal = {
        background = "#2b2b2b";
        foreground = "#b2b2b2";
        timeout = 5;
      };

      urgency_critical = {
        background = "#2b2b2b";
        foreground = "#f4a73a";
        timeout = 10;
      };
    };
  };
}
