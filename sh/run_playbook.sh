#!/bin/bash

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