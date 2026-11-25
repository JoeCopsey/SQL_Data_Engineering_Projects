-- Calculate the median salary for each skill required in DE positions
-- Focus on remote jobs posted in the UK & Ireland
-- Include skill frequency to identify salary and demand

SELECT 
    sd.skills,
    sd.type,
    format('{:,}', cast(median(jpf.salary_year_avg) as int)) as median_salary,
    count(jpf.*) as demand_count,
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
order by median(jpf.salary_year_avg) desc
limit 25
;


/*
Key insights:
- Very few postings have a salary listed making outliers likely
    - Feature of UK & Ireland postings versus US
    - Included the number of times the salary was listed for reference
- SQL and Python appear relatively low down showing they are almost expected
- Bigquery, go, sql server and terraform are the highest paid skills followed closely by snowflake
- Rarer programming languages (go, scala, java) offer higher salaries than SQL and Python
- Several 'other' types were found showing nicher skills are sometimes specified in postings listing salaries
- Perhaps go, SQL server, Terraform all mentioned in the same high paying job advert
┌────────────┬───────────────┬───────────────┬──────────────┬─────────────────────┐
│   skills   │     type      │ median_salary │ demand_count │ num_listed_salaries │
│  varchar   │    varchar    │    varchar    │    int64     │        int64        │
├────────────┼───────────────┼───────────────┼──────────────┼─────────────────────┤
│ bigquery   │ cloud         │ 135,000       │          174 │                   3 │
│ go         │ programming   │ 135,000       │          160 │                   1 │
│ sql server │ databases     │ 135,000       │          226 │                   1 │
│ terraform  │ other         │ 135,000       │          213 │                   1 │
│ snowflake  │ cloud         │ 134,825       │          389 │                   2 │
│ scala      │ programming   │ 131,575       │          251 │                   6 │
│ azure      │ cloud         │ 131,575       │         1053 │                   6 │
│ gcp        │ cloud         │ 131,575       │          346 │                   4 │
│ kubernetes │ other         │ 131,575       │          192 │                   4 │
│ java       │ programming   │ 128,150       │          308 │                   5 │
│ redshift   │ cloud         │ 128,150       │          302 │                   1 │
│ docker     │ other         │ 128,150       │          182 │                   3 │
│ hadoop     │ libraries     │ 120,718       │          234 │                   4 │
│ airflow    │ libraries     │ 120,718       │          347 │                   6 │
│ kafka      │ libraries     │ 113,286       │          270 │                   5 │
│ sql        │ programming   │ 113,286       │         1606 │                  11 │
│ spark      │ libraries     │ 113,286       │          505 │                   7 │
│ aws        │ cloud         │ 110,000       │          956 │                   7 │
│ databricks │ cloud         │ 106,270       │          419 │                   2 │
│ nosql      │ programming   │ 101,250       │          208 │                   2 │
│ python     │ programming   │ 100,000       │         1491 │                  11 │
│ flow       │ other         │ 67,500        │          167 │                   1 │
│ pyspark    │ libraries     │ 60,000        │          202 │                   1 │
│ power bi   │ analyst_tools │ 50,000        │          325 │                   1 │
└────────────┴───────────────┴───────────────┴──────────────┴─────────────────────┘
*/

