#!/bin/bash

usage() { echo "
Használati útmutató:
    Név
        Overwatch Profile Tracker
    Szinopszis
        ./owtracker [OPTION]... {ARGS}
    Leírás
        Lekéri egy valid BATTLETAG-el rendelkező játékos adatait
        egy adott régión és platformon belül.

        -p
            platform, valid értékei = pc/ps/xbox
            explicit megadása nem okoz problémát
            default=pc
        
        -r
            region, valid értékei = eu/us
            explicit megadása nem okoz problémát
            default=eu

        -b
            battletag, valid értéknek az számít, ha a név és az utána levő szám '-' van elválasztva eg. Lukemino-1741
            kötelező megadni!

        -q
            quickplay stats, paraméter nélküli kapcsoló

        -c
            competitive stats, paraméter nélküli kapcsoló

        -g
            competitive ratings role szerint, paraméter nélküli kapcsoló

        -h
            használati útmutató

    Használat
        ./owtracker.sh -p pc -r us -b Lukemino-1741 -qcg

"; }

platform="pc"
region="eu"
battletag=""
url=""

#battletag="Lukemino-1741"
#battletag="eqo-21439"
#battletag="Marwel-21468"
#battletag="FunnyAstro-2570"
#battletag="Saamanka-2565"

while getopts ":hcqgp:r:b:" o; do
    case "${o}" in
        p)
            p=${OPTARG}
            ;;
        r)
            r=${OPTARG}
            ;;
        b)
            battletag=${OPTARG}
            url="https://ow-api.com/v1/stats/$platform/$region/$battletag/profile"
            curl -sS $url >> data
            nev=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["name"]
except:
    print("No data")'`
            echo "Battletag: "$nev
            privacy=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["private"]
except:
    print("No data")'`
            echo "Private: "$privacy
            rating=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["rating"]
except:
    print("No data")'`
            echo "Ranked Score(SR): "$rating
            level1=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["prestige"]
except:
    print("No data")'`
            level2=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["level"]
except:
    print("No data")'`
            echo "Account level: "$level1$level2
            endorsement=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["endorsement"]
except:
    print("No data")'`
            echo "Endorsement: "$endorsement
            #role=`python -c 'import json, os; d=json.loads(open("data").read()); print d["role"]'`
            #echo $role
            ;;
        q)
            #quick play
            echo "-Quick Play stats:"
            qpPlayed=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["quickPlayStats"]["games"]["played"]
except:
    print("No data")'`
            echo " Played: "$qpPlayed
            qpWon=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["quickPlayStats"]["games"]["won"]
except:
    print("No data")'`
            echo " Won: "$qpWon
            qpmedals=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["quickPlayStats"]["awards"]["medals"]
except:
    print("No data")'`
            echo " Medals: "$qpWon
            qpbronze=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["quickPlayStats"]["awards"]["medalsBronze"]
except:
    print("No data")'`
            echo " Bronze: "$qpbronze
            qpsilver=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["quickPlayStats"]["awards"]["medalsSilver"]
except:
    print("No data")'`
            echo " Silver: "$qpsilver
            qpgold=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["quickPlayStats"]["awards"]["medalsGold"]
except:
    print("No data")'`
            echo " Gold: "$qpgold
            ;;
        c)
            #competitive
            echo "-Competitive Stats:"

            cPlayed=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["competitiveStats"]["games"]["played"]
except:
    print("No data")'`
            echo " Played: "$cPlayed
            cWon=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["competitiveStats"]["games"]["won"]
except:
    print("No data")'`
            echo " Won: "$cWon
            cmedals=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["competitiveStats"]["awards"]["medals"]
except:
    print("No data")'`
            echo " Medals: "$cWon
            cbronze=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["competitiveStats"]["awards"]["medalsBronze"]
except:
    print("No data")'`
            echo " Bronze: "$cbronze
            csilver=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["competitiveStats"]["awards"]["medalsSilver"]
except:
    print("No data")'`
            echo " Silver: "$csilver
            cgold=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["competitiveStats"]["awards"]["medalsGold"]
except:
    print("No data")'`
            echo " Gold: "$cgold
            ;;
        g)
            #competitive ratings
            echo "-Competitive Ratings by Role"
            crT=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["ratings"][0]["role"]
except:
    print("No data")'`
            echo " Role: "$crT
            crTR=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["ratings"][0]["level"]
except:
    print("No data")'`
            echo " Rating: "$crTR
            crD=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["ratings"][1]["role"]
except:
    print("No data")'`
            echo " Role: "$crD
            crDR=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["ratings"][1]["level"]
except:
    print("No data")'`
            echo " Rating: "$crDR
            crS=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["ratings"][2]["role"]
except:
    print("No data")'`
            echo " Role: "$crS
            crSR=`python -c '
import json, os
d=json.loads(open("data").read())
try:
    print d["ratings"][2]["level"]
except:
    print("No data")'`
            echo " Rating: "$crSR
            ;;
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))


FILE=data
if [ -f "$FILE" ]; then
    #echo "$FILE exist"
    rm data
fi