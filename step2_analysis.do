clear
pwd
use "main_data.dta"

********* Scrutiny *********
eststo clear
eststo: reghdfe acc_text c.Divided, a(i.circuityear i.geniss1) vce(cluster id) noconst
eststo: reghdfe acc_citation c.Divided, a(i.circuityear i.geniss1) vce(cluster id) noconst
eststo: reghdfe dissentvote c.Divided, a(i.circuityear i.geniss1) vce(cluster id) noconst
esttab using table1.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

eststo clear
eststo: reghdfe acc_text c.minority if Divided==1, a(i.circuityear i.geniss1) vce(cluster id) noconst
eststo: reghdfe acc_citation c.minority if Divided==1, a(i.circuityear i.geniss1) vce(cluster id) noconst
eststo: reghdfe dissentvote c.minority if Divided==1, a(i.circuityear i.geniss1) vce(cluster id) noconst
esttab using table2.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace


********* Electoral Cycles *********
eststo clear
eststo: reghdfe acc_text b16.quartertoelect if year>=1975, a(i.circuityear i.season i.geniss1) vce(cluster id) noconst
eststo: reghdfe acc_text b16.quartertoelect if year>=1975 & disop==1, a(i.circuityear i.season i.geniss1) vce(cluster id) noconst
eststo: reghdfe acc_citation b16.quartertoelect if year>=1975, a(i.circuityear i.season i.geniss1) vce(cluster id) noconst
eststo: reghdfe acc_citation b16.quartertoelect if year>=1975 & disop==1, a(i.circuityear i.season i.geniss1) vce(cluster id) noconst
eststo: reghdfe dissentvote b16.quartertoelect if year>=1975, a(i.circuityear i.season i.geniss1) vce(cluster id) noconst
esttab using table3.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace


********* SCOTUS Vacancy *********
clear
pwd
use "vacancy_data.dta"
eststo clear
eststo: reghdfe acc_text c.vacancy##c.contenders, a(i.circuityear i.geniss1) vce(cluster id) noconst
eststo: reghdfe acc_citation c.vacancy##c.contenders, a(i.circuityear i.geniss1) vce(cluster id) noconst
eststo: reghdfe dissentvote c.vacancy##c.contenders, a(i.circuityear i.geniss1) vce(cluster id) noconst
esttab using table4.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace
