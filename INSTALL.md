# Guide d'installation :

## Besoins initiaux : besoins du projet

Pour ce projet, vous aurez besoin de quatre machines mises en réseaux. Pour l'exemple, nous prendrons les adresses IP suivantes : 

| **Machines**   | **Adresses IP** |
|----------------|-----------------|
| Win Sever 2022 | 192.168.1.10    |
| Debian 12      | 192.168.1.20    |
| Win 10         | 192.168.1.100   |
| Ubuntu 22.04   | 192.168.1.200   |

Nous allons ici détailler les différentes étapes d'installation pour pouvoir utiliser deux scripts (un Bash et un Powershell) d'un ordinateur serveur vers un ordinateur client.
Nous allons utiliser une serveur Windows server 2022 à destination d'un client Windows 10. De m^men nous utiliserons un serveur Debian à destination d'un client Ubuntu.


## Étapes d'installation et de configuration : instruction étape par étape

Nous utiliserons ici des VM sur VirtualBox.

### Prérequis VM

Toutes nos machines ont été configurées avec 2 processeurs et 4 gigas de RAM mais il est possible de diminuer notamment pour Debian à un processeur et 2 gigas de RAM.  

### Mise en reseau 

Pour la mise en réseau, il faut tout d'abord aller dans l'onglet réseau de virtualbox sur la machine et sélectionner **Réseau Interne**.

![image1](https://github.com/ThomasDominici/TSSR-Projet-Groupe_2-TheScriptingProject/blob/Thomas/Ressources/1_r%C3%A9seau_interne.JPG?raw=true)  

Pour pouvoir communiquer entre eux, nos machines doivent avoir des adresses IP faisant partie du même réseau. Nous utilisons ici les adresses 192.168.1.X/24.
Nous allons ensuite mettre en place des adresses IP fixes manuellement grâces aux étapes ci-dessous : 

**Pour les ordinateurs Windows :**

On clique droit sur l'onglet **réseau**en bas à droite de l'écran et on va dans **Ouvrir les paramètres réseaux et internet**.    
On sélectionne ensuite l'onglet Ethernet et on clique sur **Modifier les options d'adaptateur**  

![image2](https://github.com/ThomasDominici/TSSR-Projet-Groupe_2-TheScriptingProject/blob/Thomas/Ressources/2_ethernet.JPG?raw=true)  

On rejoint ensuite les propriétés de l'Ethernet comme le montre l'image ci-dessous : 

![image3](https://github.com/ThomasDominici/TSSR-Projet-Groupe_2-TheScriptingProject/blob/Thomas/Ressources/3_propri%C3%A9t%C3%A9s_ethernet.JPG?raw=true)  

Dans ces propriété, un double clique sur les **propriétés IPv4** nous permet de passer l'adressage en manuel et de renseigner l'adresse IP et le masque de sous-réseau désirés.  

![image4](https://github.com/ThomasDominici/TSSR-Projet-Groupe_2-TheScriptingProject/blob/Thomas/Ressources/4_ipv4.JPG?raw=true)  

Notre adresse IP est bien configurée après un redémarrage de la machine.
On peut vérifier l'adresse IP avec la commande suivante :
```PowerShell
ipconfig
```

  
**Pour l'ordinateur Ubuntu :**  

On clique sur l'onglet en haut à droite de l'écran et on sélectionne **Paramètres**.  
Dans l'onglet **Réseau**, on clique sur le petit engrenage à droite au niveau de **Ethetnet (enp0s3)**.    


![image5](https://github.com/ThomasDominici/TSSR-Projet-Groupe_2-TheScriptingProject/assets/144700255/12ad7d26-c6ed-48e7-acf9-eccdd468dcfd)   


On va ensuite dans IPv4 et on renseigne l'adresse IP et le masque de sous-réseau voulus.   

![image6](https://github.com/ThomasDominici/TSSR-Projet-Groupe_2-TheScriptingProject/blob/Thomas/Ressources/6_ipv4ubuntu.JPG?raw=true)  

Notre adresse IP est bien configurée après un redémarrage de la machine.  
On peut vérifier l'adresse IP avec la commande suivante :
```Bash
ip a
```


  
**Pour l'ordinateur Debian :**  


En **root**, nous allons éditer le ficher */etc/network/interfaces* :
```Bash
nano /etc/network/interfaces

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface - vbox
allow-hotplug enp0s3
iface enp0s3 inet static
        addresse 192.168.1.20
        netmask 255.255.255.0

# NAT interface si on a rajouté un second adapter
auto enp0s8
iface enp0s8 inet dhcp
```

Un fois édité comme ci-dessus, on peut redémarrer le système réseau et vérifier notre adresse IP.
```Bash
systemctl restart networking

ip a
```


Toutes nos machines sont maintenant en réseau, nous pouvons passer à la suite.


### Renommer les machines : 

Pour ce projet, nous allons donner les noms suivants aux machines : 
- Debian : srvlin  
- Ubuntu : clilin  
- Windows Server : srvwin  
- Windows 10: cliwin

**Pour les machines Windows :**

Nous allons chercher *nom* dans le menu démarrer.   
Nous cliquons sur **Afficher le nom de votre PC** et nous le modifions.   
Nous redémarrons la machine.   

Nous allons aussi modifier le fichier hosts qui est sous C:\Windows\System32\drivers\etc : 

- Pour le serveur, ajouter (avec le compte Administrator) :  
```
127.0.0.1 localhost  
192.168.56.20 srvlin 
192.168.56.100 cliwin
192.168.56.200 clilin
```
  
- Pour le client, ajouter (avec le compte Administrateur) :  
```
127.0.0.1 localhost  
192.168.56.20 srvlin  
192.168.56.10 srvwin  
192.168.56.200 clilin
```

**Pour les machines Linux :**

Nous allons éditer le ficher /etc/hostname et changer le nom du PC : 
```Bash
nano /etc/hostname
```

Nous allons aussi modifier le fichier /etc/hosts : 

- Pour le serveur, ajouter (en root) :
```
127.0.0.1 localhost
127.0.1.1 srvlin
192.168.56.10 srvwin
192.168.56.100 cliwin
192.168.56.200 clilin
```

  
- Pour le client, ajouter (en éditant avec un sudo) :
```
127.0.0.1 localhost
127.0.1.1 clilin
192.168.56.200 clilin
192.168.56.20 srvlin
192.168.56.10 srvwin
192.168.56.100 cliwin
```


L'ensemble de nos noms de machines est maintenant modifié.   



installe et config ssh  linux
install et config win rm 
creation dossier export bureau



Difficultés rencontrées : problèmes techniques rencontrés
Solutions trouvées : Solutions et alternatives trouvées
Tests réalisés : description des tests de performance, de sécurité, etc.
Résultats obtenus : ce qui a fonctionné
Améliorations possibles : suggestions d’améliorations futures


