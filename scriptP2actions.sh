#!/bin/bash

# SCRIPT PROJET ACTIONS PAR JD

# ----------------------------- fonctions------------------------------

# ---------------------fonctions sur les machines-----------------

# Fonction d'arrêt

arreter() {

    ssh $user@$ipAddress "sudo -S shutdown -h now"

}

# Fonction de redémarrage

redemarrer() {

    ssh $user@$ipAddress "sudo -S reboot"

}

# Fonction de démarrage avec Wake-on-LAN

demarrer_wol() {

    mac_address="00:11:22:33:44:55" # Remplacez par l'adresse MAC de la machine distante

    wol_send_command="sudo -S etherwake -i enp0s3 $mac_address"

    ssh $user@serveur_wol "$wol_send_command"

}

# Fonction de mise à jour du système

mise_a_jour() {

    ssh $user@$ipAddress "sudo -S apt update && sudo -S apt upgrade -y"

}

# Fonction de verrouillage

verrouiller() {

    ssh $user@$ipAddress "sudo -S systemctl suspend"

}

# Fonction de dévérrouillage

deverrouiller() {

    ssh $user@$ipAddress "sudo -S systemctl suspend -i"

}

# Fonction de création de répertoire

creer_repertoire() {

    ssh $user@$ipAddress "mkdir /chemin/du/nouveau_repertoire"

}

# Fonction de modification de répertoire

modifier_repertoire() {

    ssh $user@$ipAddress "mv /ancien/repertoire /nouveau/repertoire"

}

# Fonction de suppression de répertoire

supprimer_repertoire() {

    ssh $user@$ipAddress "rm -r /chemin/du/repertoire_a_supprimer"

}

# Fonction pour prendre la main à distance (ex. SSH)

prendre_la_main() {

    ssh $user@$ipAddress

}

# Fonction pour définir des règles de pare-feu (ex. avec iptables)

definir_regles_pare_feu() {

    ssh $user@$ipAddress "sudo -S iptables -A INPUT -p tcp --dport 22 -j ACCEPT"

    ssh $user@$ipAddress "sudo -S iptables -A INPUT -j DROP"

}

#-------------------- fonctions sur les utilisateurs-------------------

# Fonction pour ajouter un utilisateur

ajouter_utilisateur() {

    local utilisateur=$1

    ssh $user@$ipAddress "sudo -S useradd $utilisateur"

}

# Fonction pour supprimer un utilisateur

supprimer_utilisateur() {

    local utilisateur=$1

    ssh $user@$ipAddress "sudo -S userdel -r $utilisateur"

}

# Fonction pour suspendre un utilisateur

suspendre_utilisateur() {

    local utilisateur=$1

    ssh $user@$ipAddress "sudo -S usermod -L $utilisateur"

}

# Fonction pour modifier un utilisateur

modifier_utilisateur() {

    local utilisateur=$1

    local nouveau_nom=$2

    ssh $user@$ipAddress "sudo -S usermod -l $nouveau_nom $utilisateur"

}

# Fonction pour changer le mot de passe d'un utilisateur

changer_mot_de_passe() {

    local utilisateur=$1

    ssh $user@$ipAddress "sudo -S passwd $utilisateur"

}

# Fonction pour ajouter un utilisateur à un groupe

ajouter_au_groupe() {

    local utilisateur=$1

    local groupe=$2

    ssh $user@$ipAddress "sudo -S usermod -aG $groupe $utilisateur"

}

# Fonction pour sortir un utilisateur d'un groupe

sortir_du_groupe() {

    local utilisateur=$1

    local groupe=$2

    ssh $user@$ipAddress "sudo -S deluser $utilisateur $groupe"

}

#----------------------------- connection distante machine --------------------------------

# Demander le nom de l'utilisateur

read -p "Entrez l'identifiant (utilisateur) pour accéder au client : " user

# Demander l'adresse IP

read -p "Entrez l'adresse IP de la machine cible: " ipAddress

#---------------------- sous menu machines--------------------------

menu_machines() {

while true; do

    clear

        echo "Menu machines"

        echo "1. Arrêt de la machine"

        echo "2. Redémarrage de la machine"

        echo "3. Démarrage via Wake-on-LAN"

        echo "4. Mise à jour du système"

        echo "5. Verrouillage de la machine"

        echo "6. Dévérouillage de la machine"

        echo "7. Création de répertoire"

        echo "8. Modification de répertoire"

        echo "9. Suppression de répertoire"

        echo "10. Prendre la main à distance"

        echo "11. Définition de règles de pare-feu"

        echo "12. Retour menu principal"

        echo "13. Quitter"

   read -p "Choisissez une option de 1 à 13 : " choix

    case $choix in

        1)
            arreter
            ;;

        2)
            redemarrer
            ;;
        3)
            read -p "Adresse MAC de la machine cible: " demarrer_wol
            ;;
        4)
            mise_a_jour
            ;;
        5)
            verrouiller
            ;;
        6)  
            deverrouiller
            ;;
        7)
            read -p "Nom du répertoire à créer: " dirname

            creer_repertoire
            ;;
        8)
            read -p "Nouveau chemin du répertoire: " newdir

            ssh "$user@$ipAddress" "mv ancien_chemin $newdir"

            modifier_repertoire
            ;;

        9)

            read -p "Répertoire à supprimer: " dirname

            ssh "$user@$ipAddress" "rm -r $dirname"

            supprimer_repertoire
            ;;

        10)
        	prendre_la_main

            ssh "$user@$ipAddress" "your_remote_access_command_here"
            ;;

        11)
        definir_regles_pare_feu
            ;;

        12) 
            retour_menu_principal
            ;; 

        13)

            echo "See you!"

            exit 0
            ;;

        *)

            echo "Option invalide. Veuillez choisir une option valide (1-11)."

            ;;
    esac

    read -p "Appuyez sur Entrée pour continuer..."

done

}

#-----------------sous menu utilisateurs --------------------------------

# Fonction pour exécuter un menu utilisateur

menu_utilisateurs() {

    while true; do

        clear

        echo "Menu utilisateurs"

  	    echo "1. Ajouter un utilisateur"

   	    echo "2. Supprimer un utilisateur"

        echo "3. Suspension d'un utilisateur"

        echo "4. Modifier un utilisateur"

   	    echo "5. Changer le mot de passe d'un utilisateur"

   	    echo "6. Ajouter un utilisateur à un groupe"

   	    echo "7. Sortir un utilisateur d'un groupe"

        echo "8. Retour menu principal"

   	    echo "9. Quitter"

    read -p "Choisissez une option : " choix

    case $choix in

   	 1)
            read -p "Nom de l'utilisateur à ajouter : " utilisateur

            ajouter_utilisateur "$utilisateur"
            ;;

        2)
            read -p "Nom de l'utilisateur à supprimer : " utilisateur

            supprimer_utilisateur "$utilisateur"
            ;;

        3)
            read -p "Nom de l'utilisateur à suspendre : " utilisateur

            suspendre_utilisateur "$utilisateur"
            ;;

        4)
            read -p "Nom de l'utilisateur à modifier : " utilisateur

            read -p "Nouveau nom d'utilisateur : " nouveau_nom

            modifier_utilisateur "$utilisateur" "$nouveau_nom"
            ;;

        5)
            read -p "Nom de l'utilisateur à modifier le mot de passe : " utilisateur

            changer_mot_de_passe "$utilisateur"
            ;;

        6)
            read -p "Nom de l'utilisateur : " utilisateur

            read -p "Nom du groupe : " groupe

            ajouter_au_groupe "$utilisateur" "$groupe"
            ;;

        7)
            read -p "Nom de l'utilisateur : " utilisateur

            read -p "Nom du groupe : " groupe

            sortir_du_groupe "$utilisateur" "$groupe"
            ;;

        8)  
            retour_menu_principal
            ;;

        9)
            echo "See you!"

            exit 0
            ;;

        *)

            echo "Option non valide. Veuillez saisir un nombre de 1 à 9."
            ;;

        esac

        read -p "Appuyez sur Entrée pour continuer..."

    done

}

#-----------------retour menu principal --------------------------------

retour_menu_principal() {

    while true; do

    clear

	echo "Menu principal"

	echo "1. Menu utilisateurs"

	echo "2. Menu machines"

	echo "3. Menu informations"

	echo "4. Quitter"

    read -p "Choisissez une option : " choix

	case $choix in

        1)
		    menu_utilisateurs
		    ;;

        2) 
            menu_machines
            ;;

        3)
            echo "fonction de Thomas à implanter"
            ;;

        4)	
            echo "See you !"

            exit 0
            ;;

        *) 
            echo "option invalide, choix de 1 à 4"
            ;;

	esac	

done

}


#--------------------------menu principal ------------------------------------------

# Menu principal

while true; do

    clear

	echo "Menu principal"

	echo "1. Menu utilisateurs"

	echo "2. Menu machines"

	echo "3. Menu informations"

	echo "4. Quitter"

read -p "Choisissez une option : " choix

	case $choix in

        1)
            menu_utilisateurs
            ;;

        2) 
            menu_machines
            ;;

        3)

            echo "fonction à déterminer"
            
            sleep 2

            ;;

        4)	

            echo "See you !"

            exit 0
            ;;

        *) 
            echo "option invalide, choix de 1 à 4"
            ;;

	esac	

done

