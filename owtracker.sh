#!/bin/bash

usage() { echo "Valami szöveg! "; }

platform="pc"
region="eu"
battletag=""
url=""

#battletag=eqo-21439
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
            nev=`python -c 'import json, os; d=json.loads(open("data").read()); print d["name"];'`
            echo "Battletag: "$nev
            privacy=`python -c 'import json, os; d=json.loads(open("data").read()); print d["private"]'`
            echo "Private: "$privacy
            rating=`python -c 'import json, os; d=json.loads(open("data").read()); print d["rating"]'`
            echo "Ranked Score(SR): "$rating
            level1=`python -c 'import json, os; d=json.loads(open("data").read()); print d["prestige"]'`
            level2=`python -c 'import json, os; d=json.loads(open("data").read()); print d["level"]'`
            echo "Account level: "$level1$level2
            endorsement=`python -c 'import json, os; d=json.loads(open("data").read()); print d["endorsement"]'`
            echo "Endorsement: "$endorsement
            #role=`python -c 'import json, os; d=json.loads(open("data").read()); print d["role"]'`
            #echo $role
            ;;
        q)
            #quick play
            echo "-Quick Play stats:"
            qpPlayed=`python -c 'import json, os; d=json.loads(open("data").read()); print d["quickPlayStats"]["games"]["played"]'`
            echo " Played: "$qpPlayed
            qpWon=`python -c 'import json, os; d=json.loads(open("data").read()); print d["quickPlayStats"]["games"]["won"]'`
            echo " Won: "$qpWon
            qpmedals=`python -c 'import json, os; d=json.loads(open("data").read()); print d["quickPlayStats"]["awards"]["medals"]'`
            echo " Medals: "$qpWon
            qpbronze=`python -c 'import json, os; d=json.loads(open("data").read()); print d["quickPlayStats"]["awards"]["medalsBronze"]'`
            echo " Bronze: "$qpbronze
            qpsilver=`python -c 'import json, os; d=json.loads(open("data").read()); print d["quickPlayStats"]["awards"]["medalsSilver"]'`
            echo " Silver: "$qpsilver
            qpgold=`python -c 'import json, os; d=json.loads(open("data").read()); print d["quickPlayStats"]["awards"]["medalsGold"]'`
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
            cWon=`python -c 'import json, os; d=json.loads(open("data").read()); print d["competitiveStats"]["games"]["won"]'`
            echo " Won: "$cWon
            cmedals=`python -c 'import json, os; d=json.loads(open("data").read()); print d["competitiveStats"]["awards"]["medals"]'`
            echo " Medals: "$cWon
            cbronze=`python -c 'import json, os; d=json.loads(open("data").read()); print d["competitiveStats"]["awards"]["medalsBronze"]'`
            echo " Bronze: "$cbronze
            csilver=`python -c 'import json, os; d=json.loads(open("data").read()); print d["competitiveStats"]["awards"]["medalsSilver"]'`
            echo " Silver: "$csilver
            cgold=`python -c 'import json, os; d=json.loads(open("data").read()); print d["competitiveStats"]["awards"]["medalsGold"]'`
            echo " Gold: "$cgold
            ;;
        g)
            #competitive ratings
            echo "-Competitive Ratings by Role"
            crT=`python -c 'import json, os; d=json.loads(open("data").read()); print d["ratings"][0]["role"]'`
            echo " Role: "$crT
            crTR=`python -c 'import json, os; d=json.loads(open("data").read()); print d["ratings"][0]["level"]'`
            echo " Rating: "$crTR
            crD=`python -c 'import json, os; d=json.loads(open("data").read()); print d["ratings"][1]["role"]'`
            echo " Role: "$crD
            crDR=`python -c 'import json, os; d=json.loads(open("data").read()); print d["ratings"][1]["level"]'`
            echo " Rating: "$crDR
            crS=`python -c 'import json, os; d=json.loads(open("data").read()); print d["ratings"][2]["role"]'`
            echo " Role: "$crS
            crSR=`python -c 'import json, os; d=json.loads(open("data").read()); print d["ratings"][2]["level"]'`
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