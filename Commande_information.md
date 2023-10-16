
Date derniere connexion d'un utilisateur : **last $User | head -n 1**
``` bash
last vincent | head -n 1
vincent tty2 tty2 Thu Oct 12 11:37 still logged in
```

Date derniere modification de mot de passe : **passwd -S $User**
``` bash
passwd -S vincent
vincent P 09/13/2023 0 99999 7 -1
```
la date de dernier modification se trouve au 3ieme champs

Groupe d'appartenance d'un utilisateur : **id $User**
``` bash
id $User
```

 Droits/permissions d'un utilisateur 
``` bash
ls -larth
```

Version de l'OS
``` bash
lsb_release -d
```

**Espace disque restant**
``` bash
df -h
```

Taille d'un repertoire 
``` bash
du -sh $Repertoire
```

Liste des lecteurs
``` bash
lsblk
```

**Adresse IP et MAC** 
``` bash
ip a
```

liste paquet 
``` bash
dpkg --list
```

info cpu
``` bash
cat /proc/cpuinfo
```

mémoire ram
``` bash
free -h
```

liste des port ouvert

``` bash
ss -tulnp
```

Statut parefeu (sous sudo)

``` bash
iptables -L
```

liste des utilisateur locaux

``` bash
cut -d: -f1 /etc/passwd
```