#!/bin/sh

# Si la base de données n'existe pas encore, on l'installe
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then

    echo "Initialisation de la Database..."
    # Initialise les fichiers de base de données
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # On lance MySQL temporairement en tâche de fond (&)
    /usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql &

    # On attend que le serveur soit prêt (ping)
    sleep 5

    # --- C'est ICI qu'on crée l'utilisateur et le mot de passe ---
    # On utilise les variables d'env que tu passeras dans le 'docker run'

    echo "Création de la configuration SQL..."

    # Création de la DB
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

    # Création de l'utilisateur avec son mot de passe
    mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

    # On donne les droits
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"

    # Changement du mot de passe root (sécurité)
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

    # On applique les changements
    mysql -e "FLUSH PRIVILEGES;"

    # On éteint le serveur temporaire
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

    echo "Configuration terminée !"
fi

# On lance le vrai serveur en premier plan (pour que le conteneur ne quitte pas)
# --bind-address=0.0.0.0 permet d'accepter les connexions venant d'Adminer (hors localhost)
exec /usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0
