SELECT "Name", "Business criticality", "Used for", "Managed by", "Owned by", "Approval group", "Location", "Operational status", "Parent", "Number", "Updated by"
FROM public.service_offering
union 
select * from public.cmdb_ci_service_technical 

SELECT a."Name", a."Business criticality", a."Number" 
FROM public.service_offering a
union 
select b."Name", b."Business criticality" , b."Service classification" from public.cmdb_ci_service_technical b

select * 
FROM public.service_offering a
inner join public.cmdb_ci_service_technical b
on a."Name" = b."Name" 


SELECT
    mtom.begin_date,
    mtom.cmdb_ci,
    to.name,
    mtom.type,
    COUNT(mtom.cmdb_ci) AS qty
FROM
    cmdb_ci_outage AS mtom
INNER JOIN
    technical_offering AS to ON mtom.cmdb_ci = to.sys_id
WHERE
    mtom.type = 'outage'
GROUP BY
    mtom.begin_date,
    mtom.cmdb_ci,
    to.name,
    mtom.type;






SELECT
  mtom.begin_date,
  mtom.cmdb_ci,
  to_name.name AS name,
  mtom.type,
  COUNT(mtom.cmdb_ci) AS qty
FROM cmdb_ci_outage AS mtom
JOIN (
  SELECT a.sys_id, "name", busines_criticality, "number", service_classification
  FROM cdata_service_offering AS a
  UNION ALL
  SELECT b.sys_id, "name", busines_criticality, "number", service_classification
  FROM cdata_cmdb_ci_service_technical AS b
) AS to_name ON mtom.cmdb_ci = to_name.sys_id
WHERE mtom.type = 'outage'
GROUP BY mtom.begin_date, mtom.cmdb_ci, to_name.name, mtom.type;


select c.begin, c.cmdb_ci, c."type", d."name", count(c.cmdb_ci) as qty
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
GROUP BY c.begin, c.cmdb_ci, d."name", c.type;




select a.sys_id, "name" , busines_criticality, "number", service_classification from cdata_service_offering as a
union 
select b.sys_id, "name", busines_criticality, "number", service_classification from cdata_cmdb_ci_service_technical as b

select * from c.data_cmdb_ci_service_technical cccst 