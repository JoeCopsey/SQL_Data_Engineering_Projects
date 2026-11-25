-- Find the top 10 most in demand job skills for data engineering posts
-- Focusing on remote job postings in the UK & Ireland

SELECT 
    sd.skills,
    sd.type,
    count(jpf.*) as demand_count
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
order by demand_count desc
limit 10;

/*
I have included the type of skill for each as reference.
Key takeaways:
- Python and SQL as programming languages are the most sought after skill for DEs.
- Cloud providers Azure and AWS are also sought after, though GCP is less common.
- Knowledge of the Spark library is important but only appears around a third of SQL and Python.
- Pipeline tools like Databricks, Snowflake and Airflow requested but at lower rates.
- Power BI is the final skill, showing DEs also need analytical skills.
┌────────────┬───────────────┬──────────────┐
│   skills   │     type      │ demand_count │
│  varchar   │    varchar    │    int64     │
├────────────┼───────────────┼──────────────┤
│ sql        │ programming   │         1606 │
│ python     │ programming   │         1491 │
│ azure      │ cloud         │         1053 │
│ aws        │ cloud         │          956 │
│ spark      │ libraries     │          505 │
│ databricks │ cloud         │          419 │
│ snowflake  │ cloud         │          389 │
│ airflow    │ libraries     │          347 │
│ gcp        │ cloud         │          346 │
│ power bi   │ analyst_tools │          325 │
└────────────┴───────────────┴──────────────┘
*/
