SELECT "Number", "Configuration Item", "Type", "Begin", "End", "Duration", "Updated", "Updated by"
FROM public.cmdb_ci_outage;


SELECT
    mtom."Begin",
    b."Name",
    mtom."Type",
    COUNT(mtom."Number") AS qty
FROM
    cmdb_ci_outage AS mtom
INNER JOIN
    service_offering AS b ON mtom."Number" = b."Number"
WHERE
    mtom."Type" = 'outage'
GROUP BY
   mtom."Begin",
    b."Name",
    mtom."Type";







SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '1.Required Hours' AS kpi, 
    ui.u_required_hours AS value, 
    ui.u_outages, 
    ui.Month_int, 
    ui.Date
FROM 
    u_it_availability AS ui

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '2.Planned Outage Hours' AS kpi, 
    ui.u_planned_outage_hours AS value, 
    ui.u_outages, 
    ui.Month_int, 
    ui.Date
FROM 
    u_it_availability AS ui

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '3.Unplanned Outage Hours' AS kpi, 
    ui.u_unplanned_outage_hours AS value, 
    ui.u_outages, 
    ui.Month_int, 
    ui.Date
FROM 
    u_it_availability AS ui

UNION ALL

SELECT 
    '999999' AS sys_id, 
    'yearcount' AS u_name, 
    ou.cmdb_ci AS u_configuration_item, 
    '4.Unplanned Outage Count' AS kpi, 
    ou.qty AS value, 
    'count' AS u_outages, 
    to_char(ou.begin_date, 'MM')::int AS Month_int, 
    ou.begin_date
FROM 
    outage_count AS ou

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    'Percent' AS kpi, 
    ui.u_percent_available AS value, 
    ui.u_outages, 
    ui.Month_int, 
    ui.Date
FROM 
    u_it_availability AS ui

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '# System(s) Uptime Below Target' AS kpi, 
    CASE WHEN ui.u_percent_available > 99.5 THEN 0 ELSE 1 END AS value, 
    ui.u_outages, 
    ui.Month_int, 
    ui.Date
FROM 
    u_it_availability AS ui

UNION ALL

SELECT 
    'SG' AS sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '# System(s) Uptime Below Target' AS kpi, 
    CASE WHEN ui.u_percent_available > 99.8 THEN 0 ELSE 1 END AS value, 
    ui.u_outages, 
    ui.Month_int, 
    ui.Date
FROM 
    u_it_availability AS ui;