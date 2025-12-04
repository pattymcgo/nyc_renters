# Authenticate with Google Cloud
gcs_auth(json_file = "/Users/patty_home/Desktop/Baruch Fall 25/CIS9440 Data Warehousing/solid-box-477315-m0-bb44bee74c9e.json")

# Set bucket
gcs_global_bucket("cis9440_assignments_mcgowan")

# Upload csv with a different name
gcs_upload("/Users/patty_home/Desktop/Baruch Fall 25/CIS9440 Data Warehousing/NYC_Renters.csv", name = "NYC_Renters.csv")

# Modify boundary to 8.0 MB
gcs_upload_set_limit(8000000L)

# Read the downloaded file into data frame
nyc_data <- read.csv("/Users/patty_home/Desktop/Baruch Fall 25/CIS9440 Data Warehousing/NYC_Renters.csv")
