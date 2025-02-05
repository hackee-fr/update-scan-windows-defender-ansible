#!/bin/bash

# Vérification de la connectivité avec les hôtes (ping)
echo "Vérification de la connectivité avec les hôtes..."
ansible all -i inventory.yaml -m win_ping

# Vérification de la réussite du ping
if [ $? -eq 0 ]; then
  echo "Tous les hôtes sont accessibles !"
else
  echo "Erreur de connectivité avec certains hôtes. Vérifiez les paramètres de connexion."
  exit 1
fi