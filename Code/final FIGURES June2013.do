
**********
* 
* Final figures for Duch and Sagarzazu "Election Campaigns, Public Opinion and the Financial Crisis of 2008-2010 in the U.K. and Germany"
*
* Note: Needs stata 12
**********


cd "C:\Documents and Settings\Inaki.Sagarzazu\My Documents\My Dropbox\CCAP\panel\"
cd "C:\Users\isagarzazu\Dropbox\panel"
cd "C:\Users\is88h\Dropbox\panel"

/*
 Figure 1 : Evolution of Smoothed Net Median Income
*/

// Figure 1-1: Germany

clear
use "gsoep_agg_income.dta"

 tsline  smth_median_quart_netwk1, ytitle("Net Median Income, Lower Quartile",axis(1)) yscale(range(475 575)) ytick(500 550 ) ylabel(500 550, nogrid )|| /*
 */ tsline smth_median_quart_netwk4, yaxis(2) yscale(range(2900 3000) axis(2)) ylabel(2900 2950 3000,axis(2)) /*
 */ytitle("Net Median Income, Higuer Quartile",axis(2))  xtitle("Month") xtick(1 10.5 21 33) /*
 */ xlabel(1 "Jan'07" 10.5 "Jan'08" 21 "Jan'09" 33 "Jan'10") legend(label(1 "Poor (1st quartile)") label(2 "Rich (4th quartile)") cols(4) pos(6)) scheme(lean2)/*
 */ note("Source: German Socio Economic Panel (GSOEP)")
 graph export "graphs/final/figure_1-1_SmoothedMedianInc_DE.png", replace
 graph export "graphs/final/figure_1-1_SmoothedMedianInc_DE.pdf", replace
 
 
// Figure 1-1: UK

clear
use "lfs_agg_income.dta"


 tsline  smth_median_quart_netwk1 if  refwky<2010, /*
 */ ytitle("Net Median Income, Lower Quartile",axis(1)) yscale(range(100 160)) /*
 */ ytick(110 120 130 140 150 160) ylabel(110 120 130 140 150 160, nogrid ) || /*
 */ tsline smth_median_quart_netwk4 if  refwky<2010, yaxis(2) yscale(range(500 560) axis(2))  /*
 */ ytitle("Net Median Income, Higuer Quartile",axis(2))  xtitle("Month") xtick(1 13 25 37) /*
 */ xlabel(1 "Jan'07" 13 "Jan'08" 25 "Jan'09" 37 "Jan'10") legend(label(1 "Poor (1st quartile)") label(2 "Rich (4th quartile)") cols(4) pos(6)) scheme(lean2)/*
 */note("Source: UK Labour Workfoce Survey (LFS) dataset") 


graph export "graphs/final/figure_1-2_SmoothedMedianInc_UK.png", replace
graph export "graphs/final/figure_1-2_SmoothedMedianInc_UK.pdf", replace


/*
 Figure 2 : Evolution of Unemployment and Inflation Rates 2007-2010
*/

clear
use "cpi_unemp_OECD.dta"

gen p = _n
keep if p>=85 & p<=120
drop p
gen p = _n


// Figure 2-1: Unemployment

line unemp_de p || line unemp_uk p, /*
*/scheme(lean2) legend( label(1 "Germany") label(2 "United Kingdom") pos(6) cols(2)) /*
*/ylabel(,nogrid) xlabel(1(12)37) xlabel(1 "Jan'07" 13 "Jan'08" 25 "Jan'09" 37 "Jan'10") /*
*/note("Source: OECD Labour Force Statistics (MEI) dataset") ytitle("Unemployment Rate") xtitle("Month")

graph export "graphs/final/figure_2-1_Unemployment.png", replace
graph export "graphs/final/figure_2-1_Unemployment.pdf", replace


// Figure 2-2: Inflation


line cpi_de p || line cpi_uk p, /*
*/scheme(lean2) legend( label(1 "Germany") label(2 "United Kingdom") pos(6) cols(2)) /*
*/ylabel(,nogrid) xlabel(1(12)37) xlabel(1 "Jan'07" 13 "Jan'08" 25 "Jan'09" 37 "Jan'10") /*
*/note("Source: OECD Consumer Price Index (MEI) dataset") ytitle("Consumer Price Index") xtitle("Month")

graph export "graphs/final/figure_2-2_Inflation.png", replace
graph export "graphs/final/figure_2-2_Inflation.pdf", replace




/*
 Figure 3 : Percentage of Respondents who answered “Worse” / “Much Worse” in different Subjective National measures
*/

// Figure 3-1: Germany


clear
import excel "subjectiveWorse_values.xlsx", sheet("DE") firstrow

drop if measure==""

reshape long w, i(scale measure income) j(wave)
replace measure="Retrospective National" if measure =="retnat"
replace measure="Retrospective Personal" if measure =="retper"
replace measure="Prospective Personal" if measure =="proper"
replace measure="Prospective National" if measure =="pronat"

keep if measure=="Retrospective National" | measure=="Prospective National"

sc w wave if scale=="Worse" & income=="Low" || sc w wave if scale=="Worse" & income=="High", /*
*/ by(measure, note("")) scheme(lean2) /*
*/ legend(label(1 "Poor") label( 2 "Rich") cols(2)) /*
*/ ytitle("% Respondents who answered " "Worse / Much Worse") /*
*/ xtitle("Month") xscale(range(1 4)) xlabel(1 "Jun'09" 2 "Aug'09" 3 "Sep'09" 4 "Oct'09" , alt) ylabel(20(20)100)

graph export "graphs/final/figure_3-1_NatEcon_DE.png", replace
graph export "graphs/final/figure_3-1_NatEcon_DE.pdf", replace

// Figure 3-2: UK

clear
import excel "subjectiveWorse_values.xlsx", sheet("UK") firstrow

drop if measure==""

reshape long w, i(scale measure income) j(wave)
replace measure="Retrospective National" if measure =="retnat"
replace measure="Retrospective Personal" if measure =="retper"
replace measure="Prospective Personal" if measure =="proper"
replace measure="Prospective National" if measure =="pronat"

keep if measure=="Retrospective National" | measure=="Prospective National"

sc w wave if scale=="Worse" & income=="Low" || sc w wave if scale=="Worse" & income=="High", /*
*/ by(measure, note("")) scheme(lean2) /*
*/ legend(label(1 "Poor") label( 2 "Rich") cols(2)) /*
*/ ytitle("% Respondents who answered " "Worse / Much Worse") /*
*/ xtitle("Month") xscale(range(1 4)) xlabel(1 "Dec'08" 2 "Apr'09" 3 "Sep'09" 4 "Jan'10" 5 "Apr'10" 6 "Jun'10" , alt) ylabel(20(20)100)


graph export "graphs/final/figure_3-2_NatEcon_UK.png", replace
graph export "graphs/final/figure_3-2_NatEcon_UK.pdf", replace


/*
 Figure 4 : Percentage of Respondents who answered “Worse” / “Much Worse” in Subjective National measures of Unemployment and Inflation
*/

// Figure 4-1: Unemployment - Germany

clear
import excel "subjectiveWorse_values.xlsx", sheet("othersDE") firstrow

sc pc_unemp_1 wave if(p==3) || sc pc_unemp_3 wave if(p==3), scheme(lean2) legend(pos(6) cols(2) label(1 "Poor") label(2 "Rich")) /*
*/ xtitle("Month") ytitle("% Respondents who answered " "Worse / Much Worse") /*
*/ xscale(range(1 4))  ylabel(20(20)100) xlabel(1 "Jun'09" 2 "Aug'09" 3 "Sep'09" 4 "Oct'09" , alt)

graph export "graphs/final/figure_4-1_Unemp_DE.png", replace
graph export "graphs/final/figure_4-1_Unemp_DE.pdf", replace

// Figure 4-2: Inflation - Germany

sc pc_infl_1 wave if(p==3) || sc pc_infl_3 wave if(p==3), scheme(lean2) legend(pos(6) cols(2) label(1 "Poor") label(2 "Rich")) /*
*/ xtitle("Month") ytitle("% Respondents who answered " "Worse / Much Worse") /*
*/ xscale(range(1 4)) ylabel(20(20)100) xlabel(1 "Jun'09" 2 "Aug'09" 3 "Sep'09" 4 "Oct'09" , alt)

graph export "graphs/final/figure_4-2_Infl_DE.png", replace
graph export "graphs/final/figure_4-2_Infl_DE.pdf", replace


// Figure 4-3: Unemployment - UK

clear
import excel "subjectiveWorse_values.xlsx", sheet("othersUK") firstrow

sc pc_unemp_1 wave if(p==3) || sc pc_unemp_3 wave if(p==3), scheme(lean2) legend(pos(6) cols(2) label(1 "Poor") label(2 "Rich")) /*
*/ xtitle("Month") ytitle("% Respondents who answered " "Worse / Much Worse") /*
*/ xscale(range(2 5))  ylabel(20(20)100) xlabel(2 "Apr'09" 3 "Sep'09" 4 "Jan'10" 5 "Apr'10")

graph export "graphs/final/figure_4-3_Unemp_UK.png", replace
graph export "graphs/final/figure_4-3_Unemp_UK.pdf", replace

// Figure 4-4: Inflation - UK

sc pc_infl_1 wave if(p==3) || sc pc_infl_3 wave if(p==3), scheme(lean2) legend(pos(6) cols(2) label(1 "Poor") label(2 "Rich")) /*
*/ xtitle("Month") ytitle("% Respondents who answered " "Worse / Much Worse") /*
*/ xscale(range(2 5)) ylabel(20(20)100) xlabel(2 "Apr'09" 3 "Sep'09" 4 "Jan'10" 5 "Apr'10", alt)

graph export "graphs/final/figure_4-4_Infl_UK.png", replace
graph export "graphs/final/figure_4-4_Infl_UK.pdf", replace

/*
 Figure 5 : Factor values for Measure of Objective Personal Economic Situation
*/

// Figure 5-1: Germany

clear
set maxvar 10000
use "deccap_temp.dta", clear

label define rp 1 "Poor" 3 "Rich"
label values incomeTrioX rp

hist perProb2, by(incomeTrioX, legend(off) note("") cols(1) colfirst)  kdensity xtitle("Objective Personal Economy") scheme(lean2) /*
*/ addplot(sc drop median_pP2 , msymbol(X)) yscale(range(0 1.2)) ylabel(0(.2)1, nogrid)

graph export "graphs/final/figure_5-1_ObjEcon_DE.png", replace
graph export "graphs/final/figure_5-1_ObjEcon_DE.pdf", replace

// Figure 5-2: UK

clear
set maxvar 10000
use "bccap_temp.dta", clear

label define rp 1 "Poor" 3 "Rich"
label values incomeTrioX rp


hist perProb2, by(incomeTrioX, legend(off) note("") cols(1) colfirst)  kdensity xtitle("Objective Personal Economy") scheme(lean2) /*
*/ addplot(sc drop median_pP2 , msymbol(X)) yscale(range(0 1.2)) ylabel(0(.2)1, nogrid) 

graph export "graphs/final/figure_5-2_ObjEcon_UK.png", replace
graph export "graphs/final/figure_5-2_ObjEcon_UK.pdf", replace



/*
 Figure 6 : Percentage of Respondents who answered “Worse” / “Much Worse” in different Subjective Personal measures
*/

// Figure 6.-1: Germany


clear
import excel "subjectiveWorse_values.xlsx", sheet("DE") firstrow

drop if measure==""

reshape long w, i(scale measure income) j(wave)
replace measure="Retrospective National" if measure =="retnat"
replace measure="Retrospective Personal" if measure =="retper"
replace measure="Prospective Personal" if measure =="proper"
replace measure="Prospective National" if measure =="pronat"

keep if measure=="Retrospective Personal" | measure=="Prospective Personal"

sc w wave if scale=="Worse" & income=="Low" || sc w wave if scale=="Worse" & income=="High", /*
*/ by(measure, note("")) scheme(lean2) /*
*/ legend(label(1 "Poor") label( 2 "Rich") cols(2)) /*
*/ ytitle("% Respondents who answered " "Worse / Much Worse") /*
*/ xtitle("Month") xscale(range(1 4)) xlabel(1 "Jun'09" 2 "Aug'09" 3 "Sep'09" 4 "Oct'09" , alt) ylabel(20(20)100)

graph export "graphs/final/figure_6-1_PersEcon_DE.png", replace
graph export "graphs/final/figure_6-1_PersEcon_DE.pdf", replace

// Figure 6.-2: UK

clear
import excel "subjectiveWorse_values.xlsx", sheet("UK") firstrow

drop if measure==""

reshape long w, i(scale measure income) j(wave)
replace measure="Retrospective National" if measure =="retnat"
replace measure="Retrospective Personal" if measure =="retper"
replace measure="Prospective Personal" if measure =="proper"
replace measure="Prospective National" if measure =="pronat"

keep if measure=="Retrospective Personal" | measure=="Prospective Personal"

sc w wave if scale=="Worse" & income=="Low" || sc w wave if scale=="Worse" & income=="High", /*
*/ by(measure, note("")) scheme(lean2) /*
*/ legend(label(1 "Poor") label( 2 "Rich") cols(2)) /*
*/ ytitle("% Respondents who answered " "Worse / Much Worse") /*
*/ xtitle("Month") xscale(range(1 4)) xlabel(1 "Dec'08" 2 "Apr'09" 3 "Sep'09" 4 "Jan'10" 5 "Apr'10" 6 "Jun'10" , alt) ylabel(20(20)100)

graph export "graphs/final/figure_6-2_PersEcon_UK.png", replace
graph export "graphs/final/figure_6-2_PersEcon_UK.pdf", replace




/*
 Figure 7 : Tax increases vs. Health spending - UK
*/

clear
use "taxesFile.dta"

egen y=rowmean(taxesHealth_*)
keep if y==1 | y==3
drop if x_2==. | incomeTrioX==.
keep y x_2 incomeTrioX pc_th_*
duplicates drop
keep if pc_th_3!=. & pc_th_4!=. & pc_th_5!=.
reshape long pc_th_, i(incomeTrioX x_2 y) j(wave)
reshape wide pc_th_, i(incomeTrioX y wave) j(x_2)

label define policy 1 "Reduce taxes and spending" 3 "Increase taxes and spending"
label values y policy


label define rP 1 "Poor" 3 "Rich"
label values incomeTrioX rP

replace incomeTrio=. if incomeTrioX==2

graph bar pc_th_0 pc_th_1 if wave==5,  over(incomeTrio) by(y, note("")) /*
*/ legend(label(1 "Bad") label(2 "Good") cols(2)) scheme(lean2)

graph export "graphs/final/figure_7_TaxesSpendingPolicy_UK.png", replace
graph export "graphs/final/figure_7_TaxesSpendingPolicy_UK.pdf", replace

/*
 Figure 8 : Redistributive tax preferences - UK
*/


clear
use "taxesFile"

drop taxesHealth*
egen y=rowmean(taxes*)
keep if y==1 | y==3
drop if x_2==. | incomeTrioX==.
keep y x_2 incomeTrioX pc_taxes*
duplicates drop
collapse (max) pc_taxes*, by(y x_2 incomeTrio)
reshape long pc_taxes_ pc_taxesR_ pc_taxesP_, i(incomeTrio x_2 y) j(wave)
reshape wide pc_taxes_ pc_taxesR_ pc_taxesP_, i(incomeTrio wave y) j(x_2)

recode y (1=3) (3=1)
label define policy 3 "More than should" 1 "Less than should"
label values y policy


label define rP 1 "Poor" 3 "Rich"
label values incomeTrioX rP


graph bar pc_taxes_0 pc_taxes_1 if wave==1,  over(incomeTrio) by(y, note("")) ylabel(0.2(.2).6) /*
*/ legend(label(1 "Bad") label(2 "Good") cols(2)) scheme(lean2)

graph export "graphs/final/figure_8-1_TaxesPolicy_UK.png", replace
graph export "graphs/final/figure_8-1_TaxesPolicy_UK.pdf", replace


graph bar pc_taxesP_0 pc_taxesP_1 if wave==1,  over(incomeTrio) by(y, note("")) ylabel(0.2(.2).6) /*
*/ legend(label(1 "Bad") label(2 "Good") cols(2)) scheme(lean2)

graph export "graphs/final/figure_8-2_TaxesPolicy_UK.png", replace
graph export "graphs/final/figure_8-2_TaxesPolicy_UK.pdf", replace

graph bar pc_taxesR_0 pc_taxesR_1 if wave==1,  over(incomeTrio) by(y, note("")) ylabel(0.2(.2).6) /*
*/ legend(label(1 "Bad") label(2 "Good") cols(2)) scheme(lean2)


graph export "graphs/final/figure_8-3_TaxesPolicy_UK.png", replace
graph export "graphs/final/figure_8-3_TaxesPolicy_UK.pdf", replace


/*
 Figure 9: Average Probability of voting for PM party UK (Labour)
*/

use "bccap_temp.dta",clear

forvalues i=2(1)5 {

gen tmp_LRS = LR_Self_`i'
gen tmp_pers = personal_`i' 
gen tmp_retnat = retnat_`i' 
gen tmp_retper = retper_`i' 
quietly: xi: mlogit vote_`i' tmp_* educ_quart demsat_1 union_1 age if rich2==0, base(1)
predict pr_p, outcome(1) 
quietly: xi: mlogit vote_`i' tmp_* educ_quart demsat_1 union_1 age if rich2==1, base(1)
predict pr_r, outcome(1) 
*quietly: xi: mlogit vote_`i' tmp_* educ_quart demsat_1 union_1 age if incomeTrio==2, base(1)
*predict pr_r, outcome(1) 

gen prLabour_`i' = .
replace prLabour_`i' = pr_p if incomeTrio==0
*replace prLabour_`i' = pr_m if incomeTrio==1
replace prLabour_`i' = pr_r if incomeTrio==2

drop tmp_* pr_p pr_r

gen tmp_one = 1
gen tmp_retnat = retnat_`i'
gen tmp_retper = retper_`i' 
recode tmp_retnat tmp_retper (1/2=1) (3=2) (4/5=3)
egen mean_prLabour_`i'_retnat = mean(prLabour_`i'), by(tmp_retnat rich2)
egen mean_prLabour_`i'_retper = mean(prLabour_`i'), by(tmp_retper rich2)
egen sd_prLabour_`i'_retnat = sd(prLabour_`i'), by(tmp_retnat rich2)
egen sd_prLabour_`i'_retper = sd(prLabour_`i'), by(tmp_retper rich2)
egen count_retnat_`i' = total(tmp_one) , by(tmp_retnat rich2)
egen count_retper_`i' = total(tmp_one) , by(tmp_retper rich2)
drop tmp*
}


keep rich2 retnat* retper* *_prLabour_* count_*
drop if rich2==.
order rich2 *_1* *_2* *_3* *_4* *_5* *_6*
drop retnat_1 retper_1
duplicates drop

gen retEcon = .
replace retEcon = 1 if  _n==1
replace retEcon = 2 if  _n==2
replace retEcon = 3 if  _n==3
replace retEcon = 1 if  _n==4
replace retEcon = 2 if  _n==5
replace retEcon = 3 if  _n==6
gen rich = 0 if _n<4
replace rich = 1 if _n<7 & rich==.

forvalues i=2(1)5 {
foreach y in mean_prLabour_`i'_retnat sd_prLabour_`i'_retnat count_retnat_`i'  {
gen `y'_max=.
forvalues j=1(1)6 {
egen tmp = max(`y') if retnat_`i'==retEcon[`j'] & rich2==rich[`j']
sum tmp
replace `y'_max = r(mean) if _n==`j'
drop tmp
}
}
foreach y in  mean_prLabour_`i'_retper  sd_prLabour_`i'_retper  count_retper_`i' {
gen `y'_max=.
forvalues j=1(1)6 {
egen tmp = max(`y') if retper_`i'==retEcon[`j'] & rich2==rich[`j']
sum tmp
replace `y'_max = r(mean) if _n==`j'
drop tmp
}
}
}
keep *_max retEcon rich
duplicates drop
drop if _n>6

label define rich2 0 "Poor" 1 "Rich" 

label values rich rich2
drop if retEcon==2
label define econ2 3 "Worse" 1 "Better" 
label values retEcon econ2

forvalues i=2(1)5 {
rename (mean_prLabour_`i'_retnat_max sd_prLabour_`i'_retnat_max count_retnat_`i'_max mean_prLabour_`i'_retper_max  sd_prLabour_`i'_retper_max  count_retper_`i'_max) /*
*/ (mean_prLabour_retnat_`i' sd_prLabour_retnat_`i' count_retnat_`i' mean_prLabour_retper_`i'  sd_prLabour_retper_`i'  count_retper_`i')
}

reshape long mean_prLabour_retnat_ sd_prLabour_retnat_ count_retnat_ mean_prLabour_retper_  sd_prLabour_retper_ count_retper_, i(rich retEcon) j(wave)

// Figure 9-1: Retrospective National Evaluation
gen se_retnat = sd_prLabour_retnat/sqrt(count_retnat_)
gen hi_retnat = mean_prLabour_retnat + 1.96*se_retnat
gen lo_retnat = mean_prLabour_retnat - 1.96*se_retnat

graph twoway (bar mean_prLabour_retnat wave, by( retEcon rich, note("") legend(off))) /*
*/ || rcap hi_retnat  lo_retnat wave, scheme(lean2) ylabel(0(.2)1) xlabel(2 "Apr'09" 3 "Sep'09" 4 "Jan'10" 5 "Apr'10") ytitle("Pr of voting Labour") xtitle("Wave")

graph export "graphs/final/figure_9-1_prLabourRetNat.png", replace
graph export "graphs/final/figure_9-1_prLabourRetNat.pdf", replace

// Figure 9-2: Retrospective Personal Evaluations
gen se_retper = sd_prLabour_retper/sqrt(count_retper_)
gen hi_retper = mean_prLabour_retper + 1.96*se_retper
gen lo_retper = mean_prLabour_retper - 1.96*se_retper


graph twoway (bar mean_prLabour_retper wave, by( retEcon rich, note("") legend(off))) /*
*/ || rcap hi_retper  lo_retper wave, scheme(lean2) ylabel(0(.2)1) xlabel(2 "Apr'09" 3 "Sep'09" 4 "Jan'10" 5 "Apr'10") ytitle("Pr of voting Labour") xtitle("Wave")
graph export "graphs/final/figure_9-2_prLabourRetPer.png", replace
graph export "graphs/final/figure_9-2_prLabourRetPer.pdf", replace 

/*
 Figure 10: Average Probability of voting for PM party Germany (CDU)
*/


use "deccap_temp.dta", clear

forvalues i=1(1)3 {
gen tmp_pers = perProb`i' 
gen tmp_retnat = retnat_`i' 
gen tmp_retper = retper_`i' 
gen tmp_demsat = demsat_`i'

quietly: mlogit vote_`i' tmp_* LR_Self_1 educ_quart  union age if rich2==0 , b(2)
predict pr_p_cdu, outcome(2) 
est store fR_P_`i'
quietly: mlogit vote_`i' tmp_* LR_Self_1 educ_quart  union age if rich2==1  , b(2)
predict pr_r_cdu, outcome(2)  
est store fR_R_`i'

gen prCDU_`i' = .
replace prCDU_`i' = pr_p_cdu if rich2==0
replace prCDU_`i' = pr_r_cdu if rich2==1

gen tmp_one = 1
recode tmp_retnat tmp_retper (1/2=1) (3=2) (4/5=3)

egen mean_prCDU_retnat_`i' = mean(prCDU_`i'), by(tmp_retnat rich2)
egen mean_prCDU_retper_`i' = mean(prCDU_`i'), by(tmp_retper rich2)
egen sd_prCDU_retnat_`i' = sd(prCDU_`i'), by(tmp_retnat rich2)
egen sd_prCDU_retper_`i' = sd(prCDU_`i'), by(tmp_retper rich2)

egen count_retnat_`i' = total(tmp_one) , by(tmp_retnat rich2)
egen count_retper_`i' = total(tmp_one) , by(tmp_retper rich2)

drop tmp_* pr_p_* pr_r_*
}

keep rich2 retnat* retper* *_prCDU_* count_*
drop if rich2==.
order rich2 *_1* *_2* *_3* *_4*
duplicates drop

gen retEcon = .
replace retEcon = 1 if  _n==1
replace retEcon = 2 if  _n==2
replace retEcon = 3 if  _n==3
replace retEcon = 1 if  _n==4
replace retEcon = 2 if  _n==5
replace retEcon = 3 if  _n==6
gen rich = 0 if _n<4
replace rich = 1 if _n<7 & rich==.

forvalues i=1(1)3 {
foreach y in mean_prCDU_retnat_`i' sd_prCDU_retnat_`i' count_retnat_`i'  {
gen `y'_max=.
forvalues j=1(1)6 {
egen tmp = max(`y') if retnat_`i'==retEcon[`j'] & rich2==rich[`j']
sum tmp
replace `y'_max = r(mean) if _n==`j'
drop tmp
}
}
foreach y in  mean_prCDU_retper_`i'  sd_prCDU_retper_`i'  count_retper_`i' {
gen `y'_max=.
forvalues j=1(1)6 {
egen tmp = max(`y') if retper_`i'==retEcon[`j'] & rich2==rich[`j']
sum tmp
replace `y'_max = r(mean) if _n==`j'
drop tmp
}
}
}
keep *_max retEcon rich
duplicates drop
drop if _n>6

label define rich2 0 "Poor" 1 "Rich" 
label values rich rich2
drop if retEcon==2
label define econ2 3 "Worse" 1 "Better" 
label values retEcon econ2

forvalues i=1(1)3 {
rename (mean_prCDU_retnat_`i'_max sd_prCDU_retnat_`i'_max count_retnat_`i'_max mean_prCDU_retper_`i'_max  sd_prCDU_retper_`i'_max  count_retper_`i'_max) /*
*/ (mean_prCDU_retnat_`i' sd_prCDU_retnat_`i' count_retnat_`i' mean_prCDU_retper_`i'  sd_prCDU_retper_`i'  count_retper_`i')
}

reshape long mean_prCDU_retnat_ sd_prCDU_retnat_ count_retnat_ mean_prCDU_retper_  sd_prCDU_retper_ count_retper_, i(rich retEcon) j(wave)

// Figure 10-1: Retrospective National Evaluation
gen se_retnat = sd_prCDU_retnat/sqrt(count_retnat_)
gen hi_retnat = mean_prCDU_retnat + 1.96*se_retnat
gen lo_retnat = mean_prCDU_retnat - 1.96*se_retnat

graph twoway (bar mean_prCDU_retnat wave, by( retEcon rich, note("") legend(off))) || /*
*/ rcap hi_retnat  lo_retnat wave, scheme(lean2) ylabel(0(.2)1) xlabel(1 "Jun'09" 2 "Aug'09" 3 "Sep'09") ytitle("Pr of voting CDU") xtitle("Wave")

graph export "graphs/final/figure_10-1_prCDURetNat.png", replace
graph export "graphs/final/figure_10-1_prCDURetNat.pdf", replace


// Figure 10-2: Retrospective Personal Evaluations

gen se_retper = sd_prCDU_retper/sqrt(count_retper_)
gen hi_retper = mean_prCDU_retper + 1.96*se_retper
gen lo_retper = mean_prCDU_retper - 1.96*se_retper

graph twoway (bar mean_prCDU_retper wave, by( retEcon rich, note("") legend(off))) || /*
*/ rcap hi_retper  lo_retper wave, scheme(lean2) ylabel(0(.2)1) xlabel(1 "Jun'09" 2 "Aug'09" 3 "Sep'09") ytitle("Pr of voting CDU") xtitle("Wave")

graph export "graphs/final/figure_10-2_prCDURetPer.png", replace
graph export "graphs/final/figure_10-2_prCDURetPer.pdf", replace




******************** APPENDIX



/*
Figure 1: Distribution of Objective Personal Economy Scores by Components: DeCCAP
*/

clear
set maxvar 10000
use "deccap_temp.dta", clear

// 1.A

hist perProb2, by(affected_1, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. Personally Affected") scheme(lean2)
graph export "graphs/final/appendixFig_1_objEconVSaffected_DE.png",  replace
graph export "graphs/final/appendixFig_1_objEconVSaffected_DE.pdf",  replace

// 1.B

gen bigX_1 = bigItems_1
recode bigX_1 (-1=1) (0=.) (1=0)
label define bigX  1 "Bad Time" 0 "Good Time" 
label values bigX_1 bigX

hist perProb2, by(bigX_1, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. Time to Purchase Big Items") scheme(lean2)
graph export "graphs/final/appendixFig_1b_objEconVSbigItems_DE.png", replace
graph export "graphs/final/appendixFig_1b_objEconVSbigItems_DE.pdf", replace

// 1.C

gen changesX_1 = changes_1
recode changesX_1 (0/3=0) (4/8=1)
label define changesX  0 "Less than 4" 1 "4 or more" 
label values changesX_1 changesX

hist perProb2, by(changesX_1, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. # of Changes Made") scheme(lean2)
graph export "graphs/final/appendixFig_1c_objEconVSchanges_DE.png",  replace
graph export "graphs/final/appendixFig_1c_objEconVSchanges_DE.pdf",  replace

// 1.D

hist perProb2, by(loans_1, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. Ability to get Loans") scheme(lean2)
graph export "graphs/final/appendixFig_1_objEconVSloans_DE.png",  replace
graph export "graphs/final/appendixFig_1_objEconVSloans_DE.pdf",  replace

// 1.E

gen oilPricesX_1 = oilPrices_1
recode oilPricesX_1 (1/2=1) (3=.) (4/5=0)
label define oilX  0 "Lower Prices" 1 "Higher Prices" 
label values oilPricesX_1 oilX

hist perProb2, by(oilPricesX_1, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. Energy Prices") scheme(lean2)
graph export "graphs/final/appendixFig_1_objEconVSoil_DE.png", replace
graph export "graphs/final/appendixFig_1_objEconVSoil_DE.pdf", replace

// 1.F
hist perProb2, by(payingHouse_1, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. Difficulty in Paying House") scheme(lean2)
graph export "graphs/final/appendixFig_1f_objEconVSpayingHouse_DE.png",  replace
graph export "graphs/final/appendixFig_1f_objEconVSpayingHouse_DE.pdf",  replace


/*
 Figure 2: Distribution of Objective Personal Economy Scores by Components: BCCAP
*/

clear
set maxvar 10000
use "bccap_temp.dta", clear

// 2.A

hist perProb2, by(affected_2, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. Personally Affected") scheme(lean2)
graph export "graphs/final/appendixFig_2a_objEconVSaffected_UK.png",  replace
graph export "graphs/final/appendixFig_2a_objEconVSaffected_UK.pdf",  replace

// 2.B

gen bigX_2 = bigItems_2
recode bigX_2 (-1=1) (0=.) (1=0)
label define bigX  1 "Bad Time" 0 "Good Time" 
label values bigX_2 bigX

hist perProb2, by(bigX_2, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. Time to Purchase Big Items") scheme(lean2)
graph export "graphs/final/appendixFig_2b_objEconVSbigItems_UK.png", replace
graph export "graphs/final/appendixFig_2b_objEconVSbigItems_UK.pdf", replace

// 2.C

gen changesX_2 = changes_2
recode changesX_2 (0/3=0) (4/8=1)
label define changesX  0 "Less than 4" 1 "4 or more" 
label values changesX_2 changesX

hist perProb2, by(changesX_2, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. # of Changes Made") scheme(lean2)
graph export "graphs/final/appendixFig_2c_objEconVSchanges_UK.png", replace
graph export "graphs/final/appendixFig_2c_objEconVSchanges_UK.pdf", replace

// 2.D

hist perProb2, by(loans_2, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. Ability to get Loans") scheme(lean2)
graph export "graphs/final/appendixFig_2d_objEconVSloans_UK.png", replace
graph export "graphs/final/appendixFig_2d_objEconVSloans_UK.pdf", replace

gen oilPricesX_2 = oilPrices_2
recode oilPricesX_2 (1/2=1) (3=.) (4/5=0)
label define oilX  0 "Lower Prices" 1 "Higher Prices" 
label values oilPricesX_2 oilX

// 2.E 

hist perProb2, by(oilPricesX_2, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. Energy Prices") scheme(lean2)
graph export "graphs/final/appendixFig_2e_objEconVSoil_UK.png", replace
graph export "graphs/final/appendixFig_2e_objEconVSoil_UK.pdf", replace

// 2.F

hist perProb2, by(payingHouse_2, legend(off) note("") cols(2) colfirst)  kdensity xtitle("Objective Personal Economy vs. Difficulty in Paying House") scheme(lean2)
graph export "graphs/final/appendixFig_2f_objEconVSpayingHouse_UK.png", replace
graph export "graphs/final/appendixFig_2f_objEconVSpayingHouse_UK.pdf", replace

