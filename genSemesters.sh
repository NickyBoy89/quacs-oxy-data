semesters=( "201701" "201702" "201703" "201801" "201802" "201803" "201901" "201902" "201903" "202001" "202002" "202003" "202101" "202102" )

datadir="/home/nicholas/Projects/quacs-oxy-data"
scrapedir="/home/nicholas/Projects/quacs-oxy-scraper"

for semester in "${semesters[@]}";
do
  mkdir $semester
  cd $semester

  echo "Catalog scraper"
  python3 ${scrapedir}/catalog_scraper/main.py $semester

  echo "Prereq Scraper"
  python3 ${scrapedir}/prerequisite_scraper/main.py $semester

  echo "SIS Scraper"
  python3 ${scrapedir}/sis_scraper/main.py $semester

  cd $datadir
done
