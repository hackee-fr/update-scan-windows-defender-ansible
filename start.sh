#!/bin/bash

# Définition des couleurs ANSI pour plus de lisibilité
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}------------------------------------------------------------"
echo -e "              Vérification des fichiers nécessaires          "
echo -e "------------------------------------------------------------\n${NC}"

# Vérification de l'existence des fichiers nécessaires
./sh/check_files.sh
if [ $? -ne 0 ]; then
  echo -e "${RED}Erreur : L'un des fichiers nécessaires est manquant. Abandon...${NC}"
  exit 1  # Si l'un des fichiers n'est pas trouvé, quitter le script
else
  echo -e "${GREEN}\nTous les fichiers nécessaires sont présents.\n${NC}"
fi

echo -e "${YELLOW}------------------------------------------------------------"
echo -e "            Vérification de la connectivité avec les hôtes    "
echo -e "------------------------------------------------------------\n${NC}"

# Vérification de la connectivité avec les hôtes
./sh/check_connectivity.sh
if [ $? -ne 0 ]; then
  echo -e "${RED}Erreur : La connectivité avec les hôtes a échoué. Abandon...${NC}"
  exit 1  # Si la connectivité échoue, quitter le script
else
  echo -e "${GREEN}Connectivité avec les hôtes réussie.\n${NC}"
fi

# Si la connectivité et les fichiers sont OK, exécuter le playbook
echo -e "${YELLOW}------------------------------------------------------------"
echo -e "                  Exécution du playbook Ansible              "
echo -e "------------------------------------------------------------\n${NC}"
./sh/run_playbook.sh

