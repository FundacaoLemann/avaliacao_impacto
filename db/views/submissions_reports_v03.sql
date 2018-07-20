select

adm_cod,
max(collect_id) as collect_id,
max(administration_name) as adm_name,
max(administration_contact_name) as adm_contact,
sum(sample_count::integer) as total_schools_count,
sum((case when collect_entries_group = 1 then sample_count else 0 end)::integer) as sample_count,
sum(quitter_count::integer) as quitters_count,
sum((case when collect_entries_group = 1 then quitter_count else 0 end)::integer) as quitters_in_sample_count,
sum(substitute_count::integer) as substitutes_count,
sum(redirected_count::integer) as redirected_count,
sum((case when collect_entries_group = 1 then redirected_count else 0 end)::integer) as redirected_in_sample_count,
sum(in_progress_count::integer) as in_progress_count,
sum((case when collect_entries_group = 1 then in_progress_count else 0 end)::integer) as in_progress_in_sample_count,
sum(submitted_count::integer) as submitted_count,
sum((case when collect_entries_group = 1 then submitted_count else 0 end)::integer) as submitted_in_sample_count,
sum(answered_count::integer) as answered_count,
round(sum(answered_count) * 100.0 / sum(case when collect_entries_group = 1 then sample_count else 0 end), 2) as sample_percent,
round(sum(submitted_count) * 100.0 / sum(sample_count), 2) as total_percent
from ( select
t1.adm_cod,
t1.group as collect_entries_group,
MAX (t1.collect_id) as collect_id,
MAX (administration_name) as administration_name,
MAX (administration_contact_name) as administration_contact_name,
COUNT (*) as sample_count,
sum (quitters) as quitter_count,
SUM (CASE WHEN max_status = 0 AND quitters = 0 THEN 1 ELSE 0 END) as redirected_count,
SUM (CASE WHEN max_status = 1 AND quitters = 0 THEN 1 ELSE 0 END) as in_progress_count,
SUM (CASE WHEN max_status = 2 AND quitters = 0 THEN 1 ELSE 0 END) as submitted_count,
sum (substitutes) as substitute_count,
sum (answered) as answered_count
from (
    select
      collect_entries.collect_id,
      collect_entries.school_inep as school_inep,
      MAX (submissions.status) as max_status,
      MAX (administrations.name) as administration_name,
      MAX (administrations.contact_name) as administration_contact_name,
      MAX (collect_entries.adm_cod) as adm_cod,
	  MAX (case when collect_entries.substitute then 1 else 0 end) as substitutes,
	  MAX (case when submissions.status = 2 and not collect_entries.quitter and (collect_entries.group = 1 or (collect_entries.group = 0 and collect_entries.substitute)) then 1 else 0 end) as answered,
	  MAX (case when collect_entries.quitter then 1 else 0 end) as quitters,
      collect_entries.group
    from collect_entries
    left join submissions on collect_entries.school_inep = submissions.school_inep
    left join administrations on collect_entries.adm_cod = administrations.cod
    group by collect_entries.collect_id, collect_entries.school_inep, collect_entries.group
) as t1
group by t1.adm_cod, t1.group
order by t1.adm_cod

) as matview
group by adm_cod
