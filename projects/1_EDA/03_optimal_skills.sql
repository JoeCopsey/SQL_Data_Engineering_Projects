-- Create a ranking column that combines the demand_count and median_salary for the most optimal skills 
-- Focussing on the remote jobs advertised in the UK & Ireland

SELECT 
    sd.skills,
    sd.type,
    format('{:,}', cast(median(jpf.salary_year_avg) as int)) as median_salary,
    round(ln(count(jpf.*)),1) as ln_demand_count,
    round(median(jpf.salary_year_avg) * ln(count(jpf.*))/1000000,2) as optimal_score,
    count(jpf.salary_year_avg) as num_listed_salaries
from job_postings_fact jpf
inner join skills_job_dim sjd
    on jpf.job_id = sjd.job_id 
inner join skills_dim sd 
    on sjd.skill_id = sd.skill_id
where 
    jpf.job_title_short = 'Data Engineer'
    and jpf.job_work_from_home = True 
    and jpf.job_country in ['United Kingdom','Ireland']
group by sd.skills, sd.type
having count(jpf.*) >100 and count(jpf.salary_year_avg) >0
order by optimal_score desc
limit 25
;

/*
Key insights:
- Same caveat as previous w.r.t. low number of salaries actually listed
    - Natural log of demand_count taken to reduce the weight of #listings 
- Azure now ranks highest for optimal score, surpassing SQL which remains high
- Terraform, scala, java and gcp perform well despite lower demand count
- Databricks low despite high number of listings referencing this skill

┌────────────┬───────────────┬───────────────┬─────────────────┬───────────────┬─────────────────────┐
│   skills   │     type      │ median_salary │ ln_demand_count │ optimal_score │ num_listed_salaries │
│  varchar   │    varchar    │    varchar    │     double      │    double     │        int64        │
├────────────┼───────────────┼───────────────┼─────────────────┼───────────────┼─────────────────────┤
│ azure      │ cloud         │ 131,575       │             7.0 │          0.92 │                   6 │
│ sql        │ programming   │ 113,286       │             7.4 │          0.84 │                  11 │
│ snowflake  │ cloud         │ 134,825       │             6.0 │           0.8 │                   2 │
│ gcp        │ cloud         │ 131,575       │             5.8 │          0.77 │                   4 │
│ aws        │ cloud         │ 110,000       │             6.9 │          0.75 │                   7 │
│ scala      │ programming   │ 131,575       │             5.5 │          0.73 │                   6 │
│ java       │ programming   │ 128,150       │             5.7 │          0.73 │                   5 │
│ python     │ programming   │ 100,000       │             7.3 │          0.73 │                  11 │
│ sql server │ databases     │ 135,000       │             5.4 │          0.73 │                   1 │
│ redshift   │ cloud         │ 128,150       │             5.7 │          0.73 │                   1 │
│ terraform  │ other         │ 135,000       │             5.4 │          0.72 │                   1 │
│ spark      │ libraries     │ 113,286       │             6.2 │          0.71 │                   7 │
│ airflow    │ libraries     │ 120,718       │             5.8 │          0.71 │                   6 │
│ bigquery   │ cloud         │ 135,000       │             5.2 │           0.7 │                   3 │
│ kubernetes │ other         │ 131,575       │             5.3 │          0.69 │                   4 │
│ go         │ programming   │ 135,000       │             5.1 │          0.69 │                   1 │
│ docker     │ other         │ 128,150       │             5.2 │          0.67 │                   3 │
│ hadoop     │ libraries     │ 120,718       │             5.5 │          0.66 │                   4 │
│ databricks │ cloud         │ 106,270       │             6.0 │          0.64 │                   2 │
│ kafka      │ libraries     │ 113,286       │             5.6 │          0.63 │                   5 │
│ nosql      │ programming   │ 101,250       │             5.3 │          0.54 │                   2 │
│ flow       │ other         │ 67,500        │             5.1 │          0.35 │                   1 │
│ pyspark    │ libraries     │ 60,000        │             5.3 │          0.32 │                   1 │
│ power bi   │ analyst_tools │ 50,000        │             5.8 │          0.29 │                   1 │
└────────────┴───────────────┴───────────────┴─────────────────┴───────────────┴─────────────────────┘
*/

