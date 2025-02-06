#!/bin/bash

# Définition des couleurs ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'  # Ajout de la couleur bleue
NC='\033[0m'  # No Color

# Fonction pour afficher l'animation de vérification
loading() {
  local pid=$1
  local spin='-\|/'
  local i=0
  while kill -0 $pid 2>/dev/null; do
    printf "\r${spin:i++%${#spin}:1}"  # Affichage uniquement de l'animation sans le texte
    sleep 0.1
  done
  printf "\r...terminé !\n\n${NC}"  # Affichage de "...terminé !" après la fin de l'animation
}

# Fonction pour afficher et gérer le menu de sélection
show_menu() {
  while true; do
    echo -e "${YELLOW}Sélectionnez le mode d'exécution :${NC}"
    echo "1) Mode Classique"
    echo "2) Mode Debug"
    read -r -p "Entrez votre choix (1 ou 2) : " choix
    choix=$(echo "$choix" | tr -d '[:space:]')  # Nettoyage de l'entrée pour enlever les espaces

    if [[ "$choix" == "1" ]]; then
      export OPTIONS=""  # Mode Classique, exporter la variable OPTIONS
      break
    elif [[ "$choix" == "2" ]]; then
      export OPTIONS="-vvv"  # Mode debug avec plus de verbosité, exporter la variable OPTIONS
      break
    else
      echo -e "${RED}Choix invalide. Veuillez entrer 1 ou 2.${NC}"
    fi
  done
}

# Fonction pour exécuter le playbook Ansible
run_playbook() {
  echo -e "${YELLOW}\nExécution du playbook Ansible en mode $( [[ "$OPTIONS" == "-vvv" ]] && echo "Debug" || echo "Classique" )...${NC}"
  # Exécution du playbook dans un processus en arrière-plan
  (
    ansible-playbook $OPTIONS -i inventory.yaml playbook.yaml
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Playbook exécuté avec succès !${NC}"
    else
      echo -e "${RED}Erreur lors de l'exécution du playbook.${NC}"
      exit 1
    fi
  ) &

  # Afficher l'animation pendant l'exécution du playbook
  loading $! 
  printf "${BLUE}GoodBye !${NC}\n"
}

# Début du script

# Affichage du menu et choix de l'option
show_menu

# Exécution du playbook
run_playbook
