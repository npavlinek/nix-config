#!/usr/bin/env sh

selected_book=$(find ~/shared/Books\ \&\ Documentation -type f -iname '*.pdf' | /usr/bin/env fzf)
if [ ! -z "$selected_book" ]; then
  /usr/bin/env zathura "$selected_book" &
  disown
fi
