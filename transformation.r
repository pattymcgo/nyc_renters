# Data overview before clean up
print(skim(nyc_data))

# Industry Label includes null values, let's replace with "unknown"
nyc_data$INDP_label[is.na(nyc_data$INDP_label)] <- "unknown"

# Person income includes negative values, let's remove that
nyc_data <- nyc_data %>% 
  # Filter out 0 or lower in income
  filter(
    PINCP > 0   
  )

# Identify Information industry codes
information_industry_codes <- c("7380", "6471", "6481", "6490", "6570", "6590", "6671", "6672", "6680", "6690", "6695", "6770", "6781")

# Filter for information workers in NYC
nyc_information_data <- nyc_data %>%
  filter(PUMA %in% nyc_puma_codes,
         INDP %in% information_industry_codes)

# Calculate the total estimated population using person-weight column
population_nyc_information <- sum(nyc_information_data$PWGTP)

# Print the population results
print(paste("Estimated population of information workers that are renters in NYC:", scales::comma(population_nyc_information)))

# Identify Finance industry codes
finance_industry_codes <- c("6871", "6881", "6890", "6970", "6991", "6992", "9380" )

# Filter for finance workers in NYC
nyc_finance_data <- nyc_data %>%
  filter(PUMA %in% nyc_puma_codes,
         INDP %in% finance_industry_codes)

# Calculate the total estimated population using person-weight column
population_nyc_finance <- sum(nyc_finance_data$PWGTP)

# Print the population results
print(paste("Estimated population of finance workers that are renters in NYC:", scales::comma(population_nyc_finance)))

# Data overview after clean up
print(skim(nyc_data))
