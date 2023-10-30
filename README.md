# TSSR-Projet-Groupe_2-TheScriptingProject


## Projet 

Le projet consiste à créer un script pouvant être utilisé sur Linux ou Windows et agir sur d'autres machines de différents OS. Nous allons pour cela créer un réseau interne sur VirtualBox consituté de quatre VM. Nous aurons donc deux serveurs et deux clients : 
- Windows Server 2022
- Debian 12 (serveur)
- Windows 10 (client)
- Ubuntu (client).

## Semaine 1

| NOM     | Roles         | Tâches                                                     |
|---------|---------------|------------------------------------------------------------------|
| Vincent |               |Recherche sur la méthode et commande des actions dédiées aux log.           |
| Thomas  | Product Owner |Garant de la qualité du produit final et représentant du client. Recherche sur la méthode et commande des actions dédiées aux utilisateurs.|
| Jérôme  | Scrum Master  |Garant de la progression et de l'application de la méthode scrum. Recherche sur la méthode et commande des actions dédiées aux machines.|

## Semaine 2

| NOM     | Roles         | Tâches                                                     |
|---------|---------------|------------------------------------------------------------------|
| Thomas |               |Création d'une partie du script Linux sur les informations et recherche sur le protocole SSH plus poussée.          |
| Vincent  | Product Owner |Garant de la qualité du produit final et représentant du client. Création d'une partie du code Linux sur les actions. Prise de contrôle en remote
| Jérôme  | Scrum Master  |Garant de la progression et de l'application de la méthode scrum. Création de la trame du script Windows et recherche des commandes permettant la prise de contrôle d'un ordniateru à un autre

## Semaine 3

|   NOM   |     Roles     |                                                                                             Tâches                                                                                             |
|:-------:|:-------------:|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| Thomas  |   | Garant de la progression et de l'application de la méthode scrum. Recherche et création des commandes actions sur utilisateurs et ordinateurs PowerShell et journalisation|
| Vincent | Product Owner | Garant de la qualité du produit final et représentant du client. Création d'une partie du script PowerShell actions et menu.                                          |
| Jérôme  |   Scrum Master            | Recherche et création des commandes PowerShell sur les informations utilisateurs et machines, reprise du travail du script PowerShell pour améliorer le menu interactif                                                                                                                                                                                              |


## Choix Techniques
1) Paramétrage identique pour l'ensemble de l'équipe

| **Machines**   | **Adresses IP** |
|----------------|-----------------|
| Win Sever 2022 | 192.168.1.10    |
| Debian 12      | 192.168.1.20    |
| Win 10         | 192.168.1.100   |
| Ubuntu 22.04   | 192.168.1.200   |

2) Priorité de réaliser un premier script en bash
3) Trouver l'ensemble des fonctions Bash et Powershell pour les actions à réaliser sur les machines et les utilisateurs. 
4) installer SSH et le configurer sur chaque machine.
5) installer SSH et le configurer sur chaque machine dans l'environnement Linux.
6) installer et configurer Winrm pour l'environnement Windows et aussi accès au bureau à distance

### Deux scripts : 
1) Un script en Bash depuis le serveur Debian.
2) Un script en PowerShell depuis le serveur Windows Server.

## Les difficultés rencontrées

1- Nous devons mettre en réseau nos quatre machines. Nous avons rencontré des difficultés à paramétrer une IP fixe pour le serveur Debian.

2- Il nous faut trouver l'ensemble des commandes d'une machine à une autre pour chaque OS ainsi que pour des OS différents : - Debian vers Ubuntu
- Debian vers Windows 10
- Windows Server vers Windows 10
- Windows Server vers Ubuntu

Les commandes permettant des actions sur un OS ne sont pas forcément les mêmes sur un autre.

3- Nous avons rencontré des difficultés à exécuter plusieurs commandes dans un tunnel SSH. 

4- La prise de contrôle à distance en PowerShell est encore énigmatique, nous avons du mal à prendre le contrôle de la machine Windows 10 depuis la machine Windows Server.

## Les solutions

1- Pour fixer notre IP sur Débian, nous allons éditer en root notre interface : 
```Bash
nano /etc/network/interfaces
```

Nous allons ensuite sur la dernière ligne et remplacer **dhcp** par **static**. Puis nous allons compléter notre interface selon nos besoins : une adresse statique pour l'adapter 1 du réseau interne et une adresse automatique pour l'adapter 2 en NAT : 

```Bash
#Réseau interne - vbox
auto enp0s3
iface enp0s3 inet static
  address 192.168.1.20
  netmask 255.255.255.0

# Et pour le NAT
auto enp0s8
iface enp0s8 inet dhcp
```

2- Pour les différentes commandes et la prise en main à distance, il existe la méthode SSH qui permet de prendre la main d'un ordinateur grâce à soin adresse IP.

```Bash
ssh wilder@192.168.1.x
```
On rentre le mot de passe de la machine cible et pouvons la contrôler depuis le poste émetteur.

3- Nous pouvons remettre la commande SSH devant chaque commande. Cela implique de devoir retaper le code de la machine cible avant chaque résultat. Il existe une autre solution en passant par un autre script et en effectuant la commande 
```Bash
#! /bin/bash

read -p "Veuillez entrer le nom d'utilisateur : " user
read -p "Veuillez entrer l'adresse IP de la machine cible : " ipAddress

user=$user
ipAddress=$ipAddress

ssh $user@$ipAddress 'bash -s' < <nomDuScriptALancer.sh>
```

Cette commande semble fonctionner sur des scripts simples mais pas sur notre script cible pour le moment.

## Les tests réalisés

Nous avons testé la méthode SSH d'un Débian à un Ubuntu.  
Nous avons créé un script Linux complet en local et rajouté les commandes SSH pour chaque information demandée.   
Nous avons cherché et testé différentes méthodes de prise de contrôle remote entre deux machines Windows.  

## Futures améliorations

Nous devons continuer de chercher les commandes et tester le tunnel SSH sur les autres machines. Nous utiliserons peut-être PuTTY pour Windows.  
Nous allons résoudre les problèmes de SSH sur le script Bash et prendre aussi le contrôle de notre machine Windows 10 avec le serveur Windows.  
