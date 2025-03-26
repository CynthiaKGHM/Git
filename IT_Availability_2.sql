SELECT 
    ui.sys_id , 
    ui.u_name , 
    ui.u_configuration_item, 
    '1.Required Hours' AS kpi, 
    ui.u_required_hours AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int,
    ui.sys_created_on 
FROM 
    cdata_u_it_availability  AS ui

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '2.Planned Outage Hours' AS kpi, 
    ui.u_planned_outage_hours AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int, 
    ui.sys_created_on 
FROM 
    cdata_u_it_availability  AS ui

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '3.Unplanned Outage Hours' AS kpi, 
    ui.u_unplanned_outage_hours AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int, 
    ui.sys_created_on 
FROM 
    cdata_u_it_availability  AS ui

UNION ALL

SELECT 
    '999999' AS sys_id, 
    'yearcount' AS u_name, 
    ou.cmdb_ci AS u_configuration_item, 
    '4.Unplanned Outage Count' AS kpi, 
    ou.qty AS value, 
    'count' AS u_outages, 
    to_char(ou.begin, 'MM')::int AS Month_int, 
    ou.begin
FROM 
   (select c.begin, c.cmdb_ci, c."type", d."name", count(c.cmdb_ci) as qty
from cdata_cmdb_ci_outage c 
join (
  SELECT a.sys_id, "name", busines_criticality, "number", service_classification
  FROM cdata_service_offering AS a
  UNION ALL
  SELECT b.sys_id, "name", busines_criticality, "number", service_classification
  FROM cdata_cmdb_ci_service_technical AS b
) as d
ON c.cmdb_ci = d.sys_id
WHERE c."type" = 'outage'
GROUP BY c.begin, c.cmdb_ci, d."name", c.type) as ou

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    'Percent' AS kpi, 
    ui.u_percent_available AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int, 
    ui.sys_created_on 
FROM 
    cdata_u_it_availability AS ui

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '# System(s) Uptime Below Target' AS kpi, 
    CASE WHEN ui.u_percent_available > 99.5 THEN 0 ELSE 1 END AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int, 
    ui.sys_created_on 
FROM 
    cdata_u_it_availability AS ui

UNION ALL

SELECT 
    'SG' AS sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '# System(s) Uptime Below Target' AS kpi, 
    CASE WHEN ui.u_percent_available > 99.8 THEN 0 ELSE 1 END AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int, 
    ui.sys_created_on 
FROM 
    cdata_u_it_availability AS ui;







SELECT
    u.*,
    d.*,
    s.Asset
FROM
    (SELECT 
    ui.sys_id , 
    ui.u_name , 
    ui.u_configuration_item, 
    '1.Required Hours' AS kpi, 
    ui.u_required_hours AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int,
    ui.sys_created_on 
FROM 
    cdata_u_it_availability  AS ui

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '2.Planned Outage Hours' AS kpi, 
    ui.u_planned_outage_hours AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int, 
    ui.sys_created_on 
FROM 
    cdata_u_it_availability  AS ui

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '3.Unplanned Outage Hours' AS kpi, 
    ui.u_unplanned_outage_hours AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int, 
    ui.sys_created_on 
FROM 
    cdata_u_it_availability  AS ui

UNION ALL

SELECT 
    '999999' AS sys_id, 
    'yearcount' AS u_name, 
    ou.cmdb_ci AS u_configuration_item, 
    '4.Unplanned Outage Count' AS kpi, 
    ou.qty AS value, 
    'count' AS u_outages, 
    to_char(ou.begin, 'MM')::int AS Month_int, 
    ou.begin
FROM 
   (select c.begin, c.cmdb_ci, c."type", d."name", count(c.cmdb_ci) as qty
from cdata_cmdb_ci_outage c 
join (
  SELECT a.sys_id, "name", busines_criticality, "number", service_classification
  FROM cdata_service_offering AS a
  UNION ALL
  SELECT b.sys_id, "name", busines_criticality, "number", service_classification
  FROM cdata_cmdb_ci_service_technical AS b
) as d
ON c.cmdb_ci = d.sys_id
WHERE c."type" = 'outage'
GROUP BY c.begin, c.cmdb_ci, d."name", c.type) as ou

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    'Percent' AS kpi, 
    ui.u_percent_available AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int, 
    ui.sys_created_on 
FROM 
    cdata_u_it_availability AS ui

UNION ALL

SELECT 
    ui.sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '# System(s) Uptime Below Target' AS kpi, 
    CASE WHEN ui.u_percent_available > 99.5 THEN 0 ELSE 1 END AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int, 
    ui.sys_created_on 
FROM 
    cdata_u_it_availability AS ui

UNION ALL

SELECT 
    'SG' AS sys_id, 
    ui.u_name, 
    ui.u_configuration_item, 
    '# System(s) Uptime Below Target' AS kpi, 
    CASE WHEN ui.u_percent_available > 99.8 THEN 0 ELSE 1 END AS value, 
    ui.u_outages, 
    to_char(ui.sys_created_on , 'MM')::int AS Month_int, 
    ui.sys_created_on 
FROM 
    cdata_u_it_availability AS ui) AS u
LEFT JOIN
    (
  SELECT a.sys_id, "name", busines_criticality, "number", service_classification
  FROM cdata_service_offering AS a
  UNION ALL
  SELECT b.sys_id, "name", busines_criticality, "number", service_classification
  FROM cdata_cmdb_ci_service_technical AS b
) AS d
    ON u.u_configuration_item = d.sys_id
LEFT JOIN
    system_class AS s
    ON to.name = s.name;


select * from cdata_task



SELECT cdata_system_user.name AS caller, a.*, sys_created_on
FROM (
    select cdata_system_user as opened_by from
    	(SELECT cdata_incident.caller_id,  cdata_task.number, cdata_task.priority,
    CASE 
        WHEN cdata_task.priority = 1 THEN 'critical'
        WHEN cdata_task.priority = 2 THEN 'high'
        WHEN cdata_task.priority = 3 THEN 'moderate'
        WHEN cdata_task.priority = 4 THEN 'low'
        WHEN cdata_task.priority = 5 THEN 'planning'
    END AS nivel_prioridad, cdata_incident.category, cdata_incident.subcategory, cdata_incident.u_subsubcategory,
    cdata_incident.opened_at, cdata_incident.u_estimated_effort, 
    cdata_task.assignment_group, cdata_incident.state, 
    cdata_system_user_group.name, cdata_incident.short_description, cdata_system_user.name AS opened_by,
    cdata_incident.resolved_at, cdata_incident.u_incident_class, cdata_incident.sys_updated_on, cdata_system_user.company AS company 
    FROM cdata_task  
    INNER JOIN cdata_incident ON cdata_task.sys_id = cdata_incident.sys_id
    INNER JOIN cdata_system_user_group ON cdata_system_user_group.sys_id = cdata_task.assignment_group
    LEFT JOIN cdata_system_user ON cdata_system_user.sys_id = cdata_incident.opened_by 
) AS a
LEFT JOIN cdata_system_user ON cdata_system_user.sys_id = a.caller_id 

