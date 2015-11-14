#!/bin/bash

: '
Feladat: Készítsen egy találkozóra hívó körlevél készítő szkriptet! A szkript paramétere legyen két fájl,
az egyik a körlevél szövege, a másik az „adatbázis”. A körlevél szövegében <> között helyezzük el a mezőneveket(,,),
amelyek aktuális értékét az adatbázis fájlból olvassuk ki. Az adatbázist tartalmazó fájl soronként három adatot
tartalmaz, a címzett nevét, címét és találkozó helyét! A körlevelek a szabványos kimenetre kerüljenek kiírásra!
 '


function send(){
    echo $*
}

while IFS=',' read -r name email location
do
   send $name $email $location
done < "$1"
