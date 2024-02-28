clear
pwd
use "main_data.dta"

collapse (mean) meanacct= acc_text meanacctrdm= acc_text_rdm meanaccc= acc_citation meanacccrdm= acc_citation_rdm (sd) sdacct=acc_text sdacctrdm=acc_text_rdm sdaccc=acc_citation sdacccrdm=acc_citation_rdm (count) n1=acc_text n2 = acc_text_rdm n3 = acc_citation n4 = acc_citation_rdm, by(decade)
generate loacct = meanacct - invttail(n1-1,0.005)*(sdacct / sqrt(n1))
generate hiacct = meanacct + invttail(n1-1,0.005)*(sdacct / sqrt(n1))
generate loacctrdm = meanacctrdm - invttail(n2-1,0.005)*(sdacctrdm / sqrt(n2))
generate hiacctrdm = meanacctrdm + invttail(n2-1,0.005)*(sdacctrdm / sqrt(n2))
generate loaccc = meanaccc - invttail(n3-1,0.005)*(sdaccc / sqrt(n3))
generate hiaccc = meanaccc + invttail(n3-1,0.005)*(sdaccc / sqrt(n3))
generate loacccrdm = meanacccrdm - invttail(n4-1,0.005)*(sdacccrdm / sqrt(n4))
generate hiacccrdm = meanacccrdm + invttail(n4-1,0.005)*(sdacccrdm / sqrt(n4))

twoway connected meanacct decade, mc(navy) lc(navy) ||connected meanacctrdm decade, mc(maroon) lc(maroon) || rcap hiacct loacct decade, lc(navy) || rcap hiacctrdm loacctrdm decade, lc(maroon)  xtitle("Decades") ytitle("Polarization in Prose") xlabel(1 "1890" 2 "1900" 3 "1910" 4 "1920" 5 "1930" 6 "1940" 7 "1950" 8 "1960" 9 "1970" 10 "1980" 11 "1990" 12 "2000" 13 "2010") legend(order(1 "Real" 2 "Random")) yscale(r(0.5 0.8)) ylabel(0.5(0.05)0.8) //yline(0.5, lpattern(dash) lcolor(red))
graph export  "fig1_text.png", replace

twoway connected meanaccc decade, mc(navy) lc(navy) ||connected meanacccrdm decade, mc(maroon) lc(maroon) || rcap hiaccc loaccc decade, lc(navy) || rcap hiacccrdm loacccrdm decade, lc(maroon) xtitle("Decades") ytitle("Polarization in Precedent") xlabel(1 "1890" 2 "1900" 3 "1910" 4 "1920" 5 "1930" 6 "1940" 7 "1950" 8 "1960" 9 "1970" 10 "1980" 11 "1990" 12 "2000" 13 "2010") legend(order(1 "Real" 2 "Random"))yscale(r(0.5 0.6)) ylabel(0.5(0.02)0.6)
graph export  "fig1_citation.png", replace

clear
use "main_data.dta"

collapse (mean) meanacct= acc_text meanaccc= acc_citation (sd) sdacct=acc_text sdaccc=acc_citation (count) n1=acc_text n3 = acc_citation , by(decade party_true)
generate loacct = meanacct - invttail(n1-1,0.025)*(sdacct / sqrt(n1))
generate hiacct = meanacct + invttail(n1-1,0.025)*(sdacct / sqrt(n1))
generate loaccc = meanaccc - invttail(n3-1,0.025)*(sdaccc / sqrt(n3))
generate hiaccc = meanaccc + invttail(n3-1,0.025)*(sdaccc / sqrt(n3))

twoway connected meanacct decade if party_true ==1, mc(navy) lc(navy) ||connected meanacct decade if party_true==0, mc(maroon) lc(maroon) || rcap hiacct loacct decade if party_true==1, lc(navy) || rcap hiacct loacct decade if party_true==0, lc(maroon) yline(0.5, lpattern(dash) lcolor(red)) xtitle("Decades") ytitle("Polarization in Prose") xlabel(1 "1890" 2 "1900" 3 "1910" 4 "1920" 5 "1930" 6 "1940" 7 "1950" 8 "1960" 9 "1970" 10 "1980" 11 "1990" 12 "2000" 13 "2010") legend(order(1 "Democrat" 2 "Republican")) yscale(r(0.3 0.8)) ylabel(0.3(0.05)0.8)
graph export  "fig1_text_party.png", replace

twoway connected meanaccc decade if party_true ==1, mc(navy) lc(navy) ||connected meanaccc decade if party_true==0, mc(maroon) lc(maroon) || rcap hiaccc loaccc decade if party_true==1, lc(navy) || rcap hiaccc loaccc decade if party_true==0, lc(maroon) yline(0.5, lpattern(dash) lcolor(red)) xtitle("Decades") ytitle("Polarization in Precedents") xlabel(1 "1890" 2 "1900" 3 "1910" 4 "1920" 5 "1930" 6 "1940" 7 "1950" 8 "1960" 9 "1970" 10 "1980" 11 "1990" 12 "2000" 13 "2010") legend(order(1 "Democrat" 2 "Republican"))  yscale(r(0.3 0.8)) ylabel(0.3(0.05)0.8)
graph export  "fig1_citation_party.png", replace

clear
use "main_data.dta"
gen optype = 0
replace optype =1 if majop==1
replace optype=2 if disop ==1

collapse (mean) meanacct= acc_text meanaccc= acc_citation (sd) sdacct=acc_text sdaccc=acc_citation (count) n1=acc_text n3 = acc_citation , by(decade optype)
generate loacct = meanacct - invttail(n1-1,0.025)*(sdacct / sqrt(n1))
generate hiacct = meanacct + invttail(n1-1,0.025)*(sdacct / sqrt(n1))
generate loaccc = meanaccc - invttail(n3-1,0.025)*(sdaccc / sqrt(n3))
generate hiaccc = meanaccc + invttail(n3-1,0.025)*(sdaccc / sqrt(n3))

twoway connected meanacct decade if optype==1, mc(navy) lc(navy) ||connected meanacct decade if optype==2, mc(maroon) lc(maroon) || rcap hiacct loacct decade if optype==1, lc(navy) || rcap hiacct loacct decade if optype==2, lc(maroon) yline(0.5, lpattern(dash) lcolor(red)) xtitle("Decades") ytitle("Polarization in Prose") xlabel(1 "1890" 2 "1900" 3 "1910" 4 "1920" 5 "1930" 6 "1940" 7 "1950" 8 "1960" 9 "1970" 10 "1980" 11 "1990" 12 "2000" 13 "2010") legend(order(1 "Majority Opinions" 2 "Dissent Opinions")) yscale(r(0.3 0.8)) ylabel(0.3(0.05)0.8)
graph export  "fig1_text_optype.png", replace

twoway connected meanaccc decade if optype==1, mc(navy) lc(navy) ||connected meanaccc decade if optype==2, mc(maroon) lc(maroon) || rcap hiaccc loaccc decade if optype==1, lc(navy) || rcap hiaccc loaccc decade if optype==2, lc(maroon) yline(0.5, lpattern(dash) lcolor(red)) xtitle("Decades") ytitle("Polarization in Prose") xlabel(1 "1890" 2 "1900" 3 "1910" 4 "1920" 5 "1930" 6 "1940" 7 "1950" 8 "1960" 9 "1970" 10 "1980" 11 "1990" 12 "2000" 13 "2010") legend(order(1 "Majority Opinions" 2 "Dissent Opinions")) yscale(r(0.3 0.8)) ylabel(0.3(0.05)0.8)
graph export  "fig1_citation_optype.png", replace
