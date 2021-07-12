# Pull down the scrapers
sudo rm -r quacs-oxy-scraper
cp -r ~/git/quacs-oxy-scraper .

# Generate semesters
echo "Generating semesters"
if [ -f "semesters.json" ]; then
  echo "semesters.json exists, skipping it"
else
  python3 quacs-oxy-scraper/semesters/main.py
fi

# Function that scrapes a semester
function scrape_semester () {
  cd semester_data/$1
  # RateMyProfessors scraper is not really used for anything
  # python3 quacs-oxy-scraper/rmp_scraper/main.py $semester

  # Generate the catalog.json because the sis_scraper needs it
  python3 ../../quacs-oxy-scraper/catalog_scraper/main.py $1
  # Launch all the other scrapers in their own processes
  python3 ../../quacs-oxy-scraper/prerequisite_scraper/main.py $1 &
  python3 ../../quacs-oxy-scraper/school_scraper/main.py $1 &
  # The sis scraper needs the catalog
  python3 ../../quacs-oxy-scraper/sis_scraper/main.py $1
  # Wait for all the scrapers to finish
  wait
}

# Loop through the semesters and scrape them
while read semester; do
  # Create a folder for each semester
  mkdir -p semester_data/$semester
  echo "Starting work on semester $semester"
  # To skip a range of semesters that are already generated, set this number to the highest semester generated
  # 0 just disables it
  if [ $semester -lt 0 ]
  then
    echo "Skipping semester $semester"
    continue
  fi

  scrape_semester $semester &
done <semesters.json

# Wait for semesters to finish scraping
wait

echo "Create meta.json"
echo {\"last_updated\":\"$(date --iso-8601=seconds -u)\"} > meta.json

echo "Generate the prerequisite graph"
python3 quacs-oxy-scraper/prerequisites_graph/main.py semester_data prereq_graph.json

echo "Clean up files"
rm semesters.json
