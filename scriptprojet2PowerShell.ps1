###########################################
#            M. Dhauyre Jerome            #
#           M. Dominici $cred            #
#         M. Del Ciotto Vincent           #
#          Projet "MyFirstScript"         #
#     Le but du projet est de pouvoir     #
#        interagir depuis un serveur      # 
#    vers different client avec des OS    # 
#              different                  #
# Le Projet a commencer le lundi 9 octobre#
#       Version 0.1 Menu fonctionnel      #
###########################################

#------------------Variable------------------#

$cli = Read-host "Quelle est le nom de la machine sur laquelle vous voulez intervenir ?"
$cred = Read-Host "Sur quel utilisateur voulez vous vous connecter ?"
#------------------Fonction------------------#

#Ajout d'un Utilisateur

function newUser { Invoke-command -computername $cli -Credential $cred -scriptblock { $newUser = Read-Host "Merci de renseigner un nom d'utilisateur à ajouter"
If ($newUser)
{
    If (-not(Get-LocalUser | Where-Object {$_.name -like $($newUser)}))
    {
        $newPassword = Read-Host "Merci de renseigner le mot de passe de cet utilisateur "
        If ($newPassword)
        {
            New-LocalUser -Name $newUser -Password (Convertto-securestring -asplaintext $($newPassword) -Force )
            Write-Host "L'utilisateur $newUser a bien été créé "
        }
        Else
        {
            Write-Host "Merci de renseigner un mot de passe"

        }
    }
    Else
    {
        Write-Host "Cet utilisateur existe déjà"
    }
}
Else
{
Write-Host "Merci de renseigner un nom d'utilisateur à ajouter"

} 
}

#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Utilisateur crée le $($LogDate)" | Out-File -Append -FilePath $($LogPath)

}

#Modification d'un utilisateur

function renameUser { Invoke-command -computername $cli -Credential $cred -scriptblock { $UserToRename = Read-Host "Merci de renseigner un nom d'utilisateur à renommer"
If ($UserToRename)
{
    If (Get-LocalUser | Where-Object {$_.name -like $($UserToRename)})
    {
        $newNameUser = Read-Host "Merci de renseigner un nouveau nom d'utilisateur "
        If ($newNameUser)
        {
            If (Get-LocalUser | Where-Object {$_.name -like $($newNameUser)})
            {
                Write-Host "Ce nom d'utilisateur existe déjà"
            }
            Else
            {
                Rename-LocalUser -Name $UserToRename -NewName $newNameUser
                Write-Host "L'utilisateur $UserToRename a bien été renommé en $newNameUser "
            }
        }
        Else
        {
            Write-Host "Merci de renseigner un nouveau nom d'utilisateur"

        }
    }
    Else
    {
        Write-Host "Cet utilisateur n'existe pas"
    }
}
Else
{
Write-Host "Merci de renseigner un nom d'utilisateur à renommer"

} 
}

#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Utilisateur renommé le $($LogDate)" | Out-File -Append -FilePath $($LogPath)

}

#Suppression d'un utilisateur

function delUser { Invoke-command -computername $cli -Credential $cred -scriptblock { $delUser = Read-Host "Merci de renseigner un nom d'utilisateur à supprimer"
If ($delUser)
{
    If (Get-LocalUser | Where-Object {$_.name -like $($delUser)})
    {

        Remove-LocalUser -Name $delUser 
        Write-Host "L'utilisateur $delUser a bien été supprimé "
    }
    Else
    {
        Write-Host "Cet utilisateur n'existe pas"
    }
}
Else
{
    Write-Host "Merci de renseigner un nom d'utilisateur à supprimer"

} 
}
#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Utilisateur supprimé le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
}

#Suspension d'un Utilisateur

function disableUser { Invoke-command -computername $cli -Credential $cred -scriptblock { $disableUser = Read-Host "Merci de renseigner un nom d'utilisateur à suspendre"
If ($disableUser)
{
    If (Get-LocalUser | Where-Object {$_.name -like $($disableUser)})
    {

        Disable-LocalUser -Name $disableUser 
        Write-Host "L'utilisateur $disableUser a bien été suspendu "
    }
    Else
    {
        Write-Host "Cet utilisateur n'existe pas"
    }
}
Else
{
    Write-Host "Merci de renseigner un nom d'utilisateur à suspendre"

} 
}
#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Utilisateur suspendu le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
}


#Modification d'un mot de passe utilisateur

function changePassword {
Invoke-command -computername $cli -Credential $cred -scriptblock { $UserPassword = Read-Host "Merci de renseigner un nom d'utilisateur pour changer son mot de passe"
If ($UserPassword)
{
    If (Get-LocalUser | Where-Object {$_.name -like $($UserPassword)})
    {
        #$Password = Read-Host -AsSecureString 
        $NewPassword = Read-Host -AsSecureString 
        $Password = $NewPassword | ConvertTo-SecureString -AsPlainText -Force 
        Get-LocalUser -Name $UserPassword | Set-LocalUser -Password $NewPassword -UserMayChangePassword $true -PasswordNeverExpires $true
        Write-Host "Mot de passe changé avec succès !"
    }
    else
    {
        write-host " L'utilisateur n'existe pas"
    }
}
else
{
    Write-host "Merci de renseigner un nom d'utilisateur"
}
}
#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Mot de passe modifié le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
}

#L'ajout d'un utilisateur a un groupe

function addToGroup { Invoke-command -computername $cli -Credential $cred -scriptblock { $Group = Read-Host "Veuillez entrer le nom du groupe"
If ($Group)
{
    If (Get-LocalGroup | Where-Object {$_.name -like $($Group)})
    {
        $User = Read-Host "Veuillez entrer le nom d'utilisateur"
        If ($User)
        {
            If (Get-LocalUser | Where-Object {$_.name -like $($User)})
            {
                If (Get-LocalGroupMember $Group | Where-Object {$_.name -like $($User)})
                {
                    Write-Host "L'utilisateur appartient déjà au groupe"
                }
                Else
                {
                    Add-LocalGroupMember -Group $Group -Member $User
                    Write-Host "L'utilisateur $User a bien été ajouté au groupe $Groupe ! "
                }
            }
            Else
            {
                Write-Host "L'utilisateur n'existe pas"

            }
        }
        Else
        {
            Write-Host "Merci de renseigner un nom d'utilisateur"

        }
    }
    Else
    {
    Write-Host " Le groupe n'existe pas "
    }
}
Else
{
    "Merci de renseigner le nom du groupe "

}
}
#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Utilisateur ajouté au groupe le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
}

#Suppression d'un utilisateur dans un groupe
function removeFromGroup { Invoke-command -computername $cli -Credential $cred -scriptblock { $GroupRemove = Read-Host "Veuillez entrer le nom du groupe"
If ($GroupRemove)
{
    If (Get-LocalGroup | Where-Object {$_.name -like $($GroupRemove)})
    {
        $UserToRemove = Read-Host "Veuillez entrer le nom d'utilisateur"
        If ($UserToRemove)
        {
             If (Get-LocalUser | Where-Object {$_.name -like $($UserToRemove)})
            {
                If (Get-LocalGroupMember $GroupRemove | Select-Object $($UserToRemove))
                {
                    Remove-LocalGroupMember -Group $GroupRemove -Member $UserToRemove
                    Write-Host "L'utilisateur $UserToRemove a bien été retiré du groupe $GroupeRemove ! "
                }
                Else
                {
                    Write-Host "L'utilisateur n'appartient pas au groupe"   
                }
            }
            Else
            {
                Write-Host "L'utilisateur n'existe pas"

            }
        }
        Else
        {
            Write-Host "Merci de renseigner un nom d'utilisateur"

        }
    }
    Else
    {
    Write-Host " Le groupe n'existe pas "
    }
}
Else
{
    "Merci de renseigner le nom du groupe "

}
}
#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Utilisateur retiré du groupe le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
}



#Verouillage d'un PC client

function lockedComputer { Invoke-command -computername $cli -Credential $cred -scriptblock { logoff 1
}

#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Ordinateur client verrouillé le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
}


#Création d'un répertoire

function newDir { Invoke-command -computername $cli -Credential $cred -scriptblock { $Localisation = Read-Host "Renseigner la localisation pour la création de dossier  "
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
        }
    }
    Else
    {
        Write-Host " Cet emplacement n'existe pas "
    }
}
Else
{
    Write-Host " Merci de renseigner une localisation "
}
}

#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Dossier crée le $($LogDate)" | Out-File -Append -FilePath $($LogPath)

}


#Modification d'un répertoire

function renameDir { Invoke-command -computername $cli -Credential $cred -scriptblock { $Localisation2 = Read-Host "Renseigner la localisation complète du dossier à renommer  "
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
    }
}
Else
{
Write-Host " Vous devez renseigner un nom de dossier complet "
}
}

#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Dossier renommé le $($LogDate)" | Out-File -Append -FilePath $($LogPath)

}


#Suppression d'un répertoire

function delDir { Invoke-command -computername $cli -Credential $cred -scriptblock { $Localisation3 = Read-Host "Renseigner la localisation complète du dossier à supprimer  "
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
    }
}
Else
{
Write-Host " Vous devez renseigner un nom de dossier complet "
}
}

#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Dossier supprimé le $($LogDate)" | Out-File -Append -FilePath $($LogPath)

}


#Prise en main à distance
function remoteControl {
$clientRemote = Read-Host " Merci de renseigner le nom du client pour la prise en main à distance "
$userRemote = Read-Host " Merci de renseigner le nom d'utilisateur "
Enter-PSSession -Computername $clientRemote -credential "$userRemote"

#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Prise de contrôle commencée le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
}

#------------------------------fonction 01 Date de dernière connection d’un utilisateur
function LastConnectionUser {
    $Lastconnection = Invoke-Command -ComputerName $cli -Credential $cred -ScriptBlock {
        $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
    
        # Rechercher la date de la dernière connexion de l'utilisateur
        $evenement = Get-WinEvent -LogName "Security" | Where-Object { $_.Id -eq 4624 -and $_.Properties[5].Value -eq $utilisateur } | Select-Object -First 1
    
        if ($evenement) {
            $dateDerniereConnexion = $evenement.TimeCreated
            Write-Host "La date de la dernière connexion de $utilisateur est : $dateDerniereConnexion"
        } else {
            Write-Host "L'utilisateur $utilisateur n'a pas de connexion enregistrée."
        }
    }
    $Lastconnection
}

#-----------------------------fonction 02 Date de dernière modification du mot de passe
function LastPasswordChangeDate {
    $lastPasswdChange = Invoke-Command -ComputerName $cli -Credential $cred -ScriptBlock {
        $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
        $evenement = Get-WinEvent -LogName "Security" | Where-Object { $_.Id -eq 4624 -and $_.Properties[5].Value -eq $utilisateur } | Select-Object -First 1
        if ($utilisateur) {
            if (Get-LocalUser | Where-Object {$_.name -eq $utilisateur}) {
                if ($evenement) {
                    $lastPasswdChangeDate = $evenement.TimeCreated
                    Write-Host "La date de dernière modification du mot de passe de $utilisateur est : $lastPasswdChangeDate"
                } else {
                    Write-Host "L'utilisateur $utilisateur n'a pas de connexion enregistrée."
                }
            } else {
                Write-Host "Cet utilisateur n'existe pas"
            }
        } else {
            Write-Host "Merci de renseigner un nom d'utilisateur"
        }
    }
    $lastPasswdChange
}

#-----------------------fonction 03 Groupe d’appartenance d’un utilisateur
function UserGroup {
    $UserGroup = Invoke-Command -ComputerName $cli -Credential $cred -ScriptBlock { whoami /groups }
    $UserGroup
}

#----------------------fonction 04 Droits/permissions de l’utilisateur
function UserPermissions {
    $UserPermissions = Invoke-Command -ComputerName $cli -Credential $cred -ScriptBlock { whoami /priv }
    $UserPermissions
}
#---------------------------------fonction menu informations ordinateur
#---------------------------------01 fonction OS---------------------------------------------
function OsVersion {
    Invoke-Command -ComputerName $cli -Credential $cred -ScriptBlock { $osInfo = Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version
    Write-Host $osinfo 
    }
}

#--------------------------------02 fonction espace disque------------------------------
function diskSpace {
    Invoke-Command -ComputerName $cli -Credential $cred -ScriptBlock {
        $FreeDiskSpaceCommand = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object { $_.DeviceID -eq "C:" }
        $FreeSpaceBytes = $FreeDiskSpaceCommand.FreeSpace
        $FreeSpaceGB = [math]::Round($FreeSpaceBytes / 1GB, 2)
        "Espace disque restant sur le lecteur C: : $FreeSpaceGB Go"
    }
}

#-----------------------------03 fonction taille de répertoire--------------------------
function sizeOfDirectory {
    $DirectorySize = Invoke-Command -ComputerName $cli -Credential $cred -ScriptBlock {
        #Demander le chemin du répertoire à l'utilisateur
        $cheminDuRepertoire = Read-Host "Veuillez entrer le chemin du répertoire"

        if ($cheminDuRepertoire)
        {
            if (Test-Path $cheminDuRepertoire)
            {
                #Obtenir la taille du répertoire en octets
                $tailleEnOctets = (Get-ChildItem -Recurse -File -Path $cheminDuRepertoire | Measure-Object -Property Length -Sum).Sum

                #Fonction pour convertir la taille en une unité lisible par un humain
                function ConvertirEnLisible 
                {
                    param(
                        [long]$tailleEnOctets
                    )

                    if ($tailleEnOctets -ge 1GB) 
                    {
                        "{0:N2} Go" -f ($tailleEnOctets / 1GB)
                    }
                    elseif ($tailleEnOctets -ge 1MB)
                    {
                        "{0:N2} Mo" -f ($tailleEnOctets / 1MB)
                    }
                    elseif ($tailleEnOctets -ge 1KB) 
                    {
                        "{0:N2} Ko" -f ($tailleEnOctets / 1KB)
                    }
                    else
                    {
                        "{0:N0} octets" -f $tailleEnOctets
                    }
                }

                #Convertir la taille en une forme lisible par un humain
                $tailleLisible = ConvertirEnLisible -tailleEnOctets $tailleEnOctets

                #Afficher la taille du répertoire de manière lisible
                Write-Host "La taille du répertoire $cheminDuRepertoire est de $tailleLisible."
            }
            else
            {
                Write-Host "Ce chemin de répertoire n'est pas valide"
            }
        }
        else
        {
            Write-Host "Merci de renseigner un chemin de répertoire"
        }
    }
    $DirectorySize 
}

#-------------------------------------04 fonction liste des lecteurs-----------------------------------------------
Function hardDriveList {
    $lecteurs = Invoke-Command -ScriptBlock {
        Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, VolumeName
    } -ComputerName $cli -Credential $cred
    $lecteurs
}

#-----------------------------------05 fonction adresses IP------------------------------------
Function ipAdrress {
    $adresseIP = Invoke-Command -scriptblock { Get-NetIPAddress -AddressFamily IPV4 | Select-Object "*ipa*"
    } -computername $cli -credential $cred

    $adresseIP
}

#---------------------------------06 fonction liste des adresses MAC---------------------

function macaddressList {
    $MacList =  Invoke-Command -scriptblock { Get-NetAdapter -Name * | Select-Object "MacAddress"
    } -computername $cli -credential $cred

    $MacList
}

#------------------------------------07 fonction liste des application et paquets------------------------

function programList {
    Invoke-Command -scriptblock { Get-Package
    } -computername $cli -credential $cred

}

#------------------------------------08 fonction CPU------------------------------------
function cpuType {
    Invoke-Command -scriptblock { Get-WmiObject -Class Win32_Processor
    } -computername $cli -credential $cred
}

#------------------------------------09 fonction RAM-------------------------------------
function RamMemory {
    $ram = Invoke-Command  -computername $cli -credential $cred -scriptblock { ([math]::Round((Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2))
    }
    Write-Host "La mémoire RAM totale est de : $ram Go"
}

#------------------------------------10 fonction Ports-------------------------------------
function portsList {
    $Ports = Invoke-Command -computername $cli -credential $cred -scriptblock { Get-NetTCPConnection | Select-Object LocalPort
    } 
    $Ports | Format-Table
}

#------------------------------------11 fonction Pare-feu---------------------------------
function FirewallStatus {
    $Firewall = Invoke-Command -computername $cli -credential $cred -scriptblock { Get-NetFirewallProfile | Select-Object Name, Enabled
    }
    $Firewall
}

#------------------------------------12 fonction utilisateurs locaux---------------------------------
function localUsersList {
    $LocalUsers = Invoke-Command -ComputerName $cli -Credential $cred -ScriptBlock { Get-WmiObject -Class Win32_UserAccount | Select-Object Name, Fullname, SID
    }
    $LocalUsers
}
# fonction pour afficher le menu principal

function ShowMainMenu {
    Clear-Host
    Write-Host "1. Voulez vous effectuer une Action ?"
    Write-Host "2. Voulez-vous recolter une Information ?"
}
# fonction pour afficher le menu actions
function ShowActionsMenu {
    Write-Host "1. Voulez-vous agir sur les utilisateurs ?"
    Write-Host "2. Voulez-vous agir sur les machines ?"
    Write-Host "3. Retour au menu principal"
}
# fonction pour afficher le menu actions utilisateurs
function ShowActionsUsersMenu {
Write-Host "1. Voulez-vous ajouter un Utilisateur ?"
Write-Host "2. Voulez-vous renommer un Utilisateur ?"
Write-Host "3. Voulez-vous supprimer un Utilisateur ?"
Write-Host "4. Voulez-vous suspendre un Utilisateur ?"
Write-Host "5. Voulez-vous changer le mot de passe d'un Utilisateur ?"
Write-Host "6. Voulez-vous ajouter l'utilisateur Ã  un groupe ?"
Write-Host "7. Voulez-vous retirer l'utilisateur Ã  un groupe ?"
}

# # fonction pour afficher le menu actions ordinateurs
function ShowActionsComputersMenu {
Write-Host "1. Voulez-vous arreter la machine ?"
Write-Host "2. Voulez-vous redemarrer la machine ?"
Write-Host "3. Voulez-vous demarrer la machine grace au wake-on-lan ?"
Write-Host "4. Voulez-vous mettre a jour le systeme ?"
Write-Host "5. Voulez-vous verrouiller la session ?"
Write-Host "6. Voulez-vous creer un repertoire ?"
Write-Host "7. Voulez-vous modifier un repertoire ?"
Write-Host "8. Voulez-vous supprimer un repertoire ?"
Write-Host "9. Voulez-vous prendre en main le client ?"
Write-Host "10. Voulez-vous definir les regles du pare-feu?"
}

# Fonction pour afficher le menu informations
function ShowInfoMenu {
    Clear-Host
    Write-Host "Menu informations"
    Write-Host "--------------------------------"
    Write-Host "1. Informations ordinateurs"
    Write-Host "2. Informations utilisateurs"
    Write-Host "3. Retour au menu principal"
    Write-Host "4. Quitter"
}

# Fonction pour afficher le menu informations utilisateurs
function ShowMenuInfosUser {
    Clear-Host
    Write-Host "Menu Informations utilisateurs"
    Write-Host "--------------------------------"
    Write-Host "1. Date de dernière connection utilisateur"
    Write-Host "2. Date de dernière modification du mot de passe"
    Write-Host "3. Groupe d’appartenance d’un utilisateur"
    Write-Host "4. Droits/permissions de l’utilisateur"
    Write-Host "13. Quitter"
}
# Fonction pour afficher le menu informations ordinateurs
function ShowMenuInfosComp {
    Clear-Host
    Write-Host "Menu Informations ordinateurs"
    Write-Host "--------------------------------"
    Write-Host "1. Information système (OS)"
    Write-Host "2. Espace disque"
    Write-Host "3. Taille d'un répertoire"
    Write-Host "4. Liste des lecteurs"
    Write-Host "5. Adresses IP"
    Write-Host "6. Liste des adresses MAC"
    Write-Host "7. Liste des applications et paquets"
    Write-Host "8. Type de CPU"
    Write-Host "9. Mémoire RAM"
    Write-Host "10. Liste des ports en cours d'utilisation"
    Write-Host "11. État du pare-feu"
    Write-Host "12. Liste des utilisateurs locaux"
    Write-host "13. Retour au menu prinipal"
    Write-Host "14. Quitter"
}
#fonction pour retourner au menu
function ReturnToMainMenu {
    Clear-Host
    $choice = $null
    ShowMainMenu
    $choice = Read-Host "Choisissez une option (1/2, Q pour quitter)"
}

# Boucle principale pour afficher le menu et recueillir l'entrée de l'utilisateur
$quit = $false
while (-not $quit) {
    ShowMainMenu
    $choice = Read-Host "Choisissez une option (1/2, Q pour quitter)"

    switch ($choice) {
        "1" {
            # Afficher le menu des actions
            ShowActionsMenu
            $actionChoice = Read-Host "Choisissez une action (1/2)"
            switch ($actionChoice) {
                "1" {
                    # Afficher le menu des actions sur les utilisateurs
                    while (-not $quit) {
                    ShowActionsUsersMenu
                    $userActionChoice = Read-Host "Choisissez une action sur les utilisateurs (1-7)"
                    switch ($userActionChoice)
                                        {
                                        1
                                          {newUser
                                          }
                                        2
                                          {renameUser
                                          }
                                        3
                                          {delUser
                                          }
                                        4
                                          {disableUser
                                          }
                                        5
                                          {changePassword
                                          }
                                        6
                                          {addToGroup 
                                          }
                                        7
                                          {removeFromGroup
                                          }
                                        default
                                          {Write-Host "Choisir entre 1 et 7"
                                          }

                                        }
                                    }
                     }
                "2" {
                    while (-not $quit) {
                    # Afficher le menu des actions sur les ordinateurs
                    ShowActionsComputersMenu
                    $compActionChoice = Read-Host "Choisissez une action sur les ordinateurs (1-10)"
                    switch ($compActionChoice)
                    {
                    1
                        {Stop-Computer -ComputerName $cli -Credential $cred -force

                        #Format de la date pour Journalisation
                        $LogDate = Get-Date -Format yyyyMMdd_hhmmss 

                        #Chemin pour la Journalisation
                        $LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

                        "Ordinateur client éteint le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
                        }
                    2
                        {Restart-Computer -ComputerName $cli -Credential $cred -force

                        #Format de la date pour Journalisation
                        $LogDate = Get-Date -Format yyyyMMdd_hhmmss 

                        #Chemin pour la Journalisation
                        $LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

                        "Ordinateur client redémarré le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
                        }
                    3
                        {Write-Host "Non executable a ce stade de la formation"
                        }
                    4
                        {Write-Host "Non executable a ce stade de la formation"
                        }
                    5
                        {lockedComputer
                        }
                    6
                        {newDir
                        }
                    7
                        {renameDir
                        }
                    8
                        {delDir
                        }
                    9
                        {remoteControl
                        }
                    10
                        {Write-Host "Non executable a ce stade de la formation"
                        }
                    default
                        {Write-Host "Choisir entre 1 et 10"
                        }

                    }
                }
                }
                "3" {
                    ReturnToMainMenu
                }
                default {
                    Write-Host "Option invalide."
                }
            }
        }
        "2" {
            # Afficher le menu des informations
            while (-not $quit) {
            ShowInfoMenu
                $choice = Read-Host "Sélectionnez une option (1-4)"
            
                switch ($choice) {
                    1 {
                        $selection = $null
                    while ($selection -ne 14) {
                        ShowMenuInfosComp
                        $selection = Read-Host "Sélectionnez une option (1-14)"
                        switch ($selection) {
                            1 { 
                                OsVersion 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            2 { 
                                diskSpace 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            3 { 
                                sizeOfDirectory 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            4 { 
                                hardDriveList 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            5 { 
                                ipAdrress 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            6 { 
                                macaddressList 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            7 { 
                                programList 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            8 { 
                                cpuType 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            9 { 
                                RamMemory 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            10 { 
                                portsList 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            11 { 
                                FirewallStatus 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            12 { 
                                localUsersList 
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                            13 {
                                ReturnToMainMenu
                                                    }
                            14 { Write-Host "See you!" }
                            default {
                                Write-Host "Option invalide. Veuillez sélectionner une option valide (1-14)."
                                Read-Host "Appuyez sur Entrée pour revenir au menu..."
                            }
                        }
                      }
                    }
                    2 {
                        # Menu d'informations sur les utilisateurs
                        while (-not $quit) {
                            ShowMenuInfosUser
                        
                            $choice = Read-Host "Entrez le numéro de l'option que vous souhaitez exécuter"
                        
                            switch ($choice) {
                                1 {
                                    LastConnectionUser
                                    Read-Host "Appuyez sur Entrée pour revenir au menu..."
                                }
                                2 {
                                    LastPasswordChangeDate
                                    Read-Host "Appuyez sur Entrée pour revenir au menu..."
                                }
                                3 {
                                    UserGroup
                                    Read-Host "Appuyez sur Entrée pour revenir au menu..."
                                }
                                4 {
                                    UserPermissions
                                    Read-Host "Appuyez sur Entrée pour revenir au menu..."
                                }
                                5 {
                                    $quit = $true
                                }
                                default {
                                    Write-Host "Option non valide. Veuillez sélectionner une option valide."
                                }
                            }
                        }
                    }
                    3 {
                        ReturnToMainMenu
                    }
                    
                    4
                     { 
                        $quit = $true
                        Write-Host "Merci d'avoir utilisé le menu. Au revoir!"
                    }
                    default {
                        Write-Host "Option invalide. Veuillez sélectionner une option valide (1-3)."
                        Read-Host "Appuyez sur Entrée pour continuer..."
                    }
                }
            }
            
    }
}
}



