explain analyze
SELECT  cd.name as company_name,
    jpf.job_title_short,
    count(jpf.*) as posting_count
from job_postings_fact as jpf 
left join company_dim as cd 
    on jpf.company_id = cd.company_id 
where jpf.job_country = 'United States'
group by cd.name, jpf.job_title_short
having count(jpf.*) >300
order by   company_name, posting_count desc
limit 10
;