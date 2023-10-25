###########################################
#            M. Dhauyre Jérome            #
#           M. Dominici Thomas            #
#         M. Del Ciotto Vincent           #
#          Projet "MyFirstScript"         #
#     Le but du projet est de pouvoir     #
#        intéragir depuis un serveur      # 
#    vers différent client avec des OS    # 
#              différent                  #
# Le Projet a commencer le lundi 9 octobre#
#       Version 0.1 Menu fonctionnel      #
###########################################
#------------------Variable------------------#

#identification de la machine cible
$Global:IpAdress = Read-Host "Sur quelle machine voulez vous vous connecter ?(Renseignez le Nom de la machine ou son adresse IP) :"

#Format de la date pour Journalisation
$Global:LogDate = Get-Date -Format yyyyMMdd_hhmmss 

#Chemin pour la Journalisation
$Global:LogPath = "C:\Windows\System32\LogFiles\log_actions.log"




#------------------Fonction------------------#

#Ajout d'un Utilisateur
function AddingUser
{
    param ([String]$UserrName,[String]$Password)
     $AddedUser = New-LocalUser -Name $($args[1]) -Password (Convertto-secureString -AsPlainText $($args[2]) -Force)
     Invoke-Command -ComputerName $($Global:IpAdress) -ScriptBlock {$args[0]} -ArgumentList $AddedUser,$userrName,$Password
     "Utilisateur crée le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
     $Global:LogDate = $Null

}

#Suppression d'un utilisateur
function DeletingUser
{
    param ([string]$UserrName)
        $DeletedUser = Remove-LocalUser -Name $($args[1])
        Invoke-Command -ComputerName $($Global:IpAdress) -ScriptBlock {$args[0]} -ArgumentList $DeletedUser,$UserrName
        "Utilisateur supprimé le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
        $Global:LogDate = $Null
}

#Suspension d'un Utilisateur
function DisablingUser
{
    param ([string]$UserrName)
        $DisabledUser = Disable-LocalUser -Name $($args[1])
        Invoke-Command -ComputerName $($Global:IpAdress) -ScriptBlock {$args[0]} -ArgumentList $DisabledUser,$UserrName
        "Utilisateur a été suspendu le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
        $Global:LogDate = $Null
}

#Fonction attribution d'une date d'expiration a un utilisateur
function ModificatingUser
{
    param ([string]$UserrName)
        $ExpireDateForUser = Read-Host -Prompt "A quelle date voulez vous que l'utilisateur expire au format Année-Mois-Jour : "
        $ModificatedUser = Set-LocalUser -Name $($args[1]) -AccountExpires (Get-Date "$Args[2]")
        Invoke-Command -ComputerName $($Global:IpAdress) -ScriptBlock {$args[0]} -ArgumentList $ModificatedUser,$UserrName,$ExpireDateForUser
        "Utilisateur supprimé le $($LogDate)" | Out-File -Append -FilePath $($LogPath)
        $Global:LogDate = $Null
}


#--------------------Main--------------------#
Clear-host
while ($true)
{
    Write-Host "1 -- Voulez vous effectuer une Action ?"
    Write-host "2 -- Voulez-vous récolter une Information ?"
    $choixPrincipale=Read-Host -Prompt "Choisissez 1 ou 2"

    switch ($choixPrincipale)
    {
        1 
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
                            Write-Host "1 -- Voulez-vous ajouter un Utilisateur ?"
                            Write-Host "2 -- Voulez-vous supprimer un Utilisateur ?"
                            Write-Host "3 -- Voulez-vous suspendre un Utilisateur ?"
                            Write-Host "4 -- Voulez-vous attributer une date d'expiration à un utilisateur un Utilisateur ?"
                            Write-Host "5 -- Voulez-vous changer le mot de passe d'un Utilisateur ?"
                            Write-Host "6 -- Voulez-vous ajouter l'utilisateur à un groupe ?"
                            Write-Host "7 -- Voulez-vous retirer l'utilisateur à un groupe ?"
                            $ChoixTerciaire=Read-Host -Prompt "Choisir entre 1 et 7}"
                            }
                        2
                            {
                            Write-Host "1 -- Voulez-vous arrêter la machine ?"
                            Write-Host "2 -- Voulez-vous redémarrer la machine ?"
                            Write-Host "3 -- Voulez-vous démarrer la machine grâce au wake-on-lan ?"
                            Write-Host "4 -- Voulez-vous mettre à jour le système ?"
                            Write-Host "5 -- Voulez-vous verrouiller la session ?"
                            Write-Host "6 -- Voulez-vous créer un repertoire ?"
                            Write-Host "7 -- Voulez-vous modifier un repertoire ?"
                            Write-Host "8 -- Voulez-vous supprimer un repertoire ?"
                            Write-Host "9 -- Voulez-vous prendre en main le client ?"
                            Write-Host "10 -- Voulez-vous définir les règles du pare-feu?"
                            $ChoixTerciaire=Read-Host -Prompt "Choisir entre 1 et 10}"
                            }
                        }
                   }              
             }
        }
        2
        {
             while ($true)
                {
                Write-Host "Voulez-vous agir sur les utilisateurs ? 1"
                Write-Host "Voulez-vous agir sur les machines ? 2"
                $choixSecondaire=Read-Host -Prompt "Choisissez 1 ou 2"
                 while ($true) 
                   { 
                   switch ($choixSecondaire)
                        {
                        1
                            {
                            Write-Host "1 -- Voulez-vous savoir la dernière date de connection d'un Utilisateur ?"
                            Write-Host "2 -- Voulez-vous savoir la dernière date de modification du mot de passe d'un Utilisateur ?"
                            Write-Host "3 -- Voulez-vous savoir les Groupes d'appartenance d'un Utilisateur ?"
                            Write-Host "4 -- Voulez-vous savoir les droits/permission d'un Utilisateur ?"                         
                            $ChoixTerciaire=Read-Host -Prompt "Choisir entre 1 et 4}"
                            }
                        2
                            {
                            Write-Host "1 -- Voulez-vous savoir la version de l'OS de la machine ?"
                            Write-Host "2 -- Voulez-vous savoir l'espace disque restant de la machine ?"
                            Write-Host "3 -- Voulez-vous savoir la taille d'un répertoire spécifique de la machine ?"
                            Write-Host "4 -- Voulez-vous savoir la liste des lecteurs de la machine ?"
                            Write-Host "5 -- Voulez-vous savoir l'adresse IP de la machine ?"
                            Write-Host "6 -- Voulez-vous savoir l'adresse MAC de la machine ?"
                            Write-Host "7 -- Voulez-vous savoir la liste des applications installé sur la machine ?"
                            Write-Host "8 -- Voulez-vous savoir les spécificité du CPU sur la machine ?"
                            Write-Host "9 -- Voulez-vous savoir la mémoire RAM total sur la machine ?"
                            Write-Host "10 -- Voulez-vous savoir la liste des Ports Ouvert sur la machine ?"
                            Write-Host "11 -- Voulez-vous savoir le statut du pare-feu?"
                            Write-Host "12 -- Voulez-vous savoir la liste des Utilisateur locaux?"
                            $ChoixTerciaire=Read-Host -Prompt "Choisir entre 1 et 12}"
                            }
                        }
                    }
              }
        }
    }
}
