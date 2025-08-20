Welcome to my dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

## README: Social Ads Data Model

This document outlines our data model for social advertising data, a design built for robust reporting and long-term scalability.

### 1. Core Data Architecture: The Star Schema

Our data is structured as a **star schema**, a highly efficient and widely-used model for business intelligence. This design consists of a central, unified **fact table** surrounded by multiple **dimension tables**.

* **Fact Table**: A single `fact_social_ads_performance` table serves as our central source of truth. It stores all quantitative metrics (e.g., clicks, spend, impressions) from every ad platform. This approach simplifies reporting by providing all core performance data in one place, eliminating the need for complex multi-table queries. 
* **Dimension Tables**: Surrounding tables like `dim_campaigns`, `dim_adsets`, and `dim_creatives` contain all descriptive attributes. This separation of facts and dimensions ensures **data integrity** and significantly **reduces redundancy**, as descriptive data is not duplicated across millions of fact rows.

### 2. Scalability and Handling Diverse Data

Our unified fact table design is a key strength, built to scale as our data sources grow.

* **Future-Proofing**: We handle platform-specific metrics (like Twitter's `retweets`) by including their columns directly in the unified fact table. This "fat" table approach is highly efficient in modern data warehouses, as they are optimized for sparse data, and it allows for new platforms to be integrated seamlessly without requiring a redesign of the entire model. The structure effortlessly accommodates new channels and their unique metrics, ensuring our data model remains robust as we scale.
* **Flexible Reporting**: Our design provides the flexibility to create reports at any level of detail.
    * **Low-Grain Analysis**: Analysts can directly query the core `fact_social_ads_performance` table for detailed, atomic-level insights.
    * **High-Grain Reporting**: We build pre-aggregated **reporting tables** on top of the star schema. These materialized views (e.g., `rpt_daily_campaign_performance`) summarize data at a higher level, significantly improving the performance of our dashboards and common reports by eliminating on-the-fly calculations.