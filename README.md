
# Update & Scan Windows Defender with Ansible

Ce projet utilise Ansible pour automatiser la mise à jour et le scan de **Windows Defender** sur des hôtes Windows. Il permet également de configurer des proxys pour les hôtes si nécessaire et d'organiser des tâches planifiées de mise à jour et de scan.

## Table des matières

- [Prérequis](#prérequis)
- [Structure du projet](#structure-du-projet)
- [Installation](#installation)
- [Configuration](#configuration)
- [Utilisation](#utilisation)
- [Scripts supplémentaires](#scripts-supplémentaires)
<!-- - [Contribuer](#contribuer)
- [Licence](#licence) -->

## Prérequis

Avant de commencer, assurez-vous d'avoir les éléments suivants :

- [Ansible](https://www.ansible.com/) installé sur votre machine de contrôle.
- Accès aux hôtes Windows sur lesquels vous souhaitez exécuter les tâches.
- Les privilèges administratifs nécessaires pour effectuer des mises à jour et des scans via Windows Defender.
- Un serveur SSH actif ou WinRM configuré pour Ansible.

## Structure du projet

Voici la structure des répertoires du projet :

```
update-scan-windows-defender-ansible/
│
├── group_vars               # Variables globales pour les groupes d'hôtes
│   └── windows_client_group_vars.yaml
│
├── host_vars                # Variables spécifiques à des hôtes
│   └── win-client-01.yaml
│
├── roles/
│   ├── av_update/
│   │   ├── tasks/
│   │   │   ├── add_proxy.yaml
│   │   │   ├── update.yaml
│   │   │   ├── scan.yaml
│   │   │   ├── schedule.yaml
│   │   │   └── remove_proxy.yaml
│   │   │
│   │   └── vars/
│   │       └── main_vars.yaml
│
├── sh                        # Scripts shell pour automatisation
│   ├── check_connectivity.sh  # Vérifie la connectivité réseau
│   ├── check_files.sh         # Vérifie les fichiers nécessaires
│   └── run_playbook.sh        # Lance le playbook Ansible
│
├── .gitignore               # Fichiers ignorés par Git
├── README.md                # Documentation du projet
├── playbook.yaml           # Playbook Ansible pour la mise à jour et le scan
├── inventory.yaml           # Liste des hôtes cibles
├── ansible.cfg              # Configuration d'Ansible
└── start.sh                 # Script de démarrage  
```

## Installation

### Cloner le repository

Tout d'abord, clonez ce repository sur votre machine locale :

```bash
git clone https://github.com/yourusername/update-scan-windows-defender-ansible.git
cd update-scan-windows-defender-ansible
```

### Installer Ansible

Si vous n'avez pas encore installé Ansible, vous pouvez l'installer en suivant la documentation officielle : [Installation d'Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html).

## Configuration

1. **Inventory File (inventory.yaml)** : 
    - Ajoutez les hôtes Windows sur lesquels vous souhaitez exécuter le playbook.
    
    Exemple :

    ```yaml
    windows_client_group_vars:
      hosts:
        win-client-01:
          ansible_host: 192.168.0.20  # Adresse IP de l'hôte
    ```

2. **Group Variables (group_vars/windows_client_group_vars.yaml)** : 
    - Configurez les variables spécifiques à vos groupes d'hôtes, comme les proxys ou d'autres options personnalisées.

3. **Host Variables (host_vars/win-client-01.yaml)** : 
    - Spécifiez des variables spécifiques pour chaque hôte si nécessaire.

## Utilisation

### Lancer le Playbook

Pour lancer le playbook de mise à jour et de scan de Windows Defender, utilisez la commande suivante :

```bash
ansible-playbook -i inventory.yaml playbook.yaml
```

Ce playbook exécute plusieurs tâches sur les hôtes cibles :

1. **Ajout du proxy (si nécessaire)** : Configure un proxy pour accéder à Internet.
2. **Mise à jour de Windows Defender** : Met à jour la base de données de Windows Defender.
3. **Scan de Windows Defender** : Effectue une analyse complète du système.
4. **Planification des scans** : Si nécessaire, planifie les scans réguliers de Windows Defender.

### Script de démarrage

Si vous souhaitez automatiser le démarrage de ces actions, vous pouvez exécuter le script `start.sh` :

```bash
./start.sh
```

Ce script configure et exécute les tâches nécessaires en fonction de votre environnement.

## Scripts supplémentaires

- **check_connectivity.sh** : Vérifie la connectivité réseau avec les hôtes cibles.
- **check_files.sh** : Vérifie si tous les fichiers nécessaires à l'exécution du playbook sont présents.
- **run_playbook.sh** : Lance le playbook automatiquement, ce qui permet d'éviter de taper la commande manuellement.

<!-- ## Contribuer

Si vous souhaitez contribuer à ce projet, vous pouvez :

1. Forker le repository
2. Créer une nouvelle branche (`git checkout -b feature/ma-nouvelle-fonctionnalite`)
3. Ajouter vos modifications
4. Soumettre une Pull Request

## Licence

Ce projet est sous la licence [MIT License](LICENSE). -->