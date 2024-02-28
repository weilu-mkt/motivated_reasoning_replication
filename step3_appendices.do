clear
pwd
use "main_data.dta"

*************** Year and Experience ***************
gen age = year-birthyear
gen exp = year-ayear
replace exp = . if exp<0
replace age = . if age<30 | age>100
gen agecohort = .
replace agecohort = 1 if age >= 35 & age < 40
replace agecohort = 2 if age >= 40 & age < 45
replace agecohort = 3 if age >= 45 & age < 50
replace agecohort = 4 if age >= 50 & age < 55
replace agecohort = 5 if age >= 55 & age < 60
replace agecohort = 6 if age >= 60 & age < 65
replace agecohort = 7 if age >= 65 & age < 70
replace agecohort = 8 if age >= 70 & age < 75
replace agecohort = 9 if age >= 75 & age < 80
replace agecohort = 10 if age >= 80 & age < 85
replace agecohort = 11 if age >= 85 & age < 90
replace agecohort = 12 if age >= 90 & age < 95
replace agecohort = 13 if age >= 95 & age < 100
drop if agecohort ==.

gen expcohort = .
replace expcohort = 1 if exp >= 0 & exp < 5
replace expcohort = 2 if exp >= 5 & exp < 10
replace expcohort = 3 if exp >= 10 & exp < 15
replace expcohort = 4 if exp >= 15 & exp < 20
replace expcohort = 5 if exp >= 20 & exp < 25
replace expcohort = 6 if exp >= 25 & exp < 30
replace expcohort = 7 if exp >= 30 & exp < 35
replace expcohort = 8 if exp >= 35 //& exp < 40
// replace expcohort = 9 if exp >= 40 & exp < 45
// replace expcohort = 10 if exp >= 45 & exp < 50
// replace expcohort = 11 if exp >= 50 & exp < 55
drop if expcohort ==.

label define ageranks 1 "Age $\in [35,40)$" 2 "Age $\in [40,45)$" 3 "Age $\in [45,50)$" 4 "Age $\in [50,55)$" 5 "Age $\in [55,60)$" 6 "Age $\in [60,65)$" 7 "Age $\in [65,70)$" 8 "Age $\in [70,75)$" 9 "Age $\in [75,80)$" 10 "Age $\in [80,85)$" 11 "Age $\in [85,90)$" 12 "Age $\in [90,95)$" 13 "Age $\in [95,100)$"
label define expranks 1 "Experience $\in [0,5)$" 2 "Experience $\in [5,10)$" 3 "Experience $\in [10,15)$" 4 "Experience $\in [15,20)$" 5 "Experience $\in [20,25)$" 6 "Experience $\in [25,30)$" 7 "Experience $\in [30,35)$" 8 "Experience $\in [35,55)$" //9 "Experience $\in [40,45)$" 10 "Experience $\in [45,50)$" 11 "Experience $\in [50,55)$" 
label values agecohort ageranks
label values expcohort expranks
label variable age "Age"
label variable exp "Experience"

// eststo clear
// eststo: reghdfe acc_text exp b1.agecohort, a(i.circuityear i.geniss1) vce(cluster id) noconst
// eststo: reghdfe acc_citation exp b1.agecohort, a(i.circuityear i.geniss1) vce(cluster id) noconst
// // eststo: reghdfe dissentvote b1.agecohort, a(i.circuityear i.geniss1) vce(cluster id) noconst
// esttab using tables1.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace
eststo clear
eststo: reghdfe acc_text age b1.expcohort, a(i.circuityear i.geniss1) vce(cluster id) noconst
eststo: reghdfe acc_citation age b1.expcohort, a(i.circuityear i.geniss1) vce(cluster id) noconst
// eststo: reghdfe dissentvote b1.expcohort, a(i.circuityear i.geniss1) vce(cluster id) noconst
esttab using tables2.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

// eststo clear
// eststo: reghdfe acc_text b1.agecohort b1.expcohort, a(i.circuityear i.geniss1) vce(cluster id) noconst
// eststo: reghdfe acc_citation b1.agecohort b1.expcohort, a(i.circuityear i.geniss1) vce(cluster id) noconst
// // eststo: reghdfe dissentvote b1.expcohort, a(i.circuityear i.geniss1) vce(cluster id) noconst
// esttab using tables3.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

// reghdfe acc_citation b1.agecohort, a(i.circuityear i.geniss1) vce(cluster id) noconst
// coefplot, ci(95) vertical xline(8, lpattern(dash) lcolor(red))  xline(15.2, lpattern(dash) lcolor(red)) yline(0, lpattern(dash) lcolor(gray)) xtitle("Age") ytitle("Polarization in Texts") xlabel(1 "15" 2 "14" 3 "13" 4 "12" 5 "11" 6 "10" 7 "9" 8 "8" 9 "7" 10 "6" 11 "5" 12 "4" 13 "3" 14 "2" 15 "1")
// graph export "fig2_qte_text.png", as(png) name("Graph") replace


*************** Dissent cycle ***************
reghdfe acc_text b1.decade, a(i.Circuit i.geniss1) vce(cluster id) noconst
coefplot, ci(95) vertical yline(0, lpattern(dash) lcolor(gray)) xtitle("Decade") ytitle("Polarization in Texts") xlabel(1 "1900" 2 "1910" 3 "1920" 4 "1930" 5 "1940" 6 "1950" 7 "1960" 8 "1970" 9 "1980" 10 "1990" 11 "2000" 12 "2010")
graph export "figs1_text.png", as(png) name("Graph") replace
reghdfe acc_citation b1.decade, a(i.Circuit i.geniss1) vce(cluster id) noconst
coefplot, ci(95) vertical yline(0, lpattern(dash) lcolor(gray)) xtitle("Decade") ytitle("Polarization in Citations") xlabel(1 "1900" 2 "1910" 3 "1920" 4 "1930" 5 "1940" 6 "1950" 7 "1960" 8 "1970" 9 "1980" 10 "1990" 11 "2000" 12 "2010")
graph export "figs1_citation.png", as(png) name("Graph") replace
reghdfe dissentvote b1.decade, a(i.Circuit i.geniss1) vce(cluster id) noconst
coefplot, ci(95) vertical yline(0, lpattern(dash) lcolor(gray)) xtitle("Decade") ytitle("Dissent Rate")  xlabel(1 "1900" 2 "1910" 3 "1920" 4 "1930" 5 "1940" 6 "1950" 7 "1960" 8 "1970" 9 "1980" 10 "1990" 11 "2000" 12 "2010")
graph export "figs1_vote.png", as(png) name("Graph") replace

eststo clear
eststo: reghdfe acc_text c.Divided##c.year, a(i.circuityear i.geniss1) vce(cluster id) noconst
eststo: reghdfe acc_citation c.Divided##c.year, a(i.circuityear i.geniss1) vce(cluster id) noconst
eststo: reghdfe dissentvote c.Divided##c.year, a(i.circuityear i.geniss1) vce(cluster id) noconst
esttab using tables4.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

eststo clear
eststo: reghdfe acc_text c.minority##c.year if Divided==1, a(i.circuityear i.geniss1) vce(cluster id) noconst
eststo: reghdfe acc_citation c.minority##c.year if Divided==1, a(i.circuityear i.geniss1) vce(cluster id) noconst
eststo: reghdfe dissentvote c.minority##c.year if Divided==1, a(i.circuityear i.geniss1) vce(cluster id) noconst
esttab using tables5.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

*************** By topic ***************
eststo clear
eststo: reghdfe acc_text c.Divided if geniss1 ==1, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_text c.Divided if geniss1 ==2, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_text c.Divided if geniss1 ==3, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_text c.Divided if geniss1 ==4, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_text c.Divided if geniss1 ==5, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_text c.Divided if geniss1 ==6, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_text c.Divided if geniss1 ==7, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_text c.Divided if geniss1 ==9, a(i.circuityear) vce(cluster id) noconst
esttab using tables6.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

eststo clear
eststo: reghdfe acc_citation c.Divided if geniss1 ==1, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_citation c.Divided if geniss1 ==2, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_citation c.Divided if geniss1 ==3, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_citation c.Divided if geniss1 ==4, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_citation c.Divided if geniss1 ==5, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_citation c.Divided if geniss1 ==6, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_citation c.Divided if geniss1 ==7, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe acc_citation c.Divided if geniss1 ==9, a(i.circuityear) vce(cluster id) noconst
esttab using tables7.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

eststo clear
eststo: reghdfe dissentvote c.Divided if geniss1 ==1, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe dissentvote c.Divided if geniss1 ==2, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe dissentvote c.Divided if geniss1 ==3, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe dissentvote c.Divided if geniss1 ==4, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe dissentvote c.Divided if geniss1 ==5, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe dissentvote c.Divided if geniss1 ==6, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe dissentvote c.Divided if geniss1 ==7, a(i.circuityear) vce(cluster id) noconst
eststo: reghdfe dissentvote c.Divided if geniss1 ==9, a(i.circuityear) vce(cluster id) noconst
esttab using tables8.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

eststo clear
eststo: reghdfe acc_text b16.quartertoelect if year>=1975 & geniss1 ==1, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_text b16.quartertoelect if year>=1975 & geniss1 ==2, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_text b16.quartertoelect if year>=1975 & geniss1 ==3, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_text b16.quartertoelect if year>=1975 & geniss1 ==4, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_text b16.quartertoelect if year>=1975 & geniss1 ==5, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_text b16.quartertoelect if year>=1975 & geniss1 ==6, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_text b16.quartertoelect if year>=1975 & geniss1 ==7, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_text b16.quartertoelect if year>=1975 & geniss1 ==9, a(i.circuityear i.season) vce(cluster id) noconst
esttab using tables9.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

eststo clear
eststo: reghdfe acc_citation b16.quartertoelect if year>=1975 & geniss1 ==1, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_citation b16.quartertoelect if year>=1975 & geniss1 ==2, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_citation b16.quartertoelect if year>=1975 & geniss1 ==3, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_citation b16.quartertoelect if year>=1975 & geniss1 ==4, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_citation b16.quartertoelect if year>=1975 & geniss1 ==5, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_citation b16.quartertoelect if year>=1975 & geniss1 ==6, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_citation b16.quartertoelect if year>=1975 & geniss1 ==7, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe acc_citation b16.quartertoelect if year>=1975 & geniss1 ==9, a(i.circuityear i.season) vce(cluster id) noconst
esttab using tables10.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

eststo clear
eststo: reghdfe dissentvote b16.quartertoelect if year>=1975 & geniss1 ==1, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe dissentvote b16.quartertoelect if year>=1975 & geniss1 ==2, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe dissentvote b16.quartertoelect if year>=1975 & geniss1 ==3, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe dissentvote b16.quartertoelect if year>=1975 & geniss1 ==4, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe dissentvote b16.quartertoelect if year>=1975 & geniss1 ==5, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe dissentvote b16.quartertoelect if year>=1975 & geniss1 ==6, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe dissentvote b16.quartertoelect if year>=1975 & geniss1 ==7, a(i.circuityear i.season) vce(cluster id) noconst
eststo: reghdfe dissentvote b16.quartertoelect if year>=1975 & geniss1 ==9, a(i.circuityear i.season) vce(cluster id) noconst
esttab using tables11.tex, label b(3) se(3) r2(3) nogaps star(* 0.1 ** 0.05 *** 0.01) replace