#!/bin/bash

# Vérification de la connectivité avec les hôtes
./sh/check_connectivity.sh

# Si la connectivité est OK, exécuter le playbook
if [ $? -eq 0 ]; then
  ./sh/run_playbook.sh
fi