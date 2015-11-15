#!/bin/bash

: '
Feladat: Készítsen egy találkozóra hívó körlevél készítő szkriptet! A szkript paramétere legyen két fájl,
az egyik a körlevél szövege, a másik az „adatbázis”. A körlevél szövegében <> között helyezzük el a mezőneveket(,,),
amelyek aktuális értékét az adatbázis fájlból olvassuk ki. Az adatbázist tartalmazó fájl soronként három adatot
tartalmaz, a címzett nevét, címét és találkozó helyét! A körlevelek a szabványos kimenetre kerüljenek kiírásra!
 '


function send(){
    echo $'Sending email...\nFrom: xyz@something.net\nTo: '"$2"$'\nSubject: Meghivo\n'
    cat $4 | sed "s/\(<name>\)/$1/g" | sed "s/\(<location>\)/$3/g"
    echo $'\n'

}

hiba=0

if [[ $# -ne 2 ]]
then
    echo "Nem megfelő szamu argumentum! A script 2 argumentumot var, az elso a nevjegyzek a masodik az email szovege."
    exit 1
fi

if ! [[ -f $1 ]]
then
    hiba=$(expr ${hiba} + 1)
    echo "$hiba: A megadott nevjegyzek nem letezik!"
fi

if ! [[ -f $2 ]]
then
    hiba=$(expr ${hiba} + 1)
    echo "$hiba: Az level szoveget tartalmazo fajl nem letezik!"
fi

if [[ ${hiba} -ne 0 ]]
then
    exit ${hiba}
else
    while IFS=',' read -r name email location
    do
       send "${name}" "${email}" "${location}" "$2"
    done < "$1"
fi