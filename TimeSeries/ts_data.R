# Load required libraries
library(tidyverse)
library(lubridate)
library(forecast)

# Read the CSV file with column specifications
df <- read_csv("/Users/bipulkumar/Downloads/Time_Series/ts_data.csv", skip = 1, col_types = cols(
  Month = col_character(),
  `Perrin Freres monthly champagne sales millions ?64-?72` = col_double()
), col_names = FALSE)

# Clean up the data
colnames(df) <- c("Month", "Sales")
df <- df[complete.cases(df), ]
df$Month <- as.Date(paste0(df$Month, "-01"), format = "%Y-%m-%d")

# Convert Month into a time series object
ts_data <- ts(df$Sales, frequency = 12, start = decimal_date(as.Date(min(df$Month))))

# Fit an ARIMA model
model <- auto.arima(ts_data)
summary(model)

# Generate forecasts
forecast_data <- forecast(model, h = 14)

# Plot original data and forecasts
plot(forecast_data, main = "Sales Forecast")

# Save the model
saveRDS(model, file = "finalized_model.rds")

# Load the model
loaded_model <- readRDS("finalized_model.rds")
summary(loaded_model)
