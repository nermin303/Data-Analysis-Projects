# Forbes Top Companies (2017-2024) – Data Analysis Insights 🚀
## Project Objectives
This project aims to:
- Analyze the top Forbes-listed companies from 2017 to 2024.
- Identify trends in profitability, market value, sales, and assets.
- Examine the global distribution of top-performing companies.
- Compare corporate sales with national GDPs to understand economic influence.
- Develop an interactive Tableau dashboard for data visualization.

### About the Dataset
The dataset is sourced from Forbes' annual ranking of the top 2000 companies worldwide. It contains approximately **16,000 rows**, with **2000 companies ranked each year** from 2017 to 2024. Many companies appear multiple times, as they are ranked annually based on financial performance. The dataset includes metrics such as market value, sales, profits, assets, and regional distribution.

## Data Cleaning in Python
Data preprocessing was performed to handle inconsistencies and ensure accuracy. This included:
- Removing special characters from column names and values.
- Stripping whitespace.
- Converting numerical columns to the correct data types.

For detailed code implementation, refer to the **`DataCleaning_2000Companies`** file in the repository.

## Tableau Dashboard
The Tableau dashboard provides interactive insights into the key findings mentioned above. You can explore trends in market value, profits, sales, and corporate dominance globally.
### Dashboard Overview:
1. **Part 1 - General KPIs:**
   - Provides an overview of profits, sales, market value, and assets.
   - Highlights trends across different years and regions.

2. **Part 2 - Top Companies by Sales:**
   - Focuses on companies with the highest sales performance.
   - Allows deeper insights into corporate giants and their annual rankings.
  
   ### Key Insights
- **Top & Bottom Performers** – Identified the most profitable and least profitable companies.
- **Market Leaders** – Highlighted the top companies by market value.
- **Market Value vs. Profit** – Analyzed the relationship between them.
- **Global Distribution** – Examined the number of Forbes-listed companies across different regions.
- **KPI Dashboard** – Showcased profits, market value, sales, and assets.
- **Country Sales vs. Global Average** – Highlighted nations outperforming the world’s average sales.
- **Top Sales Companies** – Provided more details about the top companies with the highest sales.
- **GDP vs. Corporate Sales** – Compared national GDPs with company sales.

### Key Findings
- **Regional Dominance** – East Asia & Pacific and North America have the most Forbes-listed companies.
- **Market Value vs. Profits**
  - High market value does not mean high profits.
  - Microsoft leads in market value, but Saudi Aramco generates the highest profits.
- **Sales Giants**
  - The US, China, and Saudi Arabia boast average sales higher than the global average.
- **Corporate Power vs. National GDP**
  - The UAE’s GDP (2nd highest in MENA) matches Walmart’s sales.
  - Egypt’s GDP is less than the combined sales of the Top 5 companies.


## Repository Structure
- **`book5.twb`** – Tableau visualization file.
- **`Merged_Companies_WB_Regions(2017-2024) final.xlsx`** – Raw data file.
- **`DataCleaning_2000Companies.ipynb`** – Python script used for data cleaning and analysis.
