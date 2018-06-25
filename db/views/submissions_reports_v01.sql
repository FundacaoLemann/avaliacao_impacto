select
t1.adm_cod,
t1.group as collect_entries_group,
MAX (t1.collect_id) as collect_id,
MAX (administration_name) as administration_name,
MAX (administration_contact_name) as administration_contact_name,
COUNT (*) as sample_count,
SUM (CASE WHEN max_status = 3 THEN 1 ELSE 0 END) as quitters_count,
SUM (CASE WHEN max_status = 0 THEN 1 ELSE 0 END) as redirected_count,
SUM (CASE WHEN max_status = 1 THEN 1 ELSE 0 END) as in_progress_count,
SUM (CASE WHEN max_status = 2 THEN 1 ELSE 0 END) as submitted_count
from (
    select
      collect_entries.collect_id,
      collect_entries.school_inep as school_inep,
      MAX (submissions.status) as max_status,
      MAX (administrations.name) as administration_name,
      MAX (administrations.contact_name) as administration_contact_name,
      MAX (collect_entries.adm_cod) as adm_cod,
      collect_entries.group
    from collect_entries
    left join submissions on collect_entries.school_inep = submissions.school_inep
    left join administrations on collect_entries.adm_cod = administrations.cod
    group by collect_entries.collect_id, collect_entries.school_inep, collect_entries.group
) as t1
group by t1.adm_cod, t1.group
order by t1.adm_cod
