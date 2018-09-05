cd "C:\Users\isagarzazu\Dropbox\CCAP\panel\"

clear
clear matrix
clear mata
set maxvar 10000
cd "C:\Users\isagarzazu\Dropbox\CCAP\panel\"

use "bccap_temp.dta", clear


forvalues i=2(1)5 {

gen tmp_LRS = LR_Self_`i'
gen tmp_pers = perProb`i' 
gen tmp_retnat = retnat_`i' 
gen tmp_retper = retper_`i' 
gen tmpVote = voteinc_`i'

quietly: xi: logit tmpVote tmp_* educ_quart demsat_1 union_1 age if rich2==0 
est store fR_Poor_`i'
quietly: xi: logit tmpVote tmp_* educ_quart demsat_1 union_1 age if rich2==1 
est store fR_Rich_`i'
quietly: xi: logit tmpVote tmp_* educ_quart demsat_1 union_1 age if incomeTrioX==1
est store fR_Poor_X`i'
quietly: xi: logit tmpVote tmp_* educ_quart demsat_1 union_1 age if incomeTrioX==3 
est store fR_Rich_X`i'
drop tmp_* tmpVote
}
est table fR_Poor_*, star(0.05 0.01 0.005) stats(N ll r2) b(%5.2f)
est table fR_Rich_*, star(0.05 0.01 0.005) stats(N ll r2) b(%5.2f)

est table fR_Poor_*, se stats(N ll r2) b(%5.2f)
est table fR_Rich_*, se stats(N ll r2)  b(%5.2f)

est table fR_*, star(0.05 0.01 0.005) stats(N ll r2) b(%5.3f)
est table fR_*, se stats(N ll r2) b(%5.3f)


******

egen taxes_mean = rowmean(taxes1 taxes2 taxes3 taxes4)
egen taxesP_mean = rowmean(taxesP*)
egen taxesR_mean = rowmean(taxesR*)
egen taxesHealth_mean = rowmean(taxesHealth*)

factor taxes*mean
predict taxesPolicy1 taxesPolicy2

hist taxesPolicy1, by(rich2)
hist taxesPolicy2, by(rich2)

bys rich2: sum taxesPolicy*

forvalues i=2(1)5 {
local i=2
gen tmp_LRS = LR_Self_`i'
gen tmp_pers = perProb`i' 
gen tmp_retnat = retnat_`i' 
gen tmp_retper = retper_`i' 
*gen tmp_policy1 = taxes`i'
gen tmp_policy2 = taxesHealth_mean
gen tmpVote = voteinc_`i'

quietly: xi: logit tmpVote tmp_* educ_quart demsat_1 union_1 age if rich2==0 
margins, at(tmp_policy2=(1 3))
est store fR_Poor_`i'
quietly: xi: logit tmpVote tmp_*  educ_quart demsat_1 union_1 age if rich2==1 
margins, at(tmp_policy2=(1 3))
est store fR_Rich_`i'
drop tmp_* tmpVote
}

est table fR_Poor_*, star(0.05 0.01 0.005) stats(N ll r2) b(%5.2f)
est table fR_Rich_*, star(0.05 0.01 0.005) stats(N ll r2) b(%5.2f)

est table fR_*, star(0.05 0.01 0.005) stats(N ll r2) b(%5.3f)
est table fR_*, se stats(N ll r2) b(%5.3f)



*************** GERMANY


clear
clear matrix
clear mata
set maxvar 10000
cd "C:\Users\isagarzazu\Dropbox\CCAP\panel\"

use "deccap_temp.dta", clear


forvalues i=1(1)3 {
gen tmp_pers = perProb`i' 
gen tmp_retnat = retnat_`i' 
gen tmp_retper = retper_`i' 
gen tmp_demsat = demsat_`i'
gen tmpVote = voteinc_`i'

quietly: logit tmpVote tmp_* LR_Self_1 educ_quart  union age if rich2==0
est store fR_Poor_`i'
quietly: logit tmpVote tmp_* LR_Self_1 educ_quart  union age if rich2==1
est store fR_Rich_`i'
quietly: logit tmpVote tmp_* LR_Self_1 educ_quart  union age if incomeTrioX==1
*est store fR_Poor_X`i'
quietly: logit tmpVote tmp_* LR_Self_1 educ_quart  union age if incomeTrioX==3
*est store fR_Rich_X`i'
drop tmp_* tmpVote
}
est table fR_Poor_*, star(0.05 0.01 0.005) stats(N ll chi) b(%5.2f)
est table fR_Rich_*, star(0.05 0.01 0.005) stats(N ll chi) b(%5.2f)

est table fR_*, star(0.05 0.01 0.005) stats(N ll r2) b(%5.3f)
est table fR_*, se stats(N ll r2) b(%5.3f)


forvalues i=1(1)3 {
gen tmp_pers = perProb`i' 
gen tmp_retnat = retnat_`i' 
gen tmp_retper = retper_`i' 
gen tmp_demsat = demsat_`i'
gen tmpVote = vote_`i' //voteinc_`i'

quietly: mlogit tmpVote tmp_* LR_Self_1 educ_quart  union age if rich==0, base(2)
est store fR_Poor_`i'
quietly: mlogit tmpVote tmp_* LR_Self_1 educ_quart  union age if rich==1, base(2)
est store fR_Rich_`i'
quietly: mlogit tmpVote tmp_* LR_Self_1 educ_quart  union age if incomeTrioX==1, base(2)
*est store fR_Poor_X`i'
quietly: mlogit tmpVote tmp_* LR_Self_1 educ_quart  union age if incomeTrioX==3, base(2)
*est store fR_Rich_X`i'
drop tmp_* tmpVote
}
est table fR_Poor_*, star(0.05 0.01 0.005) stats(N ll r2) b(%5.2f)
est table fR_Rich_*, star(0.05 0.01 0.005) stats(N ll r2) b(%5.2f)

est table fR_*, star(0.05 0.01 0.005) stats(N ll r2) b(%5.3f)
est table fR_*, se stats(N ll r2) b(%5.3f)
