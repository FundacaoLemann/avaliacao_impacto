SELECT
  public.collects.id as collect_id,
  MAX(public.administrations.name) as administration_name,
  MAX(public.administrations.contact_name) as administration_contact_name,
  COUNT (DISTINCT public.collect_entries.id) as sample_count,
  COUNT (DISTINCT public.submissions.school_inep) FILTER (WHERE public.submissions.status = 3) as quitters_count,
  COUNT (*) FILTER (WHERE public.collect_entries.substitute = TRUE) as substitutes_count,
  COUNT (DISTINCT public.submissions.school_inep) FILTER (WHERE public.submissions.status = 0) as redirected_count,
  COUNT (DISTINCT public.submissions.school_inep) FILTER (WHERE public.submissions.status = 1) as in_progress_count,
  COUNT (DISTINCT public.submissions.school_inep) FILTER (WHERE public.submissions.status = 2) as submitted_count
FROM public.collect_entries
LEFT JOIN public.administrations ON public.administrations.cod = public.collect_entries.adm_cod
LEFT JOIN public.submissions ON public.administrations.cod = public.submissions.adm_cod
LEFT JOIN public.collects ON public.collect_entries.collect_id = public.collects.id
WHERE public.collect_entries.group = 1
GROUP BY public.administrations.id, public.collects.id
