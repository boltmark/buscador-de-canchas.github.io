#!/bin/bash
cd /Users/marcusbolton/repos/marcus-bolton.github.io

# Prevent system sleep while task is running
/usr/bin/caffeinate -s bash -c '
  if [ -f "assets/fetch-data.sh" ]; then
    chmod +x assets/fetch-data.sh
    ./assets/fetch-data.sh > courtfinder/court_data.json

    git add courtfinder/court_data.json
    git diff --quiet && git diff --staged --quiet || {
      git commit -m "Update court data: $(date)"
      git pull origin master --rebase -X ours
      git push
    }
  else
    echo "Error: fetch-data.sh not found" >&2
    exit 1
  fi
'
