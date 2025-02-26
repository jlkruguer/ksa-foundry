#!/bin/bash
for env in $(conda env list | grep -v "^#" | awk "{print \$1}"); do
  if [ "$env" != "base" ] && [ -n "$env" ]; then
    echo "Exporting $env environment..."
    conda activate $env
    conda env export > "${env}_environment.yml"
  fi
done
