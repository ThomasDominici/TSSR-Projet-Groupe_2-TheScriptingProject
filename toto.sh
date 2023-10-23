#!/bin/bash

# SCRIPT PROJET 2

# ----------------------------- variables------------------------------

read -p "Merci de renseigner le nom de l'administrateur : " admin
admin=$admin
if [ -z $admin ]
			then
				echo "Merci de rentrer un nom d'administrateur"
				echo "Sortie de script "
				exit
			else
				if [ -d $admin ]
				then
					echo "Nom d'administrateur enregistrée"
				else
					echo "Nom d'administrateur non existant"
					echo "Sortie de script "
					exit
				fi
fi

#-------------------- fonctions sur les utilisateurs-------------------
	# Fonction pour ajouter un utilisateur
		ajouter_utilisateur() {

    	local utilisateur=$1

    	ssh $user@$ipAddress "sudo -S useradd $utilisateur"
	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  ajoutUser" >> /var/log/log_actions.log
	}

	# Fonction pour supprimer un utilisateur
		supprimer_utilisateur() {

   		local utilisateur=$1

  		ssh $user@$ipAddress "sudo -S userdel -r $utilisateur"
  		echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  suppUser" >> /var/log/log_actions.log

	}

	# Fonction pour suspendre un utilisateur
		suspendre_utilisateur() {

    	local utilisateur=$1

    	ssh $user@$ipAddress "sudo -S usermod -L $utilisateur"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  suspendreUser" >> /var/log/log_actions.log

	}

	# Fonction pour modifier un utilisateur
		modifier_utilisateur() {

    	local utilisateur=$1

    	local nouveau_nom=$2

    	ssh $user@$ipAddress "sudo -S usermod -l $nouveau_nom $utilisateur"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  modifUser" >> /var/log/log_actions.log

		}

	# Fonction pour changer le mot de passe d'un utilisateur
		changer_mot_de_passe() {

    	local utilisateur=$1

    	ssh $user@$ipAddress "sudo -S passwd $utilisateur"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  mdpUser" >> /var/log/log_actions.log

		}

	# Fonction pour ajouter un utilisateur à un groupe
		ajouter_au_groupe() {

    	local utilisateur=$1

   		local groupe=$2

    ssh $user@$ipAddress "sudo -S usermod -aG $groupe $utilisateur"
    echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  addGroupUser" >> /var/log/log_actions.log

	}

	# Fonction pour sortir un utilisateur d'un groupe

		sortir_du_groupe() {

    	local utilisateur=$1

    	local groupe=$2

    	ssh $user@$ipAddress "sudo -S deluser $utilisateur $groupe"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  delGroupUser" >> /var/log/log_actions.log

	}


# --------------------fonctions sur les machines-----------------

	# Fonction d'arrêt

		arreter() {

   	 	ssh $user@$ipAddress "sudo -S shutdown -h now" 
   	 	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  arretMachine" >> /var/log/log_actions.log
		}

	# Fonction de redémarrage

		redemarrer() {

    	ssh $user@$ipAddress "sudo -S reboot"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  rebootMachine" >> /var/log/log_actions.log

		}

	# Fonction de démarrage avec Wake-on-LAN

		demarrer_wol() {

    	mac_address="00:11:22:33:44:55" # Remplacez par l'adresse MAC de la machine distante

    	wol_send_command="sudo -S etherwake -i enp0s3 $mac_address"

    	ssh $user@serveur_wol "$wol_send_command"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin wakeOnLan" >> /var/log/log_actions.log

		}

	# Fonction de mise à jour du système

		mise_a_jour() {

    	ssh $user@$ipAddress "sudo -S apt update && sudo -S apt upgrade -y"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  miseAJourMachine" >> /var/log/log_actions.log

		}		

	# Fonction de verrouillage

		verrouiller() {

    	ssh $user@$ipAddress "sudo -S systemctl suspend"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  lockMachine" >> /var/log/log_actions.log

		}

	# Fonction de dévérrouillage

		deverrouiller() {

    	ssh $user@$ipAddress "sudo -S systemctl suspend -i"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  unlockMachine" >> /var/log/log_actions.log

		}

	# Fonction de création de répertoire

		creer_repertoire() {

    	ssh $user@$ipAddress "mkdir /chemin/du/nouveau_repertoire"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  CreationDossier" >> /var/log/log_actions.log

	}

	# Fonction de modification de répertoire

		modifier_repertoire() {

    	ssh $user@$ipAddress "mv /ancien/repertoire /nouveau/repertoire"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  modificationDossier" >> /var/log/log_actions.log

		}

	# Fonction de suppression de répertoire

		supprimer_repertoire() {

    	ssh $user@$ipAddress "rm -r /chemin/du/repertoire_a_supprimer"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  suppressionDossier" >> /var/log/log_actions.log

		}

	# Fonction pour prendre la main à distance (ex. SSH)

		prendre_la_main() {

   		ssh $user@$ipAddress
   		echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  ssh" >> /var/log/log_actions.log

		}

	# Fonction pour définir des règles de pare-feu (ex. avec iptables)

	definir_regles_pare_feu() {

    	ssh $user@$ipAddress "sudo -S iptables -A INPUT -p tcp --dport 22 -j ACCEPT"

    	ssh $user@$ipAddress "sudo -S iptables -A INPUT -j DROP"
    	echo " $(date "+%F")_$(date "+%H:%M:%S")_$admin  firewallDefinition" >> /var/log/log_actions.log

	}


#---------------------fonctions informations utilisateurs--------------

 	# 1 - Date de dernière connection d’un utilisateur
       	lastUserConnection()
		{
		ssh $user@$ipAddress last $user | head -n 1 >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
		echo "Résultats enregistrés dans le fichier export"
	
		}

	# 2 - Date de dernière modification du mot de passe
  		lastPasswdModif()
		{
		ssh $user@$ipAddress passwd -S $user | awk '{print $3}' >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
		echo "Résultats enregistrés dans le fichier export"
		}

	# 3 - Groupe d’appartenance d’un utilisateur
		userGroupId()
		{
		ssh $user@$ipAddress id $user | awk '{print $2}' >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
		echo "Résultats enregistrés dans le fichier export"
		}

	# 4 - Droits/permissions de l’utilisateur
		userPermits()
		{
		ssh $user@$ipAddress ls -larth >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
		echo "Résultats enregistrés dans le fichier export"
		}
		
		
#---------------------fonctions informations ordinateurs
		
	# 1 - Version de l'OS
		osVersion()
		{
		ssh $user@$ipAddress lsb_release -d >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
		echo "Résultats enregistrés dans le fichier export"
		}	
		
		
	# 2 - Espace disque restant
		diskEmptySpace()
		{
		ssh $user@$ipAddress df -h >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt	
		echo "Résultats enregistrés dans le fichier export"
		}	
		
	# 3 - Taille de répertoire (qui sera demandé)
		directorySize()
		{
		read -p "Indiquez le répertoire désiré : " repertoire
		ssh $user@$ipAddress "if [ -z $repertoire ]
			then
				echo "Merci de rentrer un nom de répertoire"
				echo "Sortie de script "
				exit
			else
				if [ -d $repertoire ]
				then
					du -sh $repertoire
					sleep 5
				else
					echo "Nom de répertoire non existant"
					echo "Sortie de script "
					exit
				fi
			fi" >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
			echo "Résultats enregistrés dans le fichier export"
				
		}

	# 4 - Liste des lecteurs 
		blockDevicesList()
		{
		ssh $user@$ipAddress lsblk >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
		echo "Résultats enregistrés dans le fichier export"
		}
		
	# 5 - Adresse IP
		ipAddress()
		{
		echo "Non fonctionnelle"
		}

	# 6 - Adresse MAC
		macAddress()
		{
		ssh $user@$ipAddress ip a >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
		echo "Résultats enregistrés dans le fichier export"
		}

	# 7 - Liste des applications/paquets installés
		appsList()
		{
		ssh $user@$ipAddress "dpkg --list > paquets.txt
			cat paquets.txt
			sleep 15" >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt	
			echo "Résultats enregistrés dans le fichier export"	
		}

	# 8 - Type de CPU, nombre de coeurs ...
		cpuInfos()
		{
			ssh $user@$ipAddress cat /proc/cpuinfo >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
			echo "Résultats enregistrés dans le fichier export"
		}

	# 9 - Mémoire RAM totale
		ramMemory()
		{
			ssh $user@$ipAddress free -h >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
			echo "Résultats enregistrés dans le fichier export"
		}

	# 10 - Liste des ports ouverts 
		openPortsList()
		{
			ssh $user@$ipAddress ss -tulnp >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
			echo "Résultats enregistrés dans le fichier export"
		}

	# 11 - Statut du pare-feu (en sudo)
		firewallStatus()
		{
			#ssh $user@$ipAddress ufw status >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
			echo "Non fonctionnelle"
		}

	# 12 - Liste des utilisateurs locaux
		localUsersList()
		{
			ssh $user@$ipAddress cut -d: -f1 /etc/passwd >> $admin/export/info_$user_$(date "+%F")_$(date "+%H:%M:%S").txt
			echo "Résultats enregistrés dans le fichier export"
		}

#---------------------fonctions choix machine --------------------------------
	choisir_machine() {

		read -p "Entrez l'identifiant (utilisateur) pour accéder au client : " user

		read -p "Entrez l'adresse IP de la machine cible: " ipAddress

	}

	demander_autre_machine() {
    	read -p "Voulez-vous intervenir sur une autre machine ? (Oui/Non) : " choix
   		if [[ "$choix" == "Oui" || "$choix" == "oui" ]]; then
        choisir_machine
    	fi
	}


#----------------------------------------------------------------------
#----------------------MENUS--------------------------------------
#---------------------Sous menu machines--------------------------
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
					choisir_machine
					arreter
					;;

				2)
					choisir_machine
					redemarrer
					;;
				3)
					choisir_machine
					read -p "Adresse MAC de la machine cible: " demarrer_wol
					;;
				4)
					choisir_machine
					mise_a_jour
					;;
				5)
					choisir_machine
					verrouiller
					;;
				6)  
					choisir_machine
					deverrouiller
					;;
				7)
					choisir_machine
					read -p "Nom du répertoire à créer: " dirname
					creer_repertoire
					;;
				8)
					choisir_machine
					read -p "Nouveau chemin du répertoire: " newdir

					ssh "$user@$ipAddress" "mv ancien_chemin $newdir"

					modifier_repertoire
					;;

				9)
					choisir_machine
					read -p "Répertoire à supprimer: " dirname

					ssh "$user@$ipAddress" "rm -r $dirname"

					supprimer_repertoire
					;;

				10)
					choisir_machine
					prendre_la_main

					ssh "$user@$ipAddress" "your_remote_access_command_here"
					;;

				11)
					choisir_machine
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

#---------------------Sous menu utilisateurs -------------------------------
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
				choisir_machine
				read -p "Nom de l'utilisateur à ajouter : " utilisateur

				ajouter_utilisateur "$utilisateur"
				;;

			2)
				choisir_machine
				read -p "Nom de l'utilisateur à supprimer : " utilisateur

				supprimer_utilisateur "$utilisateur"
				;;

			3)
				choisir_machine
				read -p "Nom de l'utilisateur à suspendre : " utilisateur

				suspendre_utilisateur "$utilisateur"
				;;

			4)
				choisir_machine
				read -p "Nom de l'utilisateur à modifier : " utilisateur

				read -p "Nouveau nom d'utilisateur : " nouveau_nom

				modifier_utilisateur "$utilisateur" "$nouveau_nom"
				;;

			5)
				choisir_machine
				read -p "Nom de l'utilisateur à modifier le mot de passe : " utilisateur

				changer_mot_de_passe "$utilisateur"
				;;

			6)
				choisir_machine
				read -p "Nom de l'utilisateur : " utilisateur

				read -p "Nom du groupe : " groupe

				ajouter_au_groupe "$utilisateur" "$groupe"
				;;

			7)
				choisir_machine
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
#---------------------Sous menu informations --------------------------------------------------

	menu_informations() {


	while true
	do
	clear
	echo " Quel type d'information désirez-vous ? "
	echo " 1 - Informations sur les utilisateurs "
	echo " 2 - Informations sur les ordinateurs "
	echo " 3 - Retour menu principal "
	echo " 4 - Sortie du script " 

	read -p "Choississez une option : " choice1
	case $choice1 in 
		1)
			echo " Quelle information souhaitez-vous obtenir ? "
			echo " 1 - Date de dernière connection d'un utilisateur "
			echo " 2 - Date de dernière modification du mot de passe "
			echo " 3 - Groupe d'appartenance d'un utilisateur " 
			echo " 4 - Droits/permissions de l'utilisateur "
			echo " 5 - Retour menu principal "
			echo " 6 - Sortie du script "
			read -p "Choississez une option : " choice2

				case $choice2 in 
					1) 
						choisir_machine
						lastUserConnection
						sleep 5
						clear;;
					2) 
						choisir_machine
						lastPasswdModif
						sleep 5
						clear;;
					3) 
						choisir_machine
						userGroupId
						sleep 5
						clear;;
					4)	
						choisir_machine
						userPermits
						sleep 5 
						clear;;
					5)
						retour_menu_principal
						;;
					6)
						echo "Sortie du script"
						exit;;
					7)
						echo "Choix entre 1 et 6"
						exit;;
					esac;;
					
					
		2)
			echo " Quelle information souhaitez-vous obtenir ? "
			echo " 1 - Version de l'OS "
			echo " 2 - Espace disque restant "
			echo " 3 - Taille de répertoire (qui sera demandé) "
			echo " 4 - Liste des lecteurs "
			echo " 5 - Adresse IP "
			echo " 6 - Adresse Mac "
			echo " 7 - Liste des applications/paquets installées "
			echo " 8 - Type de CPU, nombre de coeurs ... "
			echo " 9 - Mémoire RAM totale "
			echo " 10 - Liste des ports ouverts "
			echo " 11 - Statut du pare-feu "
			echo " 12 - Liste des utilisateurs locaux "
			echo " 13 - Retour menu principal "
			echo " 14 - Sortie du script "
			read -p "Choississez une option : " choice3
			
				case $choice3 in
					1)
						choisir_machine
						osVersion
						sleep 3
						clear;;
					2)
						choisir_machine
						diskEmptySpace
						sleep 3 
						clear;;
					3)
						choisir_machine
						directorySize 
						sleep 3
						clear;;
					4)
						choisir_machine
						blockDevicesList
						sleep 3 
						clear;;
					5)
						choisir_machine
						ipAddress
						sleep 3 
						clear;;
					6)
						choisir_machine
						macAddress
						sleep 3 
						clear;;
					7)
						choisir_machine
						appsList
						clear;;
					8)
						choisir_machine
						cpuInfos
						sleep 3 
						clear;;
					9)
						choisir_machine
						ramMemory
						sleep 3 
						clear;;
					10)
						choisir_machine
						openPortsList
						sleep 3
						clear;;
					11)
						choisir_machine
						firewallStatus
						sleep 3 
						clear;;
					12)
						choisir_machine
						localUsersList
						sleep 3 
						clear;;
					13)
						retour_menu_principal
						clear;;

					14)
						echo "Sortie du script "
						exit;;
					15)
						echo "Choix entre 1 et 14"
						exit;;
						
		
				esac;;
		3) 
			retour_menu_principal
			;;
				
		4) 
			echo "Sortie du script "
			exit
			
	esac
	done

	}


#---------------------fonction retour menu principal --------------------------------

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
				menu_informations
				;;

			4)	
				echo "See you !"

				exit 0
				;;

			*) 
				echo "option invalide, choix de 1 à 4"
				exit;;

		esac	

	done

	}
#---------------------MAIN-menu principal ------------------------------------------
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

				menu_informations
				
				sleep 2

				;;

			4)	

				echo "See you !"

				exit 0
				;;

			*) 
				echo "option invalide, choix de 1 à 4"
				exit;;

		esac	

	done


