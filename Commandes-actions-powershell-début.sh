
# Script multisupport qui s'exécute sur un server et agit sur des clients


# Actions sur les utilisateurs
    # Ajout d'utilisateur
    # Suppression d'utilisateur
    # Suspension d'utilisateur
    # Modification d'utilisateur
    # Changement de mot de passe

$Password = Read-Host -AsSecureString
$NewPassword = Read-Host -AsSecureString
$Password = $NewPassword | ConvertTo-SecureString -AsPlainText -Force 
Get-LocalUser -Name "Administrator" | Set-LocalUser -Password $NewPassword -UserMayChangePassword $true -PasswordNeverExpires $true
Write-Host " Mot de passe modifié avec succès "


    # Ajout à un groupe

$Group = Read-Host "Veuillez entrer le nom du groupe"
If ($Group)
{
    If (Test-Path $Group)
    {
        $User = Read-Host "Veuillez entrer le nom d'utilisateur"
        If ($User)
        {
            If (Test-Path $User)
            {
                Add-LocalGroupMember -Group $Group -Member $User
                Write-Host "L'utilisateur $User a bien été ajouté au groupe $Groupe ! "
            }
            Else
            {
                Write-Host "L'utilisateur n'existe pas"
                Exit
            }
        }
        Else
        {
            Write-Host "Merci de renseigner un nom d'utilisateur"
            Exit
        }
    }
    Else
    {
    Write-Host " Le groupe n'existe pas "
    Exit
    }
}
Else
{
    "Merci de renseigner le nom du groupe "
    Exit
}

    # Sortie d’un groupe

$Group = Read-Host "Veuillez entrer le nom du groupe"
$User = Read-Host "Veuillez entrer le nom d'utilisateur"
Remove-LocalGroupMember -Group $Group -Member $User
Write-Host "L'utilisateur $User a bien été supprimé du groupe $Groupe ! "

# Actions sur les ordinateurs clients
    # Arrêt

Stop-Computer -ComputerName "NomDuPC"

    # Redémarrage

Restart-Computer -ComputerName <nomDuPC>

    # Démarrage (wake-on-lan)

##############

    # Mise-à-jour du système
    # Verrouillage

logoff

    # Création de répertoire

$Localisation = Read-Host "Renseigner la localisation pour la création de dossier  "
If ($Localisation)
{
    If (Test-Path $Localisation)
    {
        $NewDir = Read-Host "Renseigner le nom de dossier à créer  "
        If ($NewDir)
        {
            If (Test-Path $NewDir)
            {
               Write-Host " Ce dossier existe déjà"
               Exit
            }
            Else
            {
                New-Item -Path $Localisation -ItemType Directory -Name $NewDir
                Write-Host "Dossier $NewDir créé avec succès"
            }
        }
        Else
        {
            Write-Host " Merci de renseigner un nom de dossier "
            Exit
        }
    }
    Else
    {
        Write-Host " Cet emplacement n'existe pas "
        Exit
    }
}
Else
{
    Write-Host " Merci de renseigner une localisation "
    Exit
}
    # Modification de répertoire

$Localisation2 = Read-Host "Renseigner la localisation complète du dossier à renommer  "
If ($Localisation2)
{

    If (Test-Path $Localisation2)
    {
         $NewNameDir = Read-Host " Renseignez le nouveau nom du dossier "
      Rename-Item -Path $Localisation2 $NewNameDir
         Write-Host "Dossier $NewDir renommé avec succès"
    }
    Else
    {
     Write-Host " Ce dossier n'existe pas "
     Exit
    }
}
Else
{
Write-Host " Vous devez renseigner un nom de dossier complet "
Exit
}

    # Suppression de répertoire

$Localisation3 = Read-Host "Renseigner la localisation complète du dossier à supprimer  "
If ($Localisation3)
{

    If (Test-Path $Localisation3)
    {
         
      Remove-Item -Path $Localisation3
         Write-Host "Dossier $NewDir supprimé avec succès"
    }
    Else
    {
     Write-Host " Ce dossier n'existe pas "
     Exit
    }
}
Else
{
Write-Host " Vous devez renseigner un nom de dossier complet "
Exit
}

    # Prendre la main à distance

$clientRemote = Read-Host " Merci de renseigner le nom du client pour la prise en main à distance "
$userRemoteRead-Host "Merci de renseigner le nom d'utilisateur "
Enter-PSSesssion -Computername $clientRemote -credential "WORKGROUP\$userRemote"

    # Définition de règles de pare-feu

######################

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
