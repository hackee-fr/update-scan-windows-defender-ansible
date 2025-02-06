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

# Fonction de vérification des fichiers nécessaires
check_files() {
  local fichier=$1
  local message=$2

  echo -e "$message"
  (
    if [ ! -f "$fichier" ]; then
      echo -e "${RED}Fichier $fichier non trouvé!${NC}"
      exit 1  # Arrêter le script si un fichier est manquant
    else
      sleep 1  # Simuler un délai pour l'animation
    fi
  ) &

  loading $! "Vérification de l'existence de $fichier"
}

# Début du script

# Vérification des fichiers nécessaires
check_files "inventory.yaml" "Vérification de l'existence de l'inventaire..."
check_files "playbook.yaml" "Vérification de l'existence du playbook..."