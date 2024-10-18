import pandas as pd
import numpy as np

# Assuming your dataframe is named 'selected_df'
# If it's not loaded, uncomment and modify the following line:
selected_df = pd.read_csv('deduplicated_nhanes_data.csv.csv')

def analyze_data_quality(df):
    # Calculate the total number of rows
    total_rows = len(df)
    
    # Calculate missing values
    missing_values = df.isnull().sum()
    
    # Calculate percentage of missing values
    missing_percentage = 100 * df.isnull().sum() / total_rows
    
    # Calculate number of unique values
    unique_values = df.nunique()
    
    # Create a summary dataframe
    summary_df = pd.DataFrame({
        'Missing Values': missing_values,
        'Missing Percentage': missing_percentage,
        'Unique Values': unique_values
    })
    
    # Sort by missing percentage in descending order
    summary_df = summary_df.sort_values('Missing Percentage', ascending=False)
    
    # Format the Missing Percentage to 2 decimal places
    summary_df['Missing Percentage'] = summary_df['Missing Percentage'].round(2)
    
    return summary_df

# Run the analysis
data_quality_summary = analyze_data_quality(selected_df)

# Display the results
print(data_quality_summary)

# Optionally, save the results to a CSV file
data_quality_summary.to_csv('data_quality_summary.csv')
print("Data quality summary saved to 'data_quality_summary.csv'")

# Additional analysis: columns with more than 50% missing values
high_missing = data_quality_summary[data_quality_summary['Missing Percentage'] > 50]
if not high_missing.empty:
    print("\nColumns with more than 50% missing values:")
    print(high_missing)
else:
    print("\nNo columns have more than 50% missing values.")

# Data types of columns
print("\nData types of columns:")
print(selected_df.dtypes)