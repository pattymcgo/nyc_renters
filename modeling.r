# Create Employment Dimension Table
dim_employment <- nyc_data %>%
  select(SERIALNO, COW, COW_label, INDP, INDP_label) %>%
  distinct() %>%
  mutate(EmploymentKey = row_number()) # Add a surrogate key

# Create Location Dimension Table
dim_location <- nyc_data %>%
  select(SERIALNO, PUMA, STATE, STATE_label) %>%
  distinct() %>%
  mutate(LocationKey = row_number()) # Add a surrogate key

# Create Housing Dimension Table
dim_housing <- nyc_data %>%
  select(SERIALNO, TEN, TEN_label) %>%
  distinct() %>%
  mutate(HousingKey = row_number()) # Add a surrogate key

# Create Fact Table
fact_nyc_data <- nyc_data %>%
  left_join(dim_employment, by = c("SERIALNO" = "SERIALNO"), relationship = "many-to-many") %>%
  left_join(dim_location, by = c("SERIALNO" = "SERIALNO"), relationship = "many-to-many") %>%
  left_join(dim_housing, by = c("SERIALNO" = "SERIALNO"), relationship = "many-to-many") %>%
  select(SurveyResponseKey = SERIALNO, EmploymentKey, LocationKey, HousingKey, SPORDER, WGTP, PWGTP, PINCP, GRPIP)

# Check for null values after dimension and fact table creation
print(skim(fact_nyc_data))

# Interactive authentication
bq_auth() 

# Alternatively, using a service account key file
# bq_auth(path = "/Users/patty_home/Desktop/Baruch Fall 25/CIS9440 Data Warehousing/solid-box-477315-m0-bb44bee74c9e.json") 

# Connect to Google BigQuery
con <- dbConnect(
  bigrquery::bigquery(),
  project = "solid-box-477315-m0",
  dataset = "nyc_renters1",
  billing = "solid-box-477315-m0"
)

# Load dimension tables
dbWriteTable(
  con,
  name = "dim_employment",
  value = dim_employment,
  overwrite = TRUE 
)

dbWriteTable(
  con,
  name = "dim_location",
  value = dim_location,
  overwrite = TRUE 
)

dbWriteTable(
  con,
  name = "dim_housing",
  value = dim_housing,
  overwrite = TRUE 
)

# Load fact table
dbWriteTable(
  con,
  name = "fact_nyc_data", 
  value = fact_nyc_data,
  overwrite = TRUE 
)
