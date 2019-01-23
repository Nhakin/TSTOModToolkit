unit TSTOSbtpTypes;

interface

Const
  SbtpVariablePrefix : Array[0..15] Of String = (
    'bld_', 'cha_', 'frm_', 'gen_',
    'info_', 'job_', 'mtx_', '',
    'push_', '', '', 'rat_',
    'req_', 'res_', 'ui_', ''
  );
(*
bld_,cache
cha_,cache
frm_,_,cacheall
gen_,cacheall
info_,cacheall
job_,cache
mtx_,cacheall
promo_,_,cacheall
push_,cache
qst_dq_,_,cacheallunloadable
qst_,_,cacheallunloadable
rat_,cacheall
req_,cacheall
res_,cacheall
ui_,cacheall
,cache
*)
implementation

end.
