# Load required libraries
install.packages("anytime")

library(prophet)
library(anytime)
library(ggplot2)

# Read the CSV file
df <- read.csv("/Users/bipulkumar/Downloads/Time_Series/ts_data.csv")

# Rename columns
colnames(df) <- c("ds", "y")

# Convert 'ds' column to Date format
df$ds <- anydate(df$ds)

# Create Prophet model
m <- prophet(df)

# Make future dataframe for forecasting
future <- make_future_dataframe(m, periods = 15)

# Forecast
forecast <- predict(m, future)

# Plot forecast
plot(m, forecast)

# Plot forecast components
prophet_plot_components(m, forecast)

View(forecast)
