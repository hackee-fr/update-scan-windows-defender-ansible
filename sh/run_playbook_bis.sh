#!/bin/bash

# Vérification de l'existence de l'inventaire et du playbook
if [ ! -f "inventory.yaml" ]; then
  echo "Fichier inventory.yaml non trouvé!"
  exit 1
fi

if [ ! -f "playbook.yaml" ]; then
  echo "Fichier playbook.yaml non trouvé!"
  exit 1
fi

# Exécution du playbook avec Ansible
echo "Exécution du playbook Ansible..."
ansible-playbook -i inventory.yaml playbook.yaml

# Vérification du succès de l'exécution du playbook
if [ $? -eq 0 ]; then
  echo "Playbook exécuté avec succès!"
else
  echo "Erreur lors de l'exécution du playbook."
  exit 1
fi