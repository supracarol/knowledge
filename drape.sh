#!/bin/bash

#  Toggle files in a directory present or absent. Files or directories
#  prefixed with `drape.` (case insensitive) are toggled.  Files toggled
#  absent are moved to `~/drape`. The purpose of this is to cleanup working
#  files in a directory without deleting them, with the ability to quickly
#  bring them back in.


set -euo pipefail

DRAPE_DIR="$HOME/drape/$(readlink -f . | sed "s%^$HOME/%%")"

usage(){
  echo "Usage: $(basename "$0") <in|out> "
  exit 1
}

[[ $# -eq 1 ]] || usage

if [[ "$1" = "out" ]]; then

  mkdir -p "$DRAPE_DIR"
  find . -maxdepth 1 -iname "drape.*" -print0 | xargs -I{} -0 mv -i "{}" "$DRAPE_DIR"


elif [[ "$1" = "in" ]]; then
  find "$DRAPE_DIR" -maxdepth 1 -iname "drape.*" -print0 | xargs -I{} -0  mv -i "{}" .

else
  usage
fi
