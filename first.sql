SELECT ilnlin, ilitm, illitm, ilaitm, ilmcu, illocn, illotn, ilplot, ilstun, illdsq, iltrno, ilfrto, illmcx, illots, illotp, illotg, ilkit, ilmmcu, ildmct, ildmcs, ilkco, ildoc, ildct, ilsfx, iljeln, ilicu, ildgl, ilglpt, ildcto, ildoco, ilkcoo, illnid, ilipcd, iltrdj, iltrum, ilan8, iltrex, iltref, ilrcd, iltrqt, iluncs, ilpaid, ilterm, ilukid, iltday, iluser, ilpid, ilcrdj, ilaid, ilasid, ilmcuz, ilobj, ilsbl, ilsub, iluom2, ilcmoo, ilre, ilsblt, ilsqor, ilvpej, ilhdgj, ilshan, ilopsq, ilrfln, iltgn, illotc, ilsvdt, illrcd, ilrlot, illpnu, ilpmpn, ilpns
FROM jdepd.f4111;

select distinct ilitm, illitm, ilaitm, imitm, imdsc1, imdsc2, (iltrqt/10000) as qoh, (iluncs / 10000) as unitcost, TO_DATE(TO_CHAR(1900 + FLOOR(iltrdj / 1000), '0000') ||
TO_CHAR(MOD(iltrdj, 1000), '000'), 'YYYYDDD') as Date
from jdepd.f4111 a
join jdepd.f4101 b 
     on a.ilitm = b.imitm
group by ilitm, iluncs, imitm, illitm, ilaitm, iltrqt, TO_DATE(TO_CHAR(1900 + FLOOR(iltrdj / 1000), '0000') ||
TO_CHAR(MOD(iltrdj, 1000), '000'), 'YYYYDDD')


select count (distinct ilitm) from jdepd.f4111

select count (distinct ilitm) from jdepd.f4111


select ilitm, iltrqt/10000, ildct, (iluncs / 10000) as unitcost, ilpaid/10000, TO_DATE(TO_CHAR(1900 + FLOOR(iltrdj / 1000), '0000') ||
TO_CHAR(MOD(iltrdj, 1000), '000'), 'YYYYDDD') as Date
from jdepd.f4111 where ilitm = 156097



select ilitm as item_no, illitm as item_no2, ildct as doc, iltrex as exp, iltrqt/10000 as qoh, iluncs/10000 as unitcost, TO_DATE(TO_CHAR(1900 + FLOOR(iltrdj  / 1000), '0000') ||
TO_CHAR(MOD(iltrdj, 1000), '000'), 'YYYYDDD') as Date
from jdepd.f4111 
where ilitm = 190962
order by date desc 



select 
TO_CHAR(
	TO_DATE(
		CASE
			WHEN LENGTH(BTRIM(hdr.liupmj::TEXT)) = 5
				THEN '19' || SUBSTRING(CONCAT('0', hdr.liupmj::text), 2, 2)
			WHEN SUBSTRING(hdr.liupmj::TEXT, 1, 1) = '0' 
				THEN '19' || SUBSTRING(hdr.liupmj::TEXT, 2, 2)
			ELSE '20' || SUBSTRING(hdr.liupmj::TEXT, 2, 2)
		END || CASE WHEN LENGTH(BTRIM(hdr.liupmj::TEXT)) = 5 THEN SUBSTRING(CONCAT('0', hdr.liupmj::text), 4, 3) ELSE SUBSTRING(hdr.liupmj::TEXT, 4, 3) END, 
		'YYYYDDD'
	), 'YYYYMMDD'::text)::integer as updated_date_key,
hdr.liitm,
btrim(bu.mcmcu::text) as mcmcu,
sum(hdr.lipqoh / 10000) as quantity_on_hand,
y.line_iluncs as unit_cost,
sum(det.ibropi/10000 + det.ibroqi/10000) as max_qty,
row_number() over(partition by hdr.liitm order by hdr.liupmj desc, lilrcj desc) as rn,
current_timestamp
from
	jdepd.f41021 hdr
join
	jdepd.f4102 as det 
	on det.ibmcu = hdr.limcu 
	and det.ibitm = hdr.liitm
join
	jdepd.f0006 as bu on hdr.limcu = bu.mcmcu
join 
(select
	det.ilitm,
	det.ildct,
	det.iltrdj,
	case when det.ildct = 'OV' then rn_order else rn end as rn,
	sum(det.iluncs) / 10000 as line_iluncs
from (
	select
		ilitm,
		ildct,
		iltrdj,
		ilukid,
		iluncs,
		dense_rank() over(partition by ilitm order by iltrdj desc, ilukid desc) as rn,
		dense_rank() over(partition by ilitm, iltrex order by iltrdj desc, ildoc desc, ilukid desc) as rn_order
	from 
		jdepd.f4111
	where 
		ildct in ('PI', 'IM', 'OV', 'II', 'IA', 'IT')
) as det
group by 
	det.ilitm,
	det.ildct,
	det.iltrdj,
	case when det.ildct = 'OV' then rn_order else rn end) as y
on hdr.liitm = y.ilitm
group by
	hdr.liitm,
	bu.mcmcu,
	hdr.liupmj,
	hdr.lilrcj,
	y.line_iluncs;
	








