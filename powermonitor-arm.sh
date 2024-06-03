#!/bin/bash

# Copyright (c) 2024, Adel Noureddine, Université de Pau et des Pays de l'Adour.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the
# GNU General Public License v3.0 only (GPL-3.0-only)
# which accompanies this distribution, and is available at
# https://www.gnu.org/licenses/gpl-3.0.en.html
#
# Author : Adel Noureddine

powermetrics_process() {
    # Read input from stdin
    while read -r line; do
        # Process each line and extract combined Power (CPU + GPU + ANE)
        pow_mW=$(echo "$line" | grep '^CPU Power:' | grep -oE '[0-9.]+')

        if [[ -n "$pow_mW" ]]; then
            pow_W=$(echo "scale=4; $pow_mW/1000" | bc -l | sed 's/^\./0./')  # floating division
            echo "$pow_W"
        fi
    done
}

powermetrics --samplers cpu_power -i 1000 | powermetrics_process