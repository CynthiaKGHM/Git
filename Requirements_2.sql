
SELECT
    cdata_pm_project.number AS "Number",
    cdata_pm_project.short_description AS "Name",
    project_manager_user.name AS "Manager",
     Business_user.name AS "Business Partner",
    CASE
        WHEN cdata_pm_project.priority = 1 THEN '1 - critical'
        WHEN cdata_pm_project.priority = 2 THEN '2 - high'
        WHEN cdata_pm_project.priority = 3 THEN '3 - moderate'
        WHEN cdata_pm_project.priority = 4 THEN '4 - low'
        WHEN cdata_pm_project.priority = 5 THEN '5 - planning'
    END AS priority,
    CASE
        WHEN cdata_pm_project.state = 2 THEN 'Work in progress'
        WHEN cdata_pm_project.state = 1 THEN 'Planning'
        WHEN cdata_pm_project.state = 4 THEN 'Cancelled'
        WHEN cdata_pm_project.state = 5 THEN 'Reviewed and reverted'
        WHEN cdata_pm_project.state = 6 THEN 'Resolved'
        WHEN cdata_pm_project.state = 7 THEN 'Closed skipped'
        WHEN cdata_pm_project.state = 8 THEN 'Testing / QA'
        WHEN cdata_pm_project.state = 9 THEN 'Already exist'
        WHEN cdata_pm_project.state = 10 THEN 'On hold'
        WHEN cdata_pm_project.state = 11 THEN 'On hold'
        WHEN cdata_pm_project.state = -5 THEN 'Pending'
        WHEN cdata_pm_project.state = 3 THEN 'Closed complete'
        ELSE NULL 
    END AS state_name,
    cdata_pm_project.phase AS "State",
    cdata_system_user_group."name" as "Assignment Group",
    cdata_core_company."name" AS "Company",
    cdata_cmn_department."name" as "Department",
    cdata_cmn_location."name" as "Site",
    CAST(cdata_pm_project.opened_at AS DATE) AS "Opened at",
    CAST(cdata_pm_project.start_date AS DATE) AS "Planned_Start_Date",
    CAST(cdata_pm_project.end_date AS DATE) AS "Planned_End_Date"
FROM
    cdata_pm_project
    LEFT JOIN cdata_system_user_group ON cdata_system_user_group.sys_id = cdata_pm_project.assignment_group
    LEFT JOIN cdata_system_user AS project_manager_user ON project_manager_user.sys_id = cdata_pm_project.project_manager
    LEFT JOIN cdata_system_user AS Business_user ON Business_user.sys_id = cdata_pm_project.u_business_partner
    LEFT JOIN cdata_core_company ON cdata_core_company.sys_id = project_manager_user.company
    LEFT JOIN cdata_cmn_location ON cdata_cmn_location.sys_id = Business_user.location
    LEFT JOIN cdata_cmn_department ON cdata_cmn_department.sys_id = Business_user.department 

UNION ALL

SELECT
    cdata_dmn_demand.number AS "Number",
    cdata_dmn_demand.short_description AS "Name",
    demand_manager_user.name as "Manager",
    opened_by_user.name AS "Business Partner",
    CASE
        WHEN cdata_dmn_demand.priority = 1 THEN '1 - critical'
        WHEN cdata_dmn_demand.priority = 2 THEN '2 - high'
        WHEN cdata_dmn_demand.priority = 3 THEN '3 - moderate'
        WHEN cdata_dmn_demand.priority = 4 THEN '4 - low'
        WHEN cdata_dmn_demand.priority = 5 THEN '5 - planning'
    END AS priority,
     CASE
        WHEN cdata_dmn_demand.state = 2 THEN 'Submitted'
        WHEN cdata_dmn_demand.state = 1 THEN 'Draft'
        WHEN cdata_dmn_demand.state = 4 THEN 'Cancelled'
        WHEN cdata_dmn_demand.state = 5 THEN 'Reviewed and reverted'
        WHEN cdata_dmn_demand.state = 6 THEN 'Resolved'
        WHEN cdata_dmn_demand.state = 7 THEN 'Closed skipped'
        WHEN cdata_dmn_demand.state = 8 THEN 'Approved'
        WHEN cdata_dmn_demand.state = 9 THEN 'Completed'
        WHEN cdata_dmn_demand.state = 10 THEN 'On hold'
        WHEN cdata_dmn_demand.state = 11 THEN 'On hold'
        WHEN cdata_dmn_demand.state = -4 THEN 'Qualified'
        WHEN cdata_dmn_demand.state = 3 THEN 'Closed complete'
        ELSE NULL 
    END AS state_name,
    cdata_dmn_demand.u_status AS "Phase",
    cdata_system_user_group."name" as "Assignment Group",
    cdata_core_company."name" AS "Company",
    cdata_cmn_department."name" as "Department",
    cdata_cmn_location."name" as "Site",
    CAST(cdata_dmn_demand.opened_at AS DATE) AS "Opened at",
    CAST(cdata_dmn_demand.approved_start_date AS DATE)  AS "Planned_Start_Date",
    CAST(cdata_dmn_demand.approved_end_date AS DATE) AS "Planned_End_Date"
FROM
    cdata_dmn_demand
    LEFT JOIN cdata_system_user_group ON cdata_system_user_group.sys_id = cdata_dmn_demand.assignment_group
    LEFT JOIN cdata_system_user AS demand_manager_user ON demand_manager_user.sys_id = cdata_dmn_demand.demand_manager
    LEFT JOIN cdata_system_user AS opened_by_user ON opened_by_user.sys_id = cdata_dmn_demand.u_reference_1  
    LEFT JOIN cdata_core_company ON cdata_core_company.sys_id = demand_manager_user.company
	LEFT JOIN cdata_cmn_location ON cdata_cmn_location.sys_id = opened_by_user.location
	LEFT JOIN cdata_cmn_department ON cdata_cmn_department.sys_id = opened_by_user.department
where cdata_dmn_demand.number <> 'DMND0001627' 