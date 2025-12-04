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

# Data overview after clean up
print(skim(nyc_data))
