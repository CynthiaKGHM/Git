SELECT sys_id, active, business_unit, business_unit_link, category, department, department_link, description, "name", portfolio_manager, portfolio_manager_link, portfolio_planning, state, sys_class_name, sys_created_by, sys_created_on, sys_domain, sys_mod_count, sys_tags, sys_updated_by, sys_updated_on
FROM public.cdata_pm_portfolio;

select * from cdata_planned_task cpt 
select * from cdata_pm_program cpp 
select * from cdata_core_company ccc 
where sys_id ='2d68476edb9e6700632d63835b9619e5'



select end_date from cdata_pm_project cpp 

   cdata_system_user_group.name as assignment_group,
   LEFT JOIN cdata_system_user_group ON cdata_system_user_group.sys_id = cdata_task.assignment_group

select
	cdata_task.sys_id,
    cdata_task.short_description,
    cdata_task.user_input,
    CASE
        WHEN cdata_task.state = 2 THEN 'Work in progress'
        WHEN cdata_task.state = 1 THEN 'Planning'
        WHEN cdata_task.state = 4 THEN 'Cancelled'
        WHEN cdata_task.state = 5 THEN 'Reviewed and reverted'
        WHEN cdata_task.state = 6 THEN 'Resolved'
        WHEN cdata_task.state = 7 THEN 'Closed skipped'
        WHEN cdata_task.state = 8 THEN 'Testing / QA'
        WHEN cdata_task.state = 9 THEN 'Already exist'
        WHEN cdata_task.state = 10 THEN 'On hold'
        WHEN cdata_task.state = 11 THEN 'On hold'
        WHEN cdata_task.state = -5 THEN 'Pending'
        WHEN cdata_task.state = 3 THEN 'Closed complete'
        ELSE NULL 
    END AS state_name,
     CASE 
        WHEN cdata_task.priority = 1 THEN '1 - critical'
        WHEN cdata_task.priority = 2 THEN '2 - high'
        WHEN cdata_task.priority = 3 THEN '3 - moderate'
        WHEN cdata_task.priority = 4 THEN '4 - low'
        WHEN cdata_task.priority = 5 THEN '5 - planning'
    END AS priority,
    cdata_task.state,
    cdata_task.sys_updated_on,
    cdata_pm_project.phase,
    cdata_pm_project.priority,
    cdata_pm_project.short_description,
    cdata_pm_project.u_it_service,
    cdata_pm_project.u_business_partner,
    cdata_pm_portfolio.name AS primary_portfolio,
    cdata_system_user.name as project_manager,
    cdata_system_user.company as company,
    cdata_planned_task.status as latest_status,
    cdata_system_user_group.name as assignment_group,
    cdata_planned_task.percent_complete,
    cdata_pm_project.end_date,
    cdata_planned_task.end_date AS planned_end_date,
    cdata_task.work_end AS work_end2,
    COALESCE(cdata_task.work_end, NOW()) AS work_end,
    cdata_pm_project.sys_created_by,
    cdata_pm_project.sys_created_on,
    cdata_pm_project.sys_updated_by,
    cdata_pm_project.sys_updated_on,
    cdata_pm_project.schedule_start_date AS planned_start_date,
    cdata_pm_project.schedule_end_date AS planned_end_date,
    cdata_pm_project.start_date,
    CASE
        WHEN cdata_task.work_end BETWEEN NOW() - INTERVAL '90 days' AND NOW() THEN 'Last 90 days'
        WHEN cdata_task.work_end IS NULL THEN 'Active'
        ELSE 'Out Scope'
    END AS Filter,
    cdata_task.number AS number
FROM
    cdata_planned_task 
INNER JOIN cdata_pm_project ON cdata_planned_task.sys_id = cdata_pm_project.sys_id
INNER JOIN cdata_task ON cdata_task.sys_id = cdata_pm_project.sys_id
LEFT JOIN cdata_system_user ON cdata_system_user.sys_id = cdata_pm_project.project_manager 
LEFT JOIN cdata_pm_program ON cdata_pm_program.sys_id = cdata_pm_project.primary_program
LEFT JOIN cdata_pm_portfolio ON cdata_pm_portfolio.sys_id = cdata_pm_project.primary_portfolio
LEFT JOIN cdata_system_user_group ON cdata_system_user_group.sys_id = cdata_task.assignment_group