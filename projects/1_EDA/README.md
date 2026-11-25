# Exploratory Data Analysis w/ SQL: job market analysis  

![Project 1 Overview](../..\images\1_1_Project1_EDA.png)  

An SQL project analysing the data engineering job market using real-world job listing data. It demonstrates my ability to **write efficient, production quality SQL queries and turn business questions into data-driven insights.**  

## Executive Summary
- **Project Scope**: Built 3 queries which: 
    1. Find the top demanded 
    2. Highest paying skills 
    3. Summarize the optimal value of skills as a function of demand and pay  

    for remote data engineering jobs in the UK & Ireland.
- **Data Modelling**: Used multi-table joins across fact and dimension tables to extract insights.
- **Analytics**: Applied aggregations, filters and sorts to find the top 10/25 skills.
- **Outcomes**: Recorded insights on SQL/Python dominance in demand, experience cloud platforms demanding a higher salary and the prevelance of Azure as the most optimal skill.

The 3 SQL queries, results & insights:  
[Top Demanded Skills Query](01_top_demanded_skills.sql)  
[Top Paying Skills Query](02_top_paying_skills.sql)  
[Optimal Skills](03_optimal_skills.sql)


## Problem & Context
Job market analysts need to answer questions like:
- **Most in-demand**: *Which skills are most in demand for data engineers?*
- **Highest paid**: *Which skills command the highest salaries for data engineers?*
- **Best trade-off**: *What is the optimal skill-set for data engineers?*  

This project analyses a **data warehouse** built using a **star schema** of this design:  
![Data Warehouse Schema](../../images\1_2_Data_Warehouse.png)

**Fact Table**: `job_postings_fact` Central table containing job posting details (job titles, location, remote yes/no, salaries etc.)  
**Dimensional tables**: 
- `company_dim` Company information linked to job postings
- `skills_dim` Skills catalog with skill names and classifcation  

**Bridging table**: `skills_job_dim` Solves the many-many relationship between job postings and skills



## Tech Stack

- **Query engine**: DuckDB in the terminal connected to cloud-stored database `data_jobs`.
- **Language**: SQL (using ANSI-standardised language so compatible across all languages).
- **Data model**: Star schema with fact + dimensional + bridging tables.
- **Development**: VS Code for SQL editing and Terminal for DuckDB CLI.
- **Version Control**: Git/GitHub for versioned SQL scripts.

## Analysis Overview

### Query Structure
1. **[Top Demanded Skills Query](01_top_demanded_skills.sql)** Identifies the top 10 most in-demand skills.
2. **[Top Paying Skills Query](02_top_paying_skills.sql)** Identifies the top 25 highest paid skills showing their demand and no. times salaries were listed.
3. **[Optimal Skills](03_optimal_skills.sql)** Combines salaries and no. times demanded to identify most valuable skills to learn.

### Key Insights
- SQL & Python appear the most making them the most in-demand skills.
- Knowledge of cloud systems like 3<sup>rd</sup> & 4<sup>th</sup> placed AWS & Azure is highly sought after.
- DEs are not expected to know Power BI as this ranks 10<sup>th</sup> with around 1/5 the demand as Python & SQL. 
- Very few postings have a salary listed making outliers likely
    - Feature of UK & Ireland postings versus US
    - Included the number of times the salary was listed for reference
- SQL and Python appear relatively low down showing they are almost expected
- Bigquery, go, sql server and terraform are the highest paid skills followed closely by snowflake
- Rarer programming languages (go, scala, java) offer higher salaries than SQL and Python
- Azure now ranks highest for optimal score, surpassing SQL which remains high
- Terraform, scala, java and gcp perform well despite lower demand count
- Databricks low despite high number of listings referencing this skill

## SQL Skills Demonstrated
### Query Design & Optimization
- **Complex Joins**: Multi-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`
- **Aggregations**: `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- **Filtering**: Boolean logic with `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`)
- **Sorting & Limiting**: `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

### Data Analysis Techniques 

- **Grouping**: `GROUP BY` for categorical analysis by skill
- **Mathematical Functions**: `LN()` for natural logarithm transformation to normalize demand metrics
- **Calculated Metrics**: Derived optimal score combining log-transformed demand with median salary
- **HAVING Clause**: Filtering aggregated results (skills with >= 100 postings)
