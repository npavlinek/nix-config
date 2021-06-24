{ pkgs, ... }:

{
  services.polybar = {
    enable = true;
    script = ''
      polybar top &
    '';
    config = {
      "module/xmonad" = {
        type = "custom/script";
        exec = "${pkgs.xmonad-log}/bin/xmonad-log";
        tail = true;
      };

      # "module/uptime" = {
      #   type = "custom/script";
      #   exec = "${pythonScripts}/bin/get-uptime";
      # };

      "module/loadavg" = {
        type = "custom/script";
        exec = "${pkgs.gawk}/bin/awk '{print $1, $2, $3}' /proc/loadavg";
        interval = "2";
      };

      "module/date" = {
        type = "internal/date";
        date = "%a %F";
        time = "%H:%M";

        label = "%date% %time%";
      };

      "bar/top" = {
        width = "100%";
        height = "20";
        background = "#282828";
        foreground = "#ebdbb2";
        font-0 = "Hack:size=9;4";
        modules-left = "xmonad";
        modules-right = "uptime loadavg date";
        separator = "%{F#665c54} | %{F-}";
        tray-position = "right";
      };
    };
  };
}
