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


select ilitm, (iluncs / 10000) as unitcost, TO_DATE(TO_CHAR(1900 + FLOOR(iltrdj / 1000), '0000') ||
TO_CHAR(MOD(iltrdj, 1000), '000'), 'YYYYDDD') as Date
from jdepd.f4111 where ilitm = 15059