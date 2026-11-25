SELECT  
    jpf.job_id,
    jpf.job_title_short,
    cd.name as company_name,
    jpf.job_location
    
from job_postings_fact as jpf
left join company_dim as cd
    on jpf.company_id = cd.company_id

limit 10;

select * from job_posting_fact limit 10;

SELECT  
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id ,
    sd.skills
from job_postings_fact as jpf
left join skills_job_dim as sjd
    on jpf.job_id = sjd.job_id
left join skills_dim as sd 
    on sd.skill_id = sjd.skill_id
order by jpf.job_id
--where sjd.skill_id is null
--limit 20
;

select * from job_posting_fact limit 10;

SELECT  
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id ,
    sd.skills
from job_postings_fact as jpf
inner join skills_job_dim as sjd
    on jpf.job_id = sjd.job_id
inner join skills_dim as sd 
    on sd.skill_id = sjd.skill_id
order by jpf.job_id
--where sjd.skill_id is null
--limit 20
;