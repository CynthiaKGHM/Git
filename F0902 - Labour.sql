SELECT gbaid, gbctry, gbfy, gbfq, gblt, gbsbl, gbco, gbapyc, gban01, gban02, gban03, gban04, gban05, gban06, gban07, gban08, gban09, gban10, gban11, gban12, gban13, gban14, gbapyn, gbawtd, gbborg, gbpou, gbpc, gbtker, gbbreq, gbbapr, gbmcu, gbobj, gbsub, gbuser, gbpid, gbupmj, gbjobn, gbsblt, gbupmt, gbcrcd, gbcrcx, gbprgf, gband01, gband02, gband03, gband04, gband05, gband06, gband07, gband08, gband09, gband10, gband11, gband12, gband13, gband14
FROM jdepd.f0902;


select gbobj as object_account, gbsub as subsidiary, sum(gban01/100) as January, sum(gban02/100) as February, sum(gban03/100) as March, sum(gban04/100) as April, 
 sum(gban05/100) as May, sum(gban06/100) as June, sum(gban07/100) as July, sum(gban08/100) as August,
  sum(gban09/100) as September, sum(gban10/100) as October, sum(gban11/100) as November, sum(gban12/100) as December
from jdepd.f0902 f 
where gbco = '00001' and gblt = 'AA' and trim(gbobj) in ('7115','7125','7127', '7131','7141','7146', '7151', '7156', '7158') and gbfy = 24 and gbmcu = '401650'
group by f.gbobj, f.gbsub 



select gbobj as object_account, gbsub as subsidiary, sum(gban01/100) as January, sum(gban02/100) as February, sum(gban03/100) as March, sum(gban04/100) as April, 
 sum(gban05/100) as May, sum(gban06/100) as June, sum(gban07/100) as July, sum(gban08/100) as August,
  sum(gban09/100) as September, sum(gban10/100) as October, sum(gban11/100) as November, sum(gban12/100) as December
from jdepd.f0902 f
where gbco = '00047' and gblt = 'AA' and trim(gbobj) in ('7115','7125','7127', '7131','7141', '7146', '7151', '7156', '7158') and gbfy = 24 
group by f.gbobj, f.gbsub 



select gbobj as object_account, gbsub as subsidiary, sum(gban01/100) as January, sum(gban02/100) as February, sum(gban03/100) as March, sum(gban04/100) as April, 
 sum(gban05/100) as May, sum(gban06/100) as June, sum(gban07/100) as July, sum(gban08/100) as August,
  sum(gban09/100) as September, sum(gban10/100) as October, sum(gban11/100) as November, sum(gban12/100) as December
from jdepd.f0902 F 
where gbco in ('00001', '00002', '00003', '00004') and gblt = 'AA' and trim(gbobj) in ('7115','7125','7127', '7131','7141','7146', '7151', '7156', '7158') and gbfy = 24 and gbmcu <> '401650'
group by f.gbobj, f.gbsub 


select gbobj, gban01/100 as Jan,  TO_DATE(TO_CHAR(1900 + FLOOR(gbupmj / 1000), '0000') ||
TO_CHAR(MOD(gbupmj , 1000), '000'), 'YYYYDDD') as Date
from f0902 f 
where gbco = '00003'


select a.gbco as company, a.gbobj as object_account, a.gbsub as subsidiary, b.gmdl01 as account_description, sum(gban01/100) as January, sum(gban02/100) as February, sum(gban03/100) as March, sum(gban04/100) as April, 
 sum(gban05/100) as May, sum(gban06/100) as June, sum(gban07/100) as July, sum(gban08/100) as August,
  sum(gban09/100) as September, sum(gban10/100) as October, sum(gban11/100) as November, sum(gban12/100) as December
from jdepd.f0901 b
LEFT JOIN jdepd.f0902 a
ON a.gbobj=b.gmobj
where gbco IN( '00004', '00001', '00002', '00003') and gblt = 'AA' and trim(gbobj) in ('7115','7125','7127', '7131','7141','7146', '7151', '7156', '7158') and gbfy = 24 and gbmcu <> '401650'
group by a.gbco, a.gbobj, a.gbsub, b.gmdl01
