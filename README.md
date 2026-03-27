# world-health-spending-analysis
 Analytical dashboard exploring the relationship between health spending and sanitary outcomes across 200+ countries (1999–2019) — Python · SQL · Power BI


# 🌍 World Health Spending & Sanitary Performance Analysis

> Does investing more in health guarantee better outcomes?
> This project explores the relationship between health expenditure and key
> sanitary indicators across 200+ countries over 20 years (1999–2019),
> using a full analytical pipeline from raw data to decision dashboard.

---

## 1. Project Overview

Health systems worldwide face growing pressure to justify public resource
allocation. While increasing health spending is often presented as a
universal solution, the reality reveals deep disparities: some countries
achieve excellent health outcomes with modest budgets, while others, despite
high investment, display alarming indicators.

This project measures and visualizes the relationship between health spending
levels and sanitary performance — across avoidable mortality, life
expectancy, and infectious disease control — to identify the most efficient
countries, the most vulnerable, and those with the most critical gaps between
investment and results.

**Decisional purpose :** Provide public health decision-makers, international
organizations, and fund allocators with a clear prioritization tool to direct
health investments where they will produce the greatest human impact.

---

## 2. Dataset

| Attribute       | Detail                                          |
|-----------------|-------------------------------------------------|
| Source          | World Health Organization — Global Health Observatory |
| Rows            | 6,650 observations                              |
| Columns         | 12 raw → 11 final (after engineering)           |
| Period          | 1999 – 2019 (21 years)                          |
| Granularity     | Country × Year                                  |

Variable categories :

| Category         | Variables                                                  |
|------------------|------------------------------------------------------------|
| Identification   | `country`, `country_code`                                  |
| Time             | `year`                                                     |
| Investment       | `health_spending_pct_gdp`, `health_spending_category`      |
| Health outcomes  | `life_expectancy_years`, `life_expectancy_category`        |
| Synthetic indices| `avoidable_mortality_index`, `infectious_disease_index`, `health_roi_score` |
| Segmentation     | `performance_gap_flag`                                     |

---

## 3. Tools & Technologies

| Tool              | Role in pipeline                                           |
|-------------------|------------------------------------------------------------|
| Python        | Data loading, quality audit, cleaning, feature engineering, CSV export |
| pandas        | Data manipulation, imputation, transformation              |
| scikit-learn  | MinMaxScaler normalization for synthetic indices           |
| MySQL Workbench| Data storage, analytical SQL queries, structured reporting |
| SQLAlchemy    | Python → MySQL connection and DataFrame import via `to_sql()` |
| Power BI      | Interactive decision dashboard, DAX measures, KPI cards    |
| Gamma         | Executive presentation of insights and recommendations     |

---

## 4. Project Steps

1. Data loading & exploration (Python)
Loaded the WHO dataset (6,650 rows × 12 columns), inspected variable types,
identified missing values across 9 numeric columns and detected statistical
outliers using the IQR method — chosen for its robustness on asymmetric
health indicator distributions.

2. Data cleaning & feature engineering (Python)
Applied median-per-country imputation for missing values with global median
fallback. Capped outliers at IQR bounds without removal to preserve extreme
real-world health realities. Built 6 business variables: spending category,
avoidable mortality index, infectious disease index, health ROI score, life
expectancy category and performance gap flag. Dropped 7 redundant columns
absorbed into synthetic indices. Exported final clean dataset to CSV.

3. SQL Analysis (MySQL Workbench)
Imported clean dataset into MySQL via SQLAlchemy. Ran 10 structured analytical
queries covering: spending distribution, life expectancy rankings, ROI
efficiency, double-burden countries, temporal evolution, critical gap
detection, and global country positioning.

4. Decision Dashboard (Power BI)
Built a 3-page interactive dashboard with 9 complementary visuals, 20+ DAX
measures and 5 cross-filtering slicers. Pages cover: Global Investment &
Performance overview, Avoidable Mortality & Infectious Diseases, and Health
ROI & Temporal Evolution.

5. Report & Presentation (Gamma)
Produced a professional analytical report structured for non-technical
decision-makers, and an executive presentation summarizing key insights and
business recommendations — both portfolio-ready.

---

## 5. Dashboard Preview

The dashboard is structured across 3 decision pages :

- Page 1 — Global Overview : KPI cards (total countries, average spending,
average life expectancy, critical gap countries), donut chart of spending
distribution, top 15 ROI countries bar chart, world choropleth map of life
expectancy.

- Page 2 — Mortality & Infectious Diseases : Synthetic index KPI cards,
top 20 avoidable mortality bar chart, double-burden scatter plot
(mortality vs infectious pressure), conditional priority table.

- Page 3 — Health ROI & Time Evolution : Life expectancy gain KPI cards,
line chart of life expectancy evolution by spending category, global
spending vs life expectancy scatter plot, ROI comparison bar chart by
spending tier.

---

## 6. Key Results & Insights

💡 1 — Under-investment is the primary driver of poor health outcomes
71 countries spend less than 5% of GDP on health — the WHO minimum threshold.
All 10 countries with the lowest life expectancy fall into this category,
located exclusively in sub-Saharan Africa.

💡 2 — High spending does not guarantee high performance
Countries like Lesotho (11.2% GDP) and Botswana (10.3% GDP) invest
significantly above average yet display life expectancy below 65 years —
signaling structural inefficiencies, likely driven by uncontrolled HIV
prevalence and inequitable access to care.

💡 3 — Efficiency models exist at low cost
Bangladesh, Vietnam, and Sri Lanka achieve life expectancy above 71 years
with spending below 6% of GDP — demonstrating that well-targeted prevention
and primary care spending can generate outsized health returns.

💡 4 — Double-burden countries require coordinated multi-axis intervention
Central African Republic, Chad, Nigeria, Sierra Leone and South Sudan exceed
0.6 on both the avoidable mortality index and infectious disease index
simultaneously — with critically low health budgets. These are the highest
priority targets for international health investment.

💡 5 — Higher spending reliably controls infectious diseases
High-spending countries average an infectious disease index of 0.18 vs 0.67
for low-spending countries — a 4x difference confirming that investment
level is a direct lever on infectious disease burden.

---

## 7. How to Run

Prerequisites
```
Python       3.9+
pandas       2.0+
scikit-learn 1.3+
sqlalchemy   2.0+
pymysql      1.1+
MySQL        8.0+
Power BI     Desktop (free)
```

Steps
```bash
# 1. Clone the repository
git clone https://github.com/your-username/world-health-spending-analysis.git
cd world-health-spending-analysis

# 2. Install Python dependencies
pip install pandas scikit-learn sqlalchemy pymysql

# 3. Run the Python pipeline in Jupyter Notebook
#    Open and execute sequentially :
#    - 01_quality_audit.ipynb
#    - 02_type_conversion.ipynb
#    - 03_renaming.ipynb
#    - 04_feature_engineering.ipynb
#    - 05_variable_selection.ipynb

# 4. Import clean CSV into MySQL
#    Execute the SQLAlchemy import block in 05_variable_selection.ipynb
#    Then run SQL queries in MySQL Workbench from :
#    - queries/analytical_queries.sql

# 5. Open Power BI dashboard
#    Connect Power BI Desktop to your MySQL health_db database
#    Open : dashboard/world_health_dashboard.pbix
```

Dataset
```
Public dataset available at :
https://www.kaggle.com/datasets/world-health-organization-global-health
```

---

Made with Python · SQL · Power BI · by ESMEL
Portfolio project — Data Analyst · 
