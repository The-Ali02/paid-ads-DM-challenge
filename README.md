Welcome to my dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

Paid Ads Data Modelling

This document outlines our data model for social advertising data, a design built for robust reporting and long-term scalability.

**Note: ** _Due to issue with my debit card not having international transfers enable causing failure for Google BigQuery signup and I couldn't resolve this on weekends, I have used Snowflake as my data storage connection and sigma computing for charts generation._
_If needed I can provide credentials to snowflake, sigma for evaluators to verify the authenticity of my task completion._

- **[Dashboard Report](https://github.com/The-Ali02/paid-ads-DM-challenge/blob/main/Improvado%20MCDM%20challenge%20dashboard.pdf)**
<img width="1082" height="800" alt="image" src="https://github.com/user-attachments/assets/a466a187-eccc-4224-8ef0-c17ebe6cf3cc" />


- **[Precise Metrics View](https://github.com/The-Ali02/paid-ads-DM-challenge/blob/main/Reporting%20Table.pdf)**
<img width="1652" height="378" alt="image" src="https://github.com/user-attachments/assets/66b438e0-05ba-45d4-811e-97b63b486aae" />



For the Generated Dashboard report from `paid_ads_basic_performance` reporting table: [Sigma Reporting Dashboard](https://app.sigmacomputing.com/paid-ads/workbook/workbook-6hVGQ80niUkyAKdVDGcOVE?:link_source=share)

### 1. Core Data Architecture: The Star Schema

* **Fact Table**: A single `fact_social_ads_performance` table serves as our central source of truth. It stores all quantitative metrics (e.g., clicks, spend, impressions) from every ad platform. This approach simplifies reporting by providing all core performance data in one place, eliminating the need for complex multi-table queries at BI layer. 
* **Dimension Tables**: Surrounding tables like `dim_campaigns`, `dim_ads`, `dim_adsets` and `dim_creatives` contain all descriptive attributes. This separation of facts and dimensions ensures **data integrity** and significantly **reduces redundancy**, as descriptive data is not duplicated across millions of fact rows.

### 2. Handling Diverse Data from all ad platforms and mapping metrics

Our unified fact table design is a key strength, built to scale as our data sources grow.

- I handled platform-specific metrics (like Twitter's `retweets`) by mapping them with appropriate metric from other platform (like `shares` on facebook) directly in the unified fact table.
-So if we want to see retweets performance at campaign_level on twitter we can just get it by filtering the fact table for `channel='Twitter'` and alias `shares` to `retweets`. 
- For metrics like `SKAN_APP_INSTALL` which are specific to iOS targetted devices are included directly as column.  This "fat" table approach is highly efficient in modern data warehouses, as they are optimized for sparse data, and it allows for new platforms to be integrated seamlessly without requiring a redesign of the entire model.

* **Low-Grain Analysis**: Our design provides the flexibility to create reports at any level of detail not just channel, but campaign_level, ad_set level, ad level or even creative level(facebook) from each platform.

Having worked with ad data before, I could figure out how we can get `engagement` metric for facebook data:
`        (likes + views + clicks + shares + comments) as ENGAGEMENTS` any action that user has made with our advertisement is classified as an engaging action. Eg: Viewing a ad video for > 3sec counts as view, likes, shares, clicks, comments are by themselves an action from the user side with the advertisement. 

The MCDM structure provided is indeed helpful in creating the targetted dashboard for reporting of **Ads Performance** but columns like `placement_id` metrics like `post_view/click_conversion` which are not properly defined in our raw data shouldn't be included in reporting table.

 
