SELECT sys_id, active, activity_due, additional_assignee_list, approval, approval_history, approval_set, approved_end_date, approved_start_date, assessment_required, assigned_to, assigned_to_link, assignment_group, assignment_group_link, assumptions, barriers, business_applications, business_capabilities, business_case, business_duration, business_service, business_service_link, business_unit, business_unit_link, calculation_type, calendar_duration, capital_budget, capital_outlay, category, "change", change_link, close_demand, close_notes, closed_at, closed_by, closed_by_link, cmdb_ci, cmdb_ci_link, collaborators, "comments", comments_and_work_notes, company, company_link, contact_type, contract, contract_link, correlation_display, correlation_id, defect, defect_link, delivery_plan, delivery_plan_link, delivery_task, delivery_task_link, demand, demand_actual_cost, demand_actual_effort, demand_manager, demand_manager_link, department, department_link, description, discount_rate, due_date, enablers, enhancement, enhancement_link, escalation, expected_risk, expected_roi, expected_start, financial_benefit, financial_return, follow_up, goal, goal_link, goals, group_list, idea, idea_link, impact, impacted_business_units, in_scope, investment_class, investment_type, irr_value, knowledge, labor_costs, "location", location_link, made_sla, model_id, model_id_link, npv_value, "number", opened_at, opened_by, opened_by_link, operational_budget, operational_outlay, order_pg, other_costs, out_of_scope, parent, parent_link, portfolio, portfolio_link, primary_program, primary_program_link, priority, project, project_link, project_manager, project_manager_link, rate_model, rate_model_link, reassignment_count, rejection_goto, rejection_goto_link, related_records, requested_by, resource_allocated_cost, resource_planned_cost, risk_of_not_performing, risk_of_performing, route_reason, score, score_cost, score_risk, score_size, score_strategic_allignment, score_value, service_offering, service_offering_link, short_description, "size", skills, sla_due, software_model, software_model_link, stage, start_date, state, strategic_objectives, submitted_date, submitter, submitter_link, sys_class_name, sys_created_by, sys_created_on, sys_domain, sys_mod_count, sys_tags, sys_updated_by, sys_updated_on, task_effective_number, time_worked, total_costs, "type", u_active_approvals, u_actual_end_date, u_actual_start_date, u_approvals, u_area, u_availability_of_required_skill_sets, u_business_units_involved_in_project, u_capital_expense_consulting, u_capital_expense_hardware, u_capital_expense_software, u_complexity_of_financial_effort, u_complexity_of_technical_integration, u_complexity_of_work_effort, u_compliance_impact, u_confidence_of_accomplishment, u_driven_by, u_funding_source, u_impact_on_stakeholders, u_it_service, u_it_service_link, u_maturity_of_technology, u_operational_expense_consulting, u_operational_expense_hardware, u_operational_expense_software, u_operational_impact, u_owner, u_reference_1, u_reference_1_link, u_stakeholders, u_status, u_team_complexity_vs_ir_and_er, u_team_members, universal_request, universal_request_link, upon_approval, upon_reject, urgency, user_input, variables, visited_state, watch_list, wf_activity, wf_activity_link, work_end, work_notes, work_notes_list, work_start
FROM public.cdata_dmn_demand;




select cdata_dmn_demand.sys_id, 
cdata_dmn_demand."number", 
cdata_dmn_demand.short_description, 
cdata_dmn_demand.portfolio, 
cdata_pm_portfolio.name AS primary_portfolio, 
cdata_dmn_demand.stage,
cdata_pm_project.short_description as pm_description, 
cdata_dmn_demand.project, 
cdata_dmn_demand.score, 
cdata_dmn_demand.approved_start_date, 
cdata_dmn_demand.approved_end_date, 
cdata_system_user.name as demand_manager,
INITCAP(cdata_dmn_demand.u_driven_by) as driven_by, 
cdata_pm_project.percent_complete, 
INITCAP(cdata_dmn_demand.investment_type) as Investment_type, 
cdata_dmn_demand.state, 
cdata_dmn_demand.opened_at, 
cdata_system_user_group.name as assignment_group, 
cdata_dmn_demand.sys_updated_on,
CASE 
        WHEN cdata_dmn_demand.priority = 1 THEN '1 - critical'
        WHEN cdata_dmn_demand.priority = 2 THEN '2 - high'
        WHEN cdata_dmn_demand.priority = 3 THEN '3 - moderate'
        WHEN cdata_dmn_demand.priority = 4 THEN '4 - low'
        WHEN cdata_dmn_demand.priority = 5 THEN '5 - planning'
    END AS priority, cdata_dmn_demand.company, INITCAP(cdata_dmn_demand.u_it_service), cdata_dmn_demand.sys_created_on, cdata_dmn_demand.closed_at, cdata_dmn_demand.impact
FROM public.cdata_dmn_demand
LEFT JOIN cdata_system_user ON cdata_system_user.sys_id = cdata_dmn_demand.demand_manager
LEFT JOIN cdata_pm_project ON cdata_pm_project.sys_id = cdata_dmn_demand.project
LEFT JOIN cdata_pm_portfolio ON cdata_pm_portfolio.sys_id = cdata_dmn_demand.portfolio
LEFT JOIN cdata_system_user_group ON cdata_system_user_group.sys_id = cdata_dmn_demand.assignment_group
