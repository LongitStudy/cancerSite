/*	SYNTAX TO CREATE CANCER SITE VARIABLES
	Date: 01/03/2022
	USO: Aly	

IT IS BEST IF YOU RUN THIS SYNTAX ON CANC FILE ONLY AND THEN MERGE IT WITH YOUR 
OTHER DATA FILES.

You need to ensure that you have the following variables from the CANC file:	
	*	eventord
	*	iccs3bcc and iccsxbcc (ICD8 site and subsite valid 1971 - 31/12/1978)
	*	sidc3cc sicd1cc (ICD9 site and subsite  valid 01/01/1979 - 31/12/1994)
	*	sicd30cc sicd10cc (ICD10 site and subsite  valid 01/01/1995 onwards)
*******************************************************************************/

*Set your working directory so that your file is saved in your project area
cd " "

*Generate a variable that indicates an LS member has had a cancer diagnosis
gen cancer=1 
lab var cancer "Has cancer diagnosis y/n"
label define yesno 0 "No" 1 "Yes"
lab val cancer yesno

*LSM can have >1 diagnosis therefore generate a variable that indicates the first cancer diagnosis
generate firstcancer = 1 if eventord==1 & cancer==1

*Rename the cancer site variables
gen icd8site = iccs3bcc
gen icd9site = sidc3cc
gen icd10site = sicd30cc

/* Code to derive 20 cancer site variables and one variable for other sites:
	lung + trachea and bronchus (icd8/9 = 162; icd10 = c33, c34)
	prostate (icd8/9 = 185; icd10 = c61)
	colorectal [incl. anus ] (icd8/9 = 153, 154; icd10 = c18, c19, c20, c21)
	kidney (icd8/9 = 189; icd10 = c64)
	bladder (icd8/9 = 188; icd10 = c67)
	stomach (icd8/9 = 151; icd10 = c16)
	nonhodgkin (icd8/9 = 200, 202; icd10 = c82, c83, c84 c85 c86)
	melanomaskin [not other malignant neoplasms of skin] (icd8/9 = 172; icd10 = c43)
	pancreatic (icd8/9 = 157; icd10 = c25)
	leukaemia (icd8/9 = 204, 205, 206, 207, 208; icd10 = c91, c92, c93, c94, c95)
	oesophageal (icd8/9 = 150; icd10 = c15)
	oral [includes lips, gums, palate, tongue, pharynx, NOT salivary glands]
		(icd8/9 = 140 - 149; icd10 = c00 - c14)
	brain + spinal cord, cranial nerves and other CNS  (icd8/9 = 191; icd10 = c71)
	myeloma (icd8/9 = 203; icd10 = c90)
	liver (icd8/9 = 155; icd10 = c22)
	thyroid (icd8/9 = 193; icd10 = c73)
	breast (icd8/9 = 174, 175; icd10 = c50)
	uterine (icd8/9 = 179, 182; icd10 = c54, c55)
	ovary (icd8/9 = 183; icd10 = c56 c57)
	cervix (icd8/9 = 180; icd10 = c53)
NB: does not include benign neoplasms, carcinoma and neoplasms of uncertain / unknown
behaviour (icd8/9 209-239 and 630 [hydatidiform mole; icd10 = codes starting with D) 	
For all above:	0 = do not have cancer in specified site; 
				1 = cancer in malignant neoplasm in specified site.
*******************************************************************************/

*LUNG CANCER (icd8/9 = 162; icd10 = c33, c34)
gen byte lungc = 0
replace lungc = 1 if icd8site == "162"
tab icd8site lungc
replace lungc = 1 if icd9site == "162"
tab icd9site lungc
replace lungc = 1 if icd10site== "C33" | icd10site =="C34"
tab icd10site lungc
label var lungc "Cancer of the bronchus and lung"
tab lungc

*PROSTATE CANCER (icd8/9 = 185; icd10 = c61)
gen byte prostatec = 0
replace prostatec = 1 if icd8site == "185"
tab icd8site prostatec
replace prostatec = 1 if icd9site == "185"
tab icd9site prostatec
replace prostatec = 1 if icd10site== "C61"
tab icd10site prostatec
label var prostatec "Prostate cancer"
tab prostatec

*COLORECTAL CANCER (INCL ANUS) (icd8/9 = 153, 154; icd10 = c18, c19, c20, c21)
gen byte colorectc = 0
replace colorectc = 1 if icd8site== "153" | icd8site =="154"
tab icd8site colorectc
replace colorectc = 1 if icd9site== "153" | icd9site =="154"
tab icd9site colorectc
replace colorectc = 1 if inrange(icd10site, "C18", "C21")
tab icd10site colorectc
label var colorectc "Cancer of the colon, rectum, and anus"
tab colorectc

*KIDNEY CANCER (icd8/9 = 189; icd10 = c64)
gen byte kidneyc = 0
replace kidneyc = 1 if icd8site== "189"
tab icd8site kidneyc
replace kidneyc = 1 if icd9site== "189"
tab icd9site kidneyc
replace kidneyc = 1 if icd10site=="C64"
tab icd10site kidneyc
label var kidneyc "Kidney cancer"
tab kidneyc

*BLADDER CANCER (icd8/9 = 188; icd10 = c67)
gen byte bladderc = 0
replace bladderc = 1 if icd8site== "188"
tab icd8site bladderc
replace bladderc = 1 if icd9site== "188"
tab icd9site bladderc
replace bladderc = 1 if icd10site=="C67"
tab icd10site bladderc
label var bladderc "Bladder cancer"
tab bladderc

*STOMACH CANCER (icd8/9 = 151; icd10 = c16)
gen byte stomachc = 0
replace stomachc = 1 if icd8site== "151"
tab icd8site stomachc
replace stomachc = 1 if icd9site== "151"
tab icd9site stomachc
replace stomachc = 1 if icd10site=="C16"
tab icd10site stomachc
label var stomachc "Stomach cancer"
tab stomachc

*NON-HODGKINS LYMPHOMA (icd8/9 = 200, 202; icd10 = c82, c83, c84 c85 c86)
gen byte nonhodgkin = 0
replace nonhodgkin = 1 if icd8site== "200" | icd8site== "202"
replace nonhodgkin = 1 if icd9site== "200" | icd9site== "202"
replace nonhodgkin = 1 if inrange(icd10site,"C82", "C85")
tab icd10site nonhodgkin
label var nonhodgkin "Non-Hodgkin lymphoma"
tab nonhodgkin

*MELANOMA SKIN CANCER (icd8/9 = 172; icd10 = c43)
gen byte melanomaskinc = 0
replace melanomaskinc = 1 if icd8site== "172"
tab icd8site melanomaskinc
replace melanomaskinc = 1 if icd9site== "172"
tab icd9site melanomaskinc
replace melanomaskinc = 1 if icd10site=="C43" 
tab icd10site melanomaskinc
label var melanomaskinc "Skin cancer"
tab melanomaskinc

*PANCREATIC CANCER (icd8/9 = 157; icd10 = c25)
gen byte pancreatc = 0
replace pancreatc = 1 if icd8site== "157"
tab icd8site pancreatc
replace pancreatc = 1 if icd9site== "157"
tab icd9site pancreatc
replace pancreatc = 1 if icd10site=="C25"
tab icd10site pancreatc
label var pancreatc "Pancreatic cancer"
tab pancreatc

*LEUKAEMIA (icd8/9 = 204, 205, 206, 207, 208; icd10 = c91, c92, c93, c94, c95)
gen byte leukaemia = 0
replace leukaemia = 1 if inrange(icd8site, "204", "208")
tab icd8site leukaemia
replace leukaemia = 1 if inrange(icd9site, "204", "208")
tab icd9site leukaemia
replace leukaemia = 1 if inrange(icd10site, "C91", "C95")
tab icd10site leukaemia
label var leukaemia "Leukaemia"
tab leukaemia

*OESOPHAGEAL CANCER (icd8/9 = 150; icd10 = c15)
gen byte oesophagealc = 0
replace oesophagealc = 1 if icd8site== "150"
tab icd8site oesophagealc
replace oesophagealc = 1 if icd9site== "150"
tab icd9site oesophagealc
replace oesophagealc = 1 if icd10site=="C15"
tab icd10site oesophagealc
label var oesophagealc "Cancer of the oesophagus "
tab oesophagealc

*ORAL CANCER  (icd8/9 = 140 - 149; icd10 = c00 - c14)
gen byte oralc = 0
replace oralc = 1 if inrange(icd8site, "140", "149")
tab icd8site oralc
replace oralc = 1 if inrange(icd9site, "140", "149")
tab icd9site oralc
replace oralc = 1 if inrange(icd10site, "C00", "C14")
tab icd10site oralc
label var oralc "Oral cancer"
tab oralc

*BRAIN CANCER  (icd8/9 = 191; icd10 = c71)
gen byte brainc = 0
replace brainc = 1 if icd8site== "191"
tab icd8site brainc
replace brainc = 1 if icd9site== "191"
tab icd9site brainc
replace brainc = 1 if icd10site=="C71" 
tab icd10site brainc
label var brainc "Brain, other CNS and Intracranial tumours"
tab brainc

*MYELOMA CANCER (icd8/9 = 203; icd10 = c90)
gen byte myelomac = 0
replace myelomac = 1 if icd8site== "203"
tab icd8site myelomac
replace myelomac = 1 if icd9site== "203"
tab icd9site myelomac
replace myelomac = 1 if icd10site=="C90"
tab icd10site myelomac
label var myelomac "Myeloma"
tab myelomac

*LIVER CANCER (icd8/9 = 155; icd10 = c22)
gen byte liverc = 0
replace liverc = 1 if icd8site== "155"
tab icd8site liverc
replace liverc = 1 if icd9site== "155"
tab icd9site liverc
replace liverc = 1 if icd10site=="C22"
tab icd10site liverc
label var liverc "Liver cancer"
tab liverc

*THYROID CANCER (icd8/9 = 193; icd10 = c73)
gen byte thyroidc = 0
replace thyroidc = 1 if icd8site== "193"
tab icd8site thyroidc
replace thyroidc = 1 if icd9site== "193"
tab icd9site thyroidc
replace thyroidc = 1 if icd10site=="C73"
tab icd10site thyroidc
label var thyroidc "Thyroid cancer"
tab thyroidc

*BREAST CANCER (icd8/9 = 174, 175; icd10 = c50)
gen byte breastc = 0
replace breastc = 1 if icd8site== "174" | icd8site=="175"
tab icd8site breastc
replace breastc = 1 if icd9site== "174" | icd9site=="175"
tab icd9site breastc
replace breastc = 1 if icd10site=="C50"
tab icd10site breastc
label var breastc "Breast cancer"
tab breastc

*UTERINE CANCER (icd8/9 = 179, 182; icd10 = c54, c55)
gen byte uterinec = 0
replace uterinec = 1 if icd8site== "179" | icd8site=="182"
tab icd8site uterinec
replace uterinec = 1 if icd9site== "179" | icd9site=="182"
tab icd9site uterinec
replace uterinec = 1 if icd10site=="C54" | icd10site=="C55"
tab icd10site uterinec
label var uterinec "Uterine cancer"
tab uterinec

*OVARY CANCER (icd8/9 = 183; icd10 = c56 c57)
gen byte ovaryc = 0
replace ovaryc = 1 if icd8site== "183"
tab icd8site ovaryc
replace ovaryc = 1 if icd9site== "183"
tab icd9site ovaryc
replace ovaryc = 1 if icd10site=="C56" | icd10site=="C57"
tab icd10site ovaryc
label var ovaryc "Ovary cancer"
tab ovaryc

*CERVICAL CANCER (icd8/9 = 180; icd10 = c53)
gen byte cervixc = 0
replace cervixc = 1 if icd8site== "180"
tab icd8site cervixc
replace cervixc = 1 if icd9site== "180"
tab icd9site cervixc
replace cervixc = 1 if icd10site=="C53"
tab icd10site cervixc
label var cervixc "Cervical cancer"
tab cervixc

* OTHER CANCERS
* All malignant neoplasms that aren't the above
*indicator for all other cancers combined
gen otherc=.
foreach var of varlist lungc-cervixc {
replace otherc=1 if `var'==1 & otherc==.
}
*set the rest as other cancers
replace otherc=2 if otherc==.

*taking out squamous (173.9 C44.92) and basal cell (173.3,  C44.91) carcinomas 
tab iccsxbcc if iccs3bcc=="173"
tab sicd1cc if sidc3cc=="173"
tab sicd10cc if sicd30cc=="C44"

replace otherc =0 if iccs3bcc=="173"& inlist(iccsxbcc, " 3"," 9") 
replace otherc =0 if match(sidc3cc,"173") & inlist(sicd1cc, 3, 9)
replace otherc =0 if match(sicd30cc,"C44") & sicd10cc==" 9"
lab var otherc "IncidCanc all others"
lab def other 0"No cancer" 1"Top20cancs" 2"All other cancs"
lab val otherc other
tab otherc if firstcanc==1
********************************************************************************

*SINGLE CANCER VARIABLE 
gen byte cancertype = .
replace cancertype = 1 if lungc==1
replace cancertype = 2 if prostatec==1
replace cancertype = 3 if colorectc==1
replace cancertype = 4 if kidneyc==1
replace cancertype = 5 if bladderc==1
replace cancertype = 6 if stomachc==1
replace cancertype = 7 if nonhodgkin==1
replace cancertype = 8 if melanomaskinc==1
replace cancertype = 9 if pancreatc==1
replace cancertype = 10 if leukaemia==1
replace cancertype = 11 if oesophagealc==1
replace cancertype = 12 if oralc==1
replace cancertype = 13 if brainc==1
replace cancertype = 14 if myelomac==1
replace cancertype = 15 if liverc==1
replace cancertype = 16 if thyroidc==1
replace cancertype = 17 if breastc==1
replace cancertype = 18 if uterinec==1
replace cancertype = 19 if ovaryc==1
replace cancertype = 20 if cervixc==1
replace cancertype = 21 if otherc==2
replace cancertype = 0 if cancertype !=. & cancer !=1

label var cancertype "Site of cancer"
label define cancertype 1 "bronchus/lung cancer" 2 "prostate cancer" ///
	3 "colorectal cancer" 4 "kidney cancer" 5 "bladder cancer" 6 " stomach cancer" ///
	7 "non-Hodgkin's lymphoma" 8 "melanoma/ skin cancer" 9 "pancreatic cancer" ///
	10 "leukaemia" 11 "oesophageal cancer" 12 "oral cancer" 13 " brain cancer" ///
	14 "myeloma" 15 "liver cancer" 16 "thyroid cancer" 17 "breast cancer" ///
	18 "uterine cancer" 19 "ovary cancer" 20 "cervical cancer" 21 "Other malignant neoplasm"
label values cancertype cancertype

tab cancertype

