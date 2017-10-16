#!/bin/bash

echo "Start up postgres"
docker-compose up -d
echo "Wait for it..."
sleep 5

echo "Clean up csv files"
rm */*.csv

# start with 1 to iterate over only timestamp directories

# tar -xf wals.tar
let total=0
cd wals
for dir in 1*/ ; do 
    dir="${dir%/}" 
    echo "Processing $dir";
    cd $dir
    time=`date -r $dir`
    echo "Timestamp is $time"

    for file in *.txt ; do
        system=`echo $file | sed -e 's/-.*//'`
        grep -E "[0-9A-F]{24}$" "$file" | awk '{print "\""$6" "$7"\","$9",""'"$system"',\"'"$time"'\""}' > $system.csv
        read lines filename <<< $(wc -l "$system.csv")
        echo "> File '$file' is for '$system' with $lines lines"
        let total=total+lines
    done

    cd ..
done
cd ..

cat wals/*/*.csv > all.csv
wc -l all.csv
echo "Total lines readed: $total. Loading..."
docker-compose exec postgres psql -U postgres test -c "copy temp from '/data/all.csv' DELIMITER ',';"
echo "Removing duplicates"
docker-compose exec postgres psql -U postgres test -c "INSERT INTO wals SELECT DISTINCT ON (filename, system) * FROM temp ORDER BY filename, system, collected_at DESC;"
