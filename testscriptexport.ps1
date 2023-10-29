$Cible = "CLIWIN"
$Date = Get-Date -Format "yyyy.MM.dd"
$Heure = Get-Date -Format "HH'h'mm"

# Obtenez le chemin du dossier "Documents" de l'utilisateur
$DossierDocuments = Join-Path $env:USERPROFILE "Docs"

# Construisez le chemin complet du fichier
$CheminFichier = Join-Path $DossierDocuments "info_${Cible}_${Date}_${Heure}.txt"

# Exécutez la commande Get-Host, redirigez la sortie vers le fichier
Get-Host | Out-File -FilePath $CheminFichier

# Affichez le chemin du fichier pour vérification
Write-Host $CheminFichier
