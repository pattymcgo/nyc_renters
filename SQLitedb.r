# Create data warehouse using SQLite and CSV file in R
# Intstall and load package
install.packages("RSQLite")
library(RSQLite)

# Establish database connection
db_file <- "my_data_warehouse.sqlite"
conn <- dbConnect(RSQLite::SQLite(), dbname = db_file)

# Read csv into dataframe
renters_data <- read_csv("/Users/patty_home/Desktop/Baruch Fall 25/CIS9440 Data Warehousing/NYC_Renters.csv")

# Populate table into database
dbWriteTable(conn, "fact_renters", renters_data, overwrite = TRUE) # append = TRUE to add rows to existing table

# Disconnect from database
dbDisconnect(conn)
