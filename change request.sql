SELECT sys_id, active, activity_due, additional_assignee_list, approval, approval_history, approval_set, assigned_to, assigned_to_link, assignment_group, assignment_group_link, backout_plan, business_duration, business_service, business_service_link, cab_date, cab_date_time, cab_delegate, cab_delegate_link, cab_recommendation, cab_required, calendar_duration, category, change_plan, chg_model, chg_model_link, close_code, close_notes, closed_at, closed_by, closed_by_link, cmdb_ci, cmdb_ci_link, "comments", comments_and_work_notes, company, company_link, conflict_last_run, conflict_status, contact_type, contract, contract_link, correlation_display, correlation_id, delivery_plan, delivery_plan_link, delivery_task, delivery_task_link, description, due_date, end_date, escalation, expected_start, follow_up, group_list, impact, implementation_plan, justification, knowledge, "location", location_link, made_sla, "number", on_hold, on_hold_reason, on_hold_task, opened_at, opened_by, opened_by_link, order_pg, outside_maintenance_schedule, parent, parent_link, phase, phase_state, priority, production_system, reason, reassignment_count, rejection_goto, rejection_goto_link, requested_by, requested_by_date, requested_by_link, review_comments, review_date, review_status, risk, risk_impact_analysis, route_reason, "scope", service_offering, service_offering_link, short_description, skills, sla_due, start_date, state, sys_class_name, sys_created_by, sys_created_on, sys_domain, sys_mod_count, sys_tags, sys_updated_by, sys_updated_on, task_effective_number, test_plan, time_worked, "type", u_active_approvals, u_add_customer_reply, u_approvals, u_area, u_category_2, u_category_3, u_choice_survey, u_comm_others, u_communication, u_cust_first_approval, u_design_approver, u_design_approver_link, u_dev__actual_worktime, u_dev__planned_worktime, u_downtime_variance, u_final_approver, u_final_approver_link, u_impacted_groups, u_it_service, u_it_service_link, u_lookup_name, u_man_days, u_origen_change, u_prod__actual_worktime, u_prod__planned_worktime, u_prod_actual_end, u_prod_actual_start, u_prod_planned_end, u_prod_planned_start, u_production_outage, u_production_outage_duration, u_project, u_project_link, u_project_reference, u_project_reference_link, u_project_task_reference, u_project_task_reference_link, u_ptask_reference, u_ptask_reference_link, u_quick_approval, u_rescheduled, u_risk, u_schedule_approver, u_schedule_approver_link, u_status, u_test_env_avail, u_updated_by_name, u_work_type, u_workflow_stage, unauthorized, universal_request, universal_request_link, upon_approval, upon_reject, urgency, user_input, variables, watch_list, wf_activity, wf_activity_link, work_end, work_notes, work_notes_list, work_start
FROM public.cdata_change_request;


	b.u_schedule_approver AS name,
    b.opened_at,
    b.short_description as description,
    b.priority,
    b.u_status,
    b.u_workflow_stage
    
    INNER JOIN cdata_system_user ON cdata_system_user.sys_id = cdata_change_request.opened_by

SELECT
    approver."name" AS approver,
    b.createdby,
    b.requester_name,
    b.opened_name,
    b.sys_created_on,
    b.number,
    b."type",
    b.approver_name,
    b.opened_at,
    b.description,
    b.priority,
    b.u_status,
    b.u_workflow_stage,
   	b.u_prod_planned_start,
    b.u_prod_planned_end,
    b.u_prod_actual_end,
    b.u_prod_actual_start,
    b.assignment_group,
    b.sys_updated_on,
    b.company,
    b.state,
    b.u_description,
    b.u_category_3 AS caterogy3,
    b.u_category_2 AS categort2,
    b.category
    
FROM
    (
        SELECT
            cdata_system_user.name AS createdby,
            cdata_system_user.name AS requested_by,
            cdata_system_user.name AS opened_by,
            a.*
        FROM
            (
                SELECT
                    cdata_task.assigned_to,
                    cdata_sysapproval_approver.sys_created_on,
                    cdata_task.number,
                    cdata_sysapproval_approver.state,
                    cdata_sysapproval_approver.u_description,
                    cdata_change_request.u_schedule_approver AS approver_name,
                    cdata_system_user."name" AS requester_name,
                    opener."name" AS opened_name,
                    cdata_change_request."type",
                    cdata_change_request.u_prod_planned_start,
                    cdata_change_request.u_prod_planned_end,
                    cdata_change_request.u_prod_actual_end,
                    cdata_change_request.u_prod_actual_start,
                    cdata_system_user_group.name as assignment_group,
                    cdata_change_request.sys_updated_on,
                    cdata_change_request.company,
                    cdata_change_request.opened_at,
                    cdata_change_request.short_description as description,
                    CASE 
				        WHEN cdata_task.priority = 1 THEN '1 - critical'
				        WHEN cdata_task.priority = 2 THEN '2 - high'
				        WHEN cdata_task.priority = 3 THEN '3 - moderate'
				        WHEN cdata_task.priority = 4 THEN '4 - low'
				        WHEN cdata_task.priority = 5 THEN '5 - planning'
				    END AS priority,
                    cdata_change_request.u_status,
                    cdata_change_request.u_workflow_stage,
                    cdata_change_request.u_category_3,
                    cdata_change_request.u_category_2,
                    cdata_change_request.category
                   
                FROM
                    cdata_task
                INNER JOIN cdata_sysapproval_approver ON cdata_sysapproval_approver.document_id = cdata_task.sys_id
                INNER JOIN cdata_change_request ON cdata_change_request.sys_id = cdata_task.sys_id
                INNER JOIN cdata_system_user ON cdata_system_user.sys_id = cdata_change_request.requested_by
                INNER JOIN cdata_system_user as opener ON opener.sys_id = cdata_change_request.opened_by 
                LEFT JOIN cdata_system_user_group ON cdata_system_user_group.sys_id = cdata_task.assignment_group
                
            ) AS a
        INNER JOIN cdata_system_user ON cdata_system_user.sys_id = a.assigned_to
    ) AS b
INNER JOIN cdata_system_user AS approver ON approver.sys_id = b.approver_name;