#!/bin/bash

# Définition des couleurs ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Fonction pour afficher l'animation de vérification
loading() {
  local pid=$1
  local message=$2
  local spin='-\|/'
  local i=0
  while kill -0 $pid 2>/dev/null; do
    printf "\r$message ${spin:i++%${#spin}:1}"
    sleep 0.1
  done
  printf "\r$message ...terminé !\n\n${NC}"
}

# Fonction pour vérifier la connectivité avec les hôtes (ping avec Ansible)
check_connectivity() {
  echo -e "Vérification de la connectivité avec les hôtes...\n"

  # Forcer Ansible à utiliser des couleurs
  export ANSIBLE_FORCE_COLOR=true

  # Exécution du ping avec Ansible en arrière-plan et capture du PID
  (
    output=$(ansible all -i inventory.yaml -m win_ping)
    echo "$output"  # Affichage du résultat de la commande ansible
  ) &

  # Obtenir le PID du processus en arrière-plan
  pid=$!

  # Affichage de l'animation pendant que la commande ansible s'exécute
  loading $pid

  # Attendre que le processus de fond se termine (afin que l'animation s'arrête au bon moment)
  wait $pid

  # Vérification du code de retour de la commande Ansible
  if [ $? -eq 0 ]; then
    echo -e "Tous les hôtes sont accessibles !"
  else
    echo -e "${RED}Erreur de connectivité avec certains hôtes. Vérifiez les paramètres de connexion.${NC}"
    exit 1
  fi
}

# Début du script

# Vérification de la connectivité avec les hôtes
check_connectivity