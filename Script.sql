SELECT gmco, gmaid, gmmcu, gmobj, gmsub, gmans, gmdl01, gmlda, gmbpc, gmpec, gmbill, gmcrcd, gmum, gmr001, gmr002, gmr003, gmr004, gmr005, gmr006, gmr007, gmr008, gmr009, gmr010, gmr011, gmr012, gmr013, gmr014, gmr015, gmr016, gmr017, gmr018, gmr019, gmr020, gmr021, gmr022, gmr023, gmobja, gmsuba, gmwcmp, gmcct, gmerc, gmhtc, gmqlda, gmccc, gmfmod, gmuser, gmpid, gmjobn, gmupmj, gmupmt, gmcec1, gmcec2, gmcec3, gmcec4, gmiec, gmfpec, gmstpc, gmtxgl, gmtobj, gmtsub, gmprgf, gmtxa1, gmr024, gmr025, gmr026, gmr027, gmr028, gmr029, gmr030, gmr031, gmr032, gmr033, gmr034, gmr035, gmr036, gmr037, gmr038, gmr039, gmr040, gmr041, gmr042, gmr043, gmadjent, gmuafl
FROM jdepd.f0901;

select gmobj as object_account , gmsub as Subsidiary, gmdl01 as account_description
from jdepd.f0901 f 
where trim(f.gmobj) in ('7115','7125','7127', '7131','7141','7146', '7151', '7156', '7158')

select distinct
from jdepd.f0901 f 



select distinct gmobj as object_account
from jdepd.f0901 f 
