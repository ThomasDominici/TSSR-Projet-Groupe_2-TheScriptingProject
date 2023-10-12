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

## Les difficultés rencontrées

1- Nous devons mettre en réseau nos quatre machines. Nous avons rencontré des difficultés à paramétrer une IP fixe pour le serveur Debian.

2- Il nous faut trouver l'ensemble des commandes d'une machine à une autre pour chaque OS ainsi que pour des OS différents : - Debian vers Ubuntu
- Debian vers Windows 10
- Windows Server vers Windows 10
- Windows Server vers Ubuntu

Les commandes permettant des actions sur un OS ne sont pas forcément les mêmes sur un autre.

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

## Les tests réalisés

Nous avons testé la méthode SSH d'un Débian à un Ubuntu.

## Futures améliorations

Nous devons continuer de chercher les commandes et tester le tunnel SSH sur les autres machines. Nous utiliserons peut-être PuTTY pour Windows.
