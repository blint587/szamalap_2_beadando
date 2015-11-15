#!/bin/bash

: '
Feladat: Készítsen egy találkozóra hívó körlevél készítő szkriptet! A szkript paramétere legyen két fájl,
az egyik a körlevél szövege, a másik az „adatbázis”. A körlevél szövegében <> között helyezzük el a mezőneveket(,,),
amelyek aktuális értékét az adatbázis fájlból olvassuk ki. Az adatbázist tartalmazó fájl soronként három adatot
tartalmaz, a címzett nevét, címét és találkozó helyét! A körlevelek a szabványos kimenetre kerüljenek kiírásra!
 '


function send(){
    email=$(cat $4 | sed "s/\(<name>\)/${1}/g" | sed "s/\(<location>\)/${3}/g")
    echo "To: ${2}"
    echo "Subject: Meghívó"
    echo ${email}
    echo
}



hiba=0  # hiba létének tárolására szolgáló változó

if [[ $# -ne 2 ]]
then
    echo "Nem megfelő számú argumentum! A script 2 argumentumot vár, az első a névjegyzék a második az email szövege."
    exit 1
fi

if ! [[ -f ${1} ]]
then
    ${hiba}=$(expr ${hiba} + 1)
    echo "${hiba}: A megadott névjegyzék nem létezik!"
fi

if ! [[ -f ${2} ]]
then
    ${hiba}=$(expr ${hiba} + 1)
    echo "${hiba}: Az levél szövegét tartalmazó fájl nem létezik!"
fi

if [[ ${hiba} -ne 0 ]]
then
    exit ${hiba}
else

    while IFS=',' read -r name email location
    do
       send "${name}" "${email}" "${location}" "${2}"
    done < "$1"
fi