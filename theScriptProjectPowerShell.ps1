###########################################
#            M. Dhauyre Jerome            #
#           M. Dominici Thomas            #
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

function renameUser { Invoke-command -computername cliwin -Credential thomas -scriptblock { $UserToRename = Read-Host "Merci de renseigner un nom d'utilisateur à renommer"
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

function delUser { Invoke-command -computername cliwin -Credential thomas -scriptblock { $delUser = Read-Host "Merci de renseigner un nom d'utilisateur à supprimer"
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

function disableUser { Invoke-command -computername cliwin -Credential thomas -scriptblock { $disableUser = Read-Host "Merci de renseigner un nom d'utilisateur à suspendre"
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
Invoke-command -computername cliwin -Credential thomas -scriptblock { $UserPassword = Read-Host "Merci de renseigner un nom d'utilisateur pour changer son mot de passe"
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

function addToGroup { Invoke-command -computername cliwin -Credential thomas -scriptblock { $Group = Read-Host "Veuillez entrer le nom du groupe"
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
function removeFromGroup { Invoke-command -computername cliwin -Credential thomas -scriptblock { $GroupRemove = Read-Host "Veuillez entrer le nom du groupe"
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

function lockedComputer { Invoke-command -computername cliwin -Credential thomas -scriptblock { logoff 1
}

#Format de la date pour Journalisation
$LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

"Ordinateur client verrouillé le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
}


#Création d'un répertoire

function newDir { Invoke-command -computername cliwin -Credential thomas -scriptblock { $Localisation = Read-Host "Renseigner la localisation pour la création de dossier  "
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

function renameDir { Invoke-command -computername cliwin -Credential thomas -scriptblock { $Localisation2 = Read-Host "Renseigner la localisation complète du dossier à renommer  "
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

function delDir { Invoke-command -computername cliwin -Credential thomas -scriptblock { $Localisation3 = Read-Host "Renseigner la localisation complète du dossier à supprimer  "
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


#--------------------Main--------------------#
Clear-host
while ($true)
{
Write-Host "1 -- Voulez vous effectuer une Action ?"
Write-host "2 -- Voulez-vous recolter une Information ?"
$choixPrincipale=Read-Host -Prompt "Choisissez 1 ou 2"

    switch ($choixPrincipale)
    {
    1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              { 
        while ($true)
            {
               Write-Host "1 -- Voulez-vous agir sur les utilisateurs ?"
               Write-Host "2 -- Voulez-vous agir sur les machines ?"
               $choixSecondaire=Read-Host -Prompt "Choisissez 1 ou 2"
                   while ($true) 
                   { 
                   switch ($choixSecondaire)
                        {
                        1
                            {
                            Write-Host "1 -- Voulez-vous ajouter un Utilisateur ?"
                            Write-Host "2 -- Voulez-vous renommer un Utilisateur ?"
                            Write-Host "3 -- Voulez-vous supprimer un Utilisateur ?"
                            Write-Host "4 -- Voulez-vous suspendre un Utilisateur ?"
                            Write-Host "5 -- Voulez-vous changer le mot de passe d'un Utilisateur ?"
                            Write-Host "6 -- Voulez-vous ajouter l'utilisateur Ã  un groupe ?"
                            Write-Host "7 -- Voulez-vous retirer l'utilisateur Ã  un groupe ?"
                            $ChoixTerciaire=Read-Host -Prompt "Choisir entre 1 et 7"

                                while ($true)
                                {
                                    switch ($ChoixTerciaire)
                                        {
                                        1
                                          {newUser
                                          exit}
                                        2
                                          {renameUser
                                          exit}
                                        3
                                          {delUser
                                          exit}
                                        4
                                          {disableUser
                                          exit}
                                        5
                                          {changePassword
                                          exit}
                                        6
                                          {addToGroup 
                                          exit}
                                        7
                                          {removeFromGroup
                                          exit}
                                        default
                                          {Write-Host "Choisir entre 1 et 7"
                                          exit}
                                          
                                        }
                                 }
                            }
                        2
                            {
                            Write-Host "1 -- Voulez-vous arreter la machine ?"
                            Write-Host "2 -- Voulez-vous redemarrer la machine ?"
                            Write-Host "3 -- Voulez-vous demarrer la machine grace au wake-on-lan ?"
                            Write-Host "4 -- Voulez-vous mettre a jour le systeme ?"
                            Write-Host "5 -- Voulez-vous verrouiller la session ?"
                            Write-Host "6 -- Voulez-vous creer un repertoire ?"
                            Write-Host "7 -- Voulez-vous modifier un repertoire ?"
                            Write-Host "8 -- Voulez-vous supprimer un repertoire ?"
                            Write-Host "9 -- Voulez-vous prendre en main le client ?"
                            Write-Host "10 -- Voulez-vous definir les regles du pare-feu?"
                            $ChoixTerciaire=Read-Host -Prompt "Choisir entre 1 et 10}"

                                    while ($true)
                                {
                                    switch ($ChoixTerciaire)
                                        {
                                        1
                                            {Stop-Computer -ComputerName cliwin -Credential thomas -force

                                            #Format de la date pour Journalisation
                                            $LogDate = Get-Date -Format yyyyMMdd_hhmmss 

                                            #Chemin pour la Journalisation
                                            $LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

                                            "Ordinateur client éteint le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
                                            exit}
                                        2
                                            {Restart-Computer -ComputerName cliwin -Credential thomas -force

                                            #Format de la date pour Journalisation
                                            $LogDate = Get-Date -Format yyyyMMdd_hhmmss 

                                            #Chemin pour la Journalisation
                                            $LogPath = "C:\Windows\System32\LogFiles\log_actions.log"

                                            "Ordinateur client redémarré le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
                                            exit}
                                        3
                                            {Write-Host "Non executable a ce stade de la formation"
                                            exit}
                                        4
                                            {Write-Host "Non executable a ce stade de la formation"
                                            exit}
                                        5
                                            {lockedComputer
                                            exit}
                                        6
                                            {newDir
                                            exit}
                                        7
                                            {renameDir
                                            exit}
                                        8
                                            {delDir
                                            exit}
                                        9
                                            {remoteControl
                                            exit}
                                        10
                                            {Write-Host "Non executable a ce stade de la formation"
                                            exit}
                                        default
                                            {Write-Host "Choisir entre 1 et 10"
                                            exit}
                                        
                                        }
                                    
                                 }
                            }
                        default
                            {Write-Host "Choisir entre 1 et 2"
                            exit}
                        
                        }
                    }
             }              
        }
    
    2
                                                                                                                                                                                                                                                                                                                                                                                                    {
             while ($true)
                {
                Write-Host "1 -- Voulez-vous agir sur les utilisateurs ?"
                Write-Host "2 -- Voulez-vous agir sur les machines ?"
                $choixSecondaire=Read-Host -Prompt "Choisissez 1 ou 2"
                 while ($true) 
                   { 
                   switch ($choixSecondaire)
                        {
                        1
                            {
                            Write-Host "1 -- Voulez-vous savoir la derniere date de connection d'un Utilisateur ?"
                            Write-Host "2 -- Voulez-vous savoir la derniere date de modification du mot de passe d'un Utilisateur ?"
                            Write-Host "3 -- Voulez-vous savoir les Groupes d'appartenance d'un Utilisateur ?"
                            Write-Host "4 -- Voulez-vous savoir les droits/permission d'un Utilisateur ?"                         
                            $ChoixTerciaire=Read-Host -Prompt "Choisir entre 1 et 4"
                               
                                while ($true)
                                {
                                    switch ($ChoixTerciaire)
                                        {
                                        1
                                          {}
                                        2
                                          {}
                                        3
                                          {}
                                        4
                                          {}
                                        default
                                          {Write-Host "Choisir entre 1 et 4"
                                          exit}
                                        }
                               }
                            }
                        2
                            {
                            Write-Host "1 -- Voulez-vous savoir la version de l'OS de la machine ?"
                            Write-Host "2 -- Voulez-vous savoir l'espace disque restant de la machine ?"
                            Write-Host "3 -- Voulez-vous savoir la taille d'un repertoire specifique de la machine ?"
                            Write-Host "4 -- Voulez-vous savoir la liste des lecteurs de la machine ?"
                            Write-Host "5 -- Voulez-vous savoir l'adresse IP de la machine ?"
                            Write-Host "6 -- Voulez-vous savoir l'adresse MAC de la machine ?"
                            Write-Host "7 -- Voulez-vous savoir la liste des applications installe sur la machine ?"
                            Write-Host "8 -- Voulez-vous savoir les specificites du CPU sur la machine ?"
                            Write-Host "9 -- Voulez-vous savoir la memoire RAM total sur la machine ?"
                            Write-Host "10 -- Voulez-vous savoir la liste des Ports Ouvert sur la machine ?"
                            Write-Host "11 -- Voulez-vous savoir le statut du pare-feu?"
                            Write-Host "12 -- Voulez-vous savoir la liste des Utilisateur locaux?"
                            $ChoixTerciaire=Read-Host -Prompt "Choisir entre 1 et 12"
                            
                                    while ($true)
                                {
                                    switch ($ChoixTerciaire)
                                        {
                                        1
                                            {}
                                        2
                                            {}
                                        3
                                            {}
                                        4
                                            {}
                                        5
                                            {}
                                        6
                                            {}
                                        7
                                            {}
                                        8
                                            {}
                                        9
                                            {}
                                        10
                                            {}
                                        11
                                            {}
                                        12
                                            {}
                                        default
                                          {Write-Host "Choisir entre 1 et 12"
                                          exit}
                                        }
                                   }
                            }
                     
                        default
                            {Write-Host "Choisir entre 1 et 2"
                            exit}}
                    }
            }
        }
    default
        {Write-Host "Choisir entre 1 et 2"
        exit}
    }
}