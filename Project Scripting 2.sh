#! /bin/bash

# Script multisupport qui s'exécute sur un server et agit sur des clients


# Actions sur les utilisateurs
    # Ajout d'utilisateur
    # Suppression d'utilisateur
    # Suspension d'utilisateur
    # Modification d'utilisateur
    # Changement de mot de passe
    # Ajout à un groupe
    # Sortie d’un groupe

# Actions sur les ordinateurs clients
    # Arrêt
    # Redémarrage
    # Démarrage (wake-on-lan)
    # Mise-à-jour du système
    # Verrouillage
    # Création de répertoire
    # Modification de répertoire
    # Suppression de répertoire
    # Prendre la main à distance
    # Définition de règles de pare-feu

# L’ensemble des actions demandées et effectuées seront journalisées dans un fichier stocké 
# sur le serveur nommé log_actions.log
    # Sur le serveur Windows, dans C:\Windows\System32\LogFiles
    # Sur le serveur Debian, dans /var/log
#Les actions seront enregistrées sous la forme :
    #<Date>-<Heure>-<Utilisateur>-<Cible>-<TypeDAction> / yyyymmdd  hhmmss



# Informations sur les utilisateurs
    # Date de dernière connection d’un utilisateur
    # Date de dernière modification du mot de passe
    # Groupe d’appartenance d’un utilisateur
    # Droits/permissions de l’utilisateur

# Informations sur les ordinateurs
    # Version de l'OS
    # Espace disque restant
    # Taille de répertoire (qui sera demandé)
    # Liste des lecteurs
    # Adresse IP
    # Adresse Mac
    # Liste des applications/paquets installées
    # Type de CPU, nombre de coeurs, etc.
    # Mémoire RAM totale
    # Liste des ports ouverts
    # Statut du pare-feu
    # Liste des utilisateurs locaux

# Les informations qui seront affichées et/ou demandées seront automatiquement exportées 
# dans un fichier d’information nommé info_<Cible>_<Date>_<Heure>.txt  / yyyymmdd hhmmss
# Il sera stocké :
    # Sur le serveur Windows, dans C:\Users\<Utilisateur>\Desktop
    # Sur le serveur Debian, dans /home/<Utilisateur>/
