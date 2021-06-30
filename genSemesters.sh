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

# Loop through the semesters and scrape them
while read semester; do
  # Create a folder for each semester
  mkdir -p semester_data/$semester
  echo "Starting work on semester $semester"
  # To skip a range of semesters that are already generated, set this number to the highest semester generated
  if [ $semester -ne 201601 ]
  then
    echo "Skipping semester $semester"
    continue
  fi

  # RateMyProfessors scraper is not really used for anything
  # python3 quacs-oxy-scraper/rmp_scraper/main.py $semester

  # Generate the catalog.json because the sis_scraper needs it
  python3 quacs-oxy-scraper/catalog_scraper/main.py $semester
  # Launch all the other scrapers in their own processes
  python3 quacs-oxy-scraper/prerequisite_scraper/main.py $semester && mv prerequisites.json semester_data/$semester &
  python3 quacs-oxy-scraper/school_scraper/main.py $semester && mv schools.json semester_data/$semester &
  python3 quacs-oxy-scraper/sis_scraper/main.py $semester && mv courses.json mod.rs semester_data/$semester &
  # Wait for them all to complete
  wait
  # Move the catalog to the correct place, since the sis scraper has finished using it
  mv catalog.json semester_data/$semester
done <semesters.json

echo "Create meta.json"
echo {\"last_updated\":\"$(date --iso-8601=seconds -u)\"} > data/meta.json

echo "Generate the prerequisite graph"
python3 quacs-oxy-scraper/prerequisites_graph/main.py semester_data prereq_graph.json
