# Architetcure

```shell
ansible-av-update/
│── inventory.yaml         # Fichier d'inventaire avec les machines Windows
│── playbook.yaml          # Playbook principal pour la mise à jour AV
│── group_vars/
│   ├── windows_server_vars.yaml
│   └── windows_client_vars.yaml       # Variables spécifiques aux machines Windows
│── roles/
│   └── av_update/        # Rôle dédié pour l'update AV
│       ├── tasks/
│       │   ├── main.yaml  # Fichier principal des tâches
│       │   ├── update.yaml  # Tâche pour update AV
│       │   ├── scan.yaml    # Tâche pour lancer un scan
│       │   ├── schedule.yaml  # Tâche pour planifier l'update
│       ├── handlers/
│       │   ├── main.yaml  # Fichier des handlers (ex : redémarrage)
│       ├── templates/    # (si besoin de fichiers de conf)
│       ├── files/        # (si besoin de scripts à copier)
│       ├── vars/
│       │   ├── main_vars.yaml  # Variables spécifiques au rôle
└── ansible.cfg           # Configuration Ansible (si besoin)
```


💡 Sécurité : Pense à chiffrer ce fichier avec Ansible Vault :

```bash
ansible-vault encrypt group_vars/windows.yml
```

Exécuter le Playbook
Lance l'automatisation sur toutes les machines :
```bash
ansible-playbook -i inventory.yml playbook.yml
```

Si le mot de passe est chiffré avec Ansible Vault, utilise :
```bash
ansible-playbook -i inventory.yml playbook.yml --ask-vault-pass
```