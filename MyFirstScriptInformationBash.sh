#! /bin/bash


read -p "Veuillez entrer le nom d'utilisateur : " user
read -p "Veuillez entrer l'adresse IP de la machine cible : " ipAddress

user=$user
ipAddress=$ipAddress

#----------------------------------------------------------------------------------------------------------

#Création de fonction SSH
#	sshLogin()
#	{
#		ssh $user@$ipAddress
#	}


#----------------------------------------------------------------------------------------------------------

#Création des fonctions informations utilisateurs

 # 1 - Date de dernière connection d’un utilisateur
        lastUserConnection ()
	{
		ssh $user@$ipAddress last $user | head -n 1
	}

# 2 - Date de dernière modification du mot de passe
  	lastPasswdModif ()
 	{
 		ssh $user@$ipAddress passwd -S $user | awk '{print $3}'
 	}

# 3 - Groupe d’appartenance d’un utilisateur
  	userGroupId ()
	{
		ssh $user@$ipAddress id $user | awk '{print $2}'
	}

# 4 - Droits/permissions de l’utilisateur
	userPermits ()
	{
		ssh $user@$ipAddress ls -larth
	}
	
#----------------------------------------------------------------------------------------------------------

#Création des fonctions informations ordinateurs
	
	
# 1 - Version de l'OS
	osVersion ()
	{
		ssh $user@$ipAddress lsb_release -d
    	}	
	
	
# 2 - Espace disque restant
        diskEmptySpace ()
	{
     		ssh $user@$ipAddress df -h	
	}	
	
# 3 - Taille de répertoire (qui sera demandé)
	directorySize ()
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
		fi"
			
	}

# 4 - Liste des lecteurs 
	blockDevicesList ()
	{
		ssh $user@$ipAddress lsblk
	}
	
# 5 - Adresse IP
	ipAddress ()
	{
		ssh $user@$ipAddress echo "IP ADDRESS = "`ip a s enp0s3 | grep "inet " | cut -f6 -d" "`
	}

# 6 - Adresse MAC
	macAddress ()
	{
		ssh $user@$ipAddress ip a
	}

# 7 - Liste des applications/paquets installés
	appsList ()
	{
		ssh $user@$ipAddress "dpkg --list > paquets.txt
		cat paquets.txt
		sleep 15"		
	}

# 8 - Type de CPU, nombre de coeurs ...
	cpuInfos ()
	{
		ssh $user@$ipAddress cat /proc/cpuinfo
	}

# 9 - Mémoire RAM totale
	ramMemory ()
	{
		ssh $user@$ipAddress free -h
	}

# 10 - Liste des ports ouverts 
	openPortsList ()
	{
		ssh $user@$ipAddress ss -tulnp
	}

# 11 - Statut du pare-feu (en sudo)
	firewallStatus ()
	{
		ssh $user@$ipAddress ufw status
	}

# 12 - Liste des utilisateurs locaux
	localUsersList ()
	{
		ssh $user@$ipAddress cut -d: -f1 /etc/passwd
	}

#--------------------------------------MAIN--------------------------------------------------


while true
do
clear
echo " Quel type d'information désirez-vous ? "
echo " 1 - Informations sur les utilisateurs "
echo " 2 - Informations sur les ordinateurs "
echo " 3 - Sortie du script " 

read -p "Choississez une option : " choice1
case $choice1 in 
	1)
		echo " Quelle information souhaitez-vous obtenir ? "
		echo " 1 - Date de dernière connection d’un utilisateur "
		echo " 2 - Date de dernière modification du mot de passe "
		echo " 3 - Groupe d’appartenance d’un utilisateur " 
		echo " 4 - Droits/permissions de l'utilisateur "
		echo " 5 - Sortie du script "
		read -p "Choississez une option : " choice2

			case $choice2 in 
				1) 
					lastUserConnection
			                sleep 5
			                clear;;
				2) 
 			                lastPasswdModif
			                sleep 5
			                clear;;
				3) 
			                userGroupId
			                sleep 5
 			                clear;;
				4)	
					userPermits
					sleep 5 
					clear;;
				5)
					echo "Sortie du script"
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
		echo " 13 - Sortie du script "
		read -p "Choississez une option : " choice3
		
			case $choice3 in
				1)
					osVersion
					sleep 5 
					clear;;
				2)
					diskEmptySpace
					sleep 5 
					clear;;
				3)
					directorySize 
					sleep 5 
					clear;;
				4)
					blockDevicesList
					sleep 5 
					clear;;
				5)
					ipAddress
					sleep 10 
					clear;;
				6)
					macAddress
					sleep 10 
					clear;;
				7)
					appsList
					clear;;
				8)
					cpuInfos
					sleep 5 
					clear;;
				9)
					ramMemory
					sleep 5 
					clear;;
				10)
					openPortsList
					sleep 5 
					clear;;
				11)
					firewallStatus
					sleep 5 
					clear;;
				12)
					localUsersList
					sleep 5 
					clear;;
				13)
					echo "Sortie du script "
					exit;;
					
	
			esac;;
			
	3) 
		echo "Sortie du script "
		exit
		
esac
done
exit 0
