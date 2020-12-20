# Info

Stores data generated from the Scrapers located at [NickyBoy89/quacs-oxy-scraper](https://github.com/NickyBoy89/quacs-oxy-scraper)

## What all the data stored means

1. `courses.json` contains the actual information about the courses
1. `mod.rs` Contains many things, such as binary collision checking for individual courses
1. `catalog.json` Returns the course catalog (different from `courses.json`, which returns specific data about the courses themselves, such as units and start times)
1. `rmp.json` Returns the data from [RateMyProfessors](https://ratemyprofessors.com)
1. `prerequisites.json` Find the prerequisites, corequisites, and restrictions for each course
1. `faculty.json` Contains all the faculty members, from the faculty directory
