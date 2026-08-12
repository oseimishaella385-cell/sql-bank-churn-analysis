# What factors are associated with customer churn, and what actions should the bank take to improve customer retention?
**Business problem:** The bank is experiencing customer attrition and wants to understand which customer groups are most likely to churn and where retention efforts should be prioritised.


---

## ⚙️ Project Type Flags

- [x] Exploratory Data Analysis (EDA)
- [x] SQL Analysis / Querying
- [x] Dashboard / Data Visualisation
- [ ] Data Pipeline / ETL
- [ ] Predictive Modelling / Machine Learning
- [x] Data Cleaning / Wrangling
- [x] End-to-End (multiple of the above)

---

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [Objectives](#2-objectives)
3. [Project Scope & Tools](#3-project-scope--tools)
4. [Repository Structure](#4-repository-structure)
5. [Data Workflow](#5-data-workflow)
6. [Data Model & Schema](#6-data-model--schema)
7. [Data Model & Analytical Architecture](#7-data-model--analytical-architecture) 
8. [Analysis & Metrics](#8-analysis--metrics)
9. [Key Insights](#9-key-insights)
10. [Recommendations](#10-recommendations)
11. [Assumptions & Limitations](#11-assumptions--limitations)
12. [Future Enhancements](#12-future-enhancements)
13. [Deliverables](#13-deliverables)
14. [Author](#14-author)

---

## 1. Project Overview

**Context:** A mid-sized bank is experiencing customer attrition and needs greater insight into the customers most at risk of leaving.

**Problem Statement:** The bank lacks a clear understanding of the demographic, behavioural and financial characteristics associated with customer churn, making it difficult to determine where retention efforts should be prioritised.

**Approach:** Customer data was analysed using SQL to calculate churn rates, segment customers by demographic, behavioural and financial characteristics, and identify high-risk customer groups.

 **Outcome:** The analysis identified several customer characteristics associated with elevated churn, including age, inactivity, product ownership, and account balance. The findings were presented in an interactive Power BI dashboard designed to help management identify priority customer segments for retention initiatives.

---

## 2. Objectives

 **Primary Objective:** Identify the customer characteristics and behaviours  associated with churn to support more targeted retention decisions. 
- **Secondary Objective 1:** Measure the overall churn rate to establish a baseline.
- **Secondary Objective 2:** Identify demographic groups with elevated churn across age, gender and geography.
- **Secondary Objective 3:** Evaluate behavioural factors including tenure, membership activity, product ownership and credit card ownership.
- **Secondary Objective 4:** Identify high-risk customer segments through multi-factor segmentation.

## 2b. Analytical Questions ##

The analysis was designed to answer:
- Who is churning?
- What customer behaviours are associated with churn?
- Are financially valuable customers being lost?
- Which combinations of characteristics identify the highest-risk customer segments?
- Where should retention efforts be prioritised?

---

## 3. Project Scope & Tools

### Scope

| Dimension | Details |
|-----------|---------|
| **In Scope** | Customer-level data for 10,000 bank customers across France, Germany and Spain. Analysis covers customer demographics, behaviour, financial characteristics, churn rates and high-risk customer segments.
| **Out of Scope** | Transaction-level activity, customer acquisition data and historical churn trends were excluded because the supplied dataset is a customer-level snapshot and does not contain transaction dates or longitudinal customer records. Individual customer-level analysis was also excluded; 'CustomerID' and 'Surname' were not required for the group-level churn analysis. |
| **Time Period** | No transaction date or historical time period is provided in the dataset. |
| **Granularity** | Customer level, with one row representing one customer and 10,000 records in total.|

### Tools & Technologies

| Category | Tool(s) Used |
|----------|-------------|
| Data Storage |  CSV files |
| Data Processing |  SQL, Excel |
| Analysis | Custom SQL queries |
| Visualisation |  Power BI |
| Version Control | GitHub |
| Documentation |  Markdown |

---

## 4. Repository Structure

```
sql-bank-churn-analysis/
│
├── data/
│   └── raw/
│       └── bank_customer_churn.csv
│
├── queries/
│   ├── exploratory/
│   │   └── tenure_hypothesis.sql
│   │
│   ├── transformations/
│   │   └── create_customer_analysis_view.sql
│   │
│   └── final/
│       ├── 01_kpi_metrics.sql
│       ├── 02_demographic_churn.sql
│       ├── 03_customer_behaviour.sql
│       ├── 04_financial_profile.sql
│       └── 05_high_risk_segments.sql
│
├── visuals/
│   ├── Pg1_Churn_overview_dashboard.png
│   ├── Pg1_Churn_overview_Germany.png
│   ├── Pg1_tenure_interaction.png
│   ├── Pg2_financial_profile_dashboard.png
│   ├── Pg2_customer_seg_interaction.png
│   └── powerbi_data_model.png
│   
│
└── README.md
```



## 5. Data Workflow

```
[Kaggle CSV Dataset]
10,000 bank customers
      ↓
[MySQL Ingestion]
CSV imported into `customers` table
      ↓
[Cleaning & Transformation]
Data validation - Binary labels - Customer groupings
      ↓
[SQL Analysis]
Churn KPIs - Hypothesis testing - Segmentation - Financial analysis
      ↓
[Power BI]
Interactive dashboard - key insights - retention recommendations
```

1. **Source:** Bank Customer Churn Prediction Dataset downloaded from Kaggle. One CSV file containing 10,000 customer records across three countries (France, Germany and Spain), with demographic, behavioural and financial attributes.
2. **Ingestion:** Imported the CSV into MySQL using the Table Data Import Wizard. Data was stored in a relational table and queried using SQL before being imported into Power BI for visualisation.
3. **Cleaning:** Validated the dataset for missing values and duplicate records. Removed non-analytical fields (CustomerId and Surname) as they were not required for customer segmentation or churn analysis. Verified data types and binary variables (0/1) for consistency.
4. **Transformation:** Converted binary fields into descriptive categories (e.g. Retained/Churned, Active/Inactive, Credit Card Yes/No). Created age, balance and income groups to support customer segmentation. Calculated churn metrics and summary statistics for demographic, behavioural and financial analysis.
5. **Analysis:** Query-based analysis using SQL with descriptive statistics (counts, averages, medians and percentages) to measure churn, compare customer segments and identify high-risk groups.
6. **Output:** Two-page interactive Power BI dashboard, SQL analysis and documented business recommendations.

---

## 6. Data Model & Schema

### Dataset / Table: `Customers`

| Field Name | Data Type | Description | Example Value |
|------------|-----------|-------------|---------------|
| `CustomerId` |  INT |Unique identifier for each customer| 15634602 |
| `CreditScore` | INT | Customer credit score | 619 |
| `Geography` | VARCHAR | Customer's Country | France |
| `Gender` | VARCHAR| Customer gender| Female|
| `Age` | INT| Customer age |42|
|`Tenure` | INT | Years as a customer | 2 |
| `Balance` | DECIMAL | Current account balance |83807.86|
|`NumOfProducts`| INT | Number of products held | 2 |
| `HasCrCard` | BOOLEAN (0/1) | Credit card ownership | 1 |
| `IsActiveMember` | BOOLEAN (0/1) | Active membership status | 1 |
| `EstimatedSalary` | DECIMAL | Estimated annual salary (£) | 101348.88|
| `Exited` | BOOLEAN (0/1) | Customer churn indicator | 1 |

> **Row count (approx.):** 10,000 rows
> **Date range:** Not applicable
> **Key join / relationship:** None (single-table dataset)
> **Primary Key** CustomerId



---

## 7. Data Model & Analytical Architecture

The data model below shows how the source customer data was structured into analytical outputs for Power BI.

###                          CUSTOMERS
                    (Main Source Table)
                            │
          ┌─────────────────┼──────────────────┐
          ↓                 ↓                  ↓
     KPI Results      Demographic         Behavioural
                      Analysis            Analysis
                          │                    │
                    Age / Gender       Tenure / Products
                    / Geography        / Activity / Card
                          │                    │
          └─────────────────┼──────────────────┘
                            ↓
                     Financial Analysis
                 Balance / Salary / Credit
                            │
                            ↓
                    High-Risk Segments
                            │
                            ↓
                     POWER BI DASHBOARD




---

## 8. Analysis & Metrics

### Analytical Approach
This project used exploratory and descriptive analysis to investigate the factors associated with customer churn. SQL was used to establish the overall churn baseline before comparing churn rates across demographic, behavioural and financial customer segments.

The analysis began by testing the hypothesis that customers with less than one year of tenure would have a higher churn rate, before expanding into broader demographic factors such as age, geography, and gender, and behavioural factors including tenure, product ownership, and membership activity.

Financial characteristics were then analysed by comparing churned and retained customers and examining churn rates across different balance groups. Finally, multi-factor segmentation was used to identify high-risk customer groups and translate the findings into targeted retention recommendations.


### Key Metrics Defined

| Metric | Plain-Language Definition | Why It Matters |
|--------|--------------------------|----------------|
| `Overall Churn Rate` | Percentage of all customers who exited the bank. | Establishes the 20.37% baseline against which customer segments can be compared.
| `Segment Churn Rate` | Percentage of customers within a specific group who churned. | Identifies demographic, behavioural and financial groups with above-average churn. |
| `Churned Customers` | Number of customers who exited the bank. | Shows the actual volume of customer attrition alongside percentage rates. |
| `Average Customer Balance`| Mean account balance across customers| Provides an overview of the financial value held within the customer base.|
| `Balance Held by Churned Customers` | Total account balance associated with customers classified as churned. | Indicates the potential financial significance of customer attrition, without assuming the full balance was lost by the bank.|
| `Median Estimated Salary` | Median estimated salary when customers are ordered by salary. | Allows comparison between churned and retained customers while reducing the influence of extreme salary values.|
|`Average Credit Score`| Mean credit score within a customer group. | Helps determine whether credit profile differs meaningfully between retained and churned customers.|

### Methods Used
Descriptive statistics - counts, percentages, averages and medians.
Segmentation analysis - compared churn across demographic, behavioural and financial customer groups.
Churned vs retained comparison - compared the financial profiles of customers who stayed and exited.
Multi-factor analysis - combined product ownership and membership activity to identify high-risk segments.
SQL aggregation and conditional logic - used COUNT(), SUM(), AVG(), CASE and GROUP BY to produce analytical outputs.
.
## 9. Key Insights

**Insight 1: Middle-aged customers represent the highest churn risk**
Customers aged 50-59 recorded the highest churn rate at 56%, considerably above the 20.37% overall churn rate. Churn was also elevated among customers aged 40-49 and 60-69, suggesting retention efforts should place greater focus on middle-aged and older segments.

**Insight 2: Customer engagement is strongly associated with retention.**
Inactive members recorded a 27% churn rate compared with 14% for active members, making inactivity one of the clearest behavioural factors associated with churn. This implies increasing customer engagement could be an important opportunity for improving retention.

**Insight 3: Geography matters, while credit card ownership appears to have little influence**
Germany recorded a 32% churn rate, approximately twice the rate observed in France and Spain (around 16-17%). In contrast, churn was almost identical between customers with and without a credit card (20% vs 21%), illustrating ownership alone is not an important differentiator of churn.

**Insight 4: Product ownership and activity identify an actionable high-risk segment**
The deeper segmentation analysis found that single-product, inactive customers consistently experienced higher churn than active and multiproduct customers, making this a priority group for retention initiatives. Some customers holding four products recorded churn rates of up to 100%, but these segments contained relatively few customers and should therefore be interpreted cautiously.

**Insight 5: The tenure hypothesis was only partially supported.**
The analysis initially hypothesised that newer customers would be more likely to churn. Customers with zero years of tenure did show elevated churn at approximately 23%, but churn did not consistently decline as tenure increased and fluctuated throughout the customer lifecycle. This shows that tenure alone is not a strong indicator of churn and should be considered alongside other customer characteristics.

**Insight 6: Customer balance is associated with differences in churn risk.**
Churn varied considerably across balance groups, with customers holding £1–£49,999 showing the highest churn rate at approximately 35%, compared with approximately 14% among zero-balance customers. Churned customers also held a higher average balance than retained customers, suggesting that customer attrition may have financial significance beyond the number of customers lost.



---

## 10. Recommendations


| Priority | Recommendation | Based On | Suggested Owner |
|----------|---------------|----------|-----------------|
| High | Launch targeted re-engagement campaign for inactive customers, prioritising single product, inactive customers | Insight 2 & 4 - Inactive customers had 27% churn vs 14% for active customers, while deeper segmentation identified single product + inactive customers as a key high-risk.  | Customer Retention team |
| High | Target customers aged 40-69 with a pilot retention campaign, preferably using personalised offers and proactive account reviews. Then track campaign response and subsequent churn to determine which interventions are most effective.| Insight 1 - Customers aged 50-59 recorded the highest age group churn rate at 56% compared with the 20.37% overall churn rate. | Customer retention or Marketing Team |
| High | Introduce proactive retention monitoring  for higher balance customers showing signs of disengagement.| Insight 6 - churn varies by balance group and churned customers held a higher average balance than retained customers.| Relationship Management|
| Medium | Investigate the customer experience in Germany to identify potential service, product differences or pricing  before implementing country-specific retention initiatives.| Insight 3 - Germany recorded approximately 32% churn compared with around 16-17% in France and Spain. | Regional Management or Customer Experience Team |
| Medium | Investigate the unusually high churn amongst customers holding 3+ products before taking action. | Insight 4 - some four-product segments recorded churn rates of 100%; however, customer counts were small and therefore require cautious interpretation.| Customer Insights or Product Team|
| Low | Continue to monitor churn by tenure alongside other strong behavioural indicators. | Insight 5 - Tenure hypothesis was only partially supported, with no consistent decline in churn as tenure increased. | Customer insights or analytical team |

---

## 11. Assumptions & Limitations

### Assumptions
- `Exited` was treated as the definition of Customer Churn. A value of `1` was assumed to represent a customer who had left the bank, while `0` represented a retained  customer.
  
- Customer attributes were assumed to be accurate at the point of observation (e.g., balance, estimated salary, tenure and membership status) and were analysed as provided in the source dataset.
  
- Customer records were treated as independent observations; each row represents one unique customer.
  
- `Balance` was treated as the customer's recorded account balance. `Balance` was analysed to assess the potential financial significance of churn, but does not assume the entire balance was lost by the bank when the customer exited.

### Limitations
- No date or historical information was available. The dataset provides a snapshot of customers rather than observations over time; therefore, the analysis cannot determine when customers churned, churn over time or whether events preceded churn.
- No transaction-level data available; information such as transaction frequency, spending behaviour, deposits, or changes in account usage was unavailable. These factors would give insight into customer disengagement before churn.
  
- The analysis identifies associations rather than causal relationships. For example, customers aged 50-59 recorded the highest churn rate; however, the dataset does not explain why these customers are leaving.
  
- Some high-risk segments contain relatively few customers. For example, some three- and four-product customer groups showed extremely high churn rates, but their small customer counts mean these percentages should be interpreted cautiously.

- No predictive or statistical significance modelling was performed. The project uses exploratory and descriptive analysis, so further analysis would be required to determine the independent contribution of each factor to churn or predict individual customer churn risk.

---

## 12. Future Enhancements

- [ ] Incorporate historical and time-based data - Add customer churn dates and historical account activity to analyse how churn changes over time and identify behaviours that occur before customers leave.
 
- [ ] Integrate transaction and engagement data - Include transaction frequency, deposits, withdrawals, product usage and digital banking activity to better understand declining customer engagement and the potential drivers of churn.
- [ ]  Include customer experience data - Incorporate complaints, satisfaction scores, service interactions, fees and customer feedback to investigate why high-churn segments, such as customers in Germany, are leaving.
- [ ]  Develop and validate a predictive churn model - Use richer historical data to build a model that estimates individual customer churn risk, allowing the bank to identify at-risk customers before they exit and prioritise retention interventions.
      

---
## 13. Deliverables
| Deliverable | Description | Location |
|---|---|---|
| Power BI Dashboard | Two-page dashboard presenting churn analysis and high-risk segments. | [View Dashboard Screenshots](visuals/) |
| SQL Analysis | SQL queries used for analysis, transformation and dashboard outputs. | [View SQL Queries](queries/) |
| Customer Analysis View | SQL view containing transformed analytical fields. | [View Transformation](queries/transformations/) |
| Raw Dataset | Original customer churn dataset. | [View Raw Data](data/raw/) |
| Project Documentation | Full project methodology, findings and recommendations. | [README](README.md) |

---

## 14. Author

**Mishaella Osei**
Aspiring Data Analyst

- 🔗 www.linkedin.com/in/mishaella-osei-1510mo
- 💼 oseimishaella385-cell
- 📧 Email - Oseimishaella385@gmail.com

---

*Last updated: August 2026*

