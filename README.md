
## Directory Structure

This README provides an overview of our project's directory structure and guidelines for what to place in each folder.

### /data

This directory contains all our data files.

- **/raw_tables**: Store all individual raw data tables here.
  - Example: `P_ALB_CR.XPT`, `P_ALQ.XPT`, etc.
- `merged_data_clean.csv`: The final merged dataset combining all raw tables.
- `data_quality_summary.csv`: Summary of data quality checks for our datasets.

### /logs

This directory is for storing operational logs.

- `deduplication_log.csv`: Log of the deduplication process, including any records removed.

### /scripts

Store all scripts used for data processing, cleaning, and analysis here.

- `data_quality_check.py`: Script for checking the raw data.
- `convert_XPT.R`: Script for merging individual tables.

### /docs

This folder is for project documentation.

- `data_desc.txt`: Definitions and classes of all variables in our datasets.

### /EDA

Store your analysis files here, such as Jupyter notebooks/ R markdown.
- `background-and-data.ipynb`: Missing data analysis, and some EDA

### /results

This directory is for outputs of your analysis.

- **/figures**: Store all generated plots and visualizations here.
- **/reports**: Place any written reports or findings here.

## Guidelines

1. Try to work on a separate branch when making changes.
2. Ensure all data files are in the correct format before committing.
3. Document any new scripts or major changes in the README.=

