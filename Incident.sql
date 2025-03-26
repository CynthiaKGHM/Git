
SELECT cdata_system_user.name AS caller, a.*, sys_created_on
FROM (
    SELECT cdata_incident.caller_id,  cdata_incident."number" ,
    CASE 
        WHEN cdata_incident.priority = 1 THEN '1 - critical'
        when cdata_incident.priority = 2 THEN '2 - high'
        WHEN cdata_incident.priority = 3 THEN '3- moderate'
        WHEN cdata_incident.priority = 4 THEN '4 - low'
        WHEN cdata_incident.priority = 5 THEN '5 - planning'
    END AS priority, 
    cdata_incident.category, 
    cdata_incident.subcategory, 
    cdata_incident.u_subsubcategory,
    cdata_incident.opened_at, 
    cdata_incident.u_estimated_effort, 
    cdata_system_user_group."name" as "Assignment Group", 
    CASE
        WHEN cdata_incident.state = 2 THEN 'Active'
        WHEN cdata_incident.state = 1 THEN 'New'
        WHEN cdata_incident.state = 10 THEN 'On Hold'
        WHEN cdata_incident.state = 4 THEN 'Awaiting User Info'
        WHEN cdata_incident.state = 5 THEN 'Reviewed and reverted'
        WHEN cdata_incident.state = 6 THEN 'Resolved'
        WHEN cdata_incident.state = 9 THEN 'Awaiting approval'
        WHEN cdata_incident.state = 8 THEN 'Move to Change'
        WHEN cdata_incident.state = 7 THEN 'Closed' end as state, 
    cdata_incident.state as state_id,
    cdata_system_user_group.name, 
    cdata_incident.short_description, 
    cdata_incident.time_worked,
    -- SPLIT_PART(cdata_incident.time_worked, ' ', 2) as "Time Worked",
     CASE
        WHEN cdata_incident.time_worked IS NOT NULL AND cdata_incident.time_worked <> '' 
        THEN
            FLOOR(EXTRACT(EPOCH FROM (cdata_incident.time_worked::timestamp - '1970-01-01 00:00:00'::timestamp)) / 3600) || ' hours ' ||
            FLOOR((EXTRACT(EPOCH FROM (cdata_incident.time_worked::timestamp - '1970-01-01 00:00:00'::timestamp))::integer) % 3600 / 60) || ' minutes'
        ELSE '0 hours 0 minutes' -- or 'NULL' if you prefer
    END AS "Time Worked",
    cdata_system_user.name AS assigned_to,
    cdata_incident.resolved_at, 
    cdata_incident.u_incident_class, 
    cdata_incident.sys_updated_on, 
    cdata_core_company."name" AS company 
    FROM cdata_incident  
    INNER JOIN cdata_system_user_group ON cdata_system_user_group.sys_id = cdata_incident.assignment_group
    LEFT JOIN cdata_system_user ON cdata_system_user.sys_id = cdata_incident.assigned_to 
    LEFT JOIN cdata_core_company ON cdata_core_company.sys_id = cdata_system_user.company
) AS a
LEFT JOIN cdata_system_user ON cdata_system_user.sys_id = a.caller_id 


