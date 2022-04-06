# CancerSite
This syntax derives variables indicating whether Longitudinal Study members were diagnosed with cancer in one of the top 20 cancer sites in the UK. It only 
- lung + trachea and bronchus (icd8/9 = 162; icd10 = c33, c34).
- prostate (icd8/9 = 185; icd10 = c61).
- colorectal (incl. anus) (icd8/9 = 153, 154; icd10 = c18, c19, c20, c21).
- kidney (icd8/9 = 189; icd10 = c64).
- bladder (icd8/9 = 188; icd10 = c67).
- stomach (icd8/9 = 151; icd10 = c16).
- nonhodgkin (icd8/9 = 200, 202; icd10 = c82, c83, c84 c85 c86).
- melanomaskin (not other malignant neoplasms of skin) (icd8/9 = 172; icd10 = c43).
- pancreatic (icd8/9 = 157; icd10 = c25).
- leukaemia (icd8/9 = 204, 205, 206, 207, 208; icd10 = c91, c92, c93, c94, c95).
- oesophageal (icd8/9 = 150; icd10 = c15).
- oral (includes lips, gums, palate, tongue, pharynx, NOT salivary glands) (icd8/9 = 140 - 149; icd10 = c00 - c14).
- brain + spinal cord, cranial nerves and other CNS  (icd8/9 = 191; icd10 = c71).
- myeloma (icd8/9 = 203; icd10 = c90).
- liver (icd8/9 = 155; icd10 = c22).
- thyroid (icd8/9 = 193; icd10 = c73).
- breast (icd8/9 = 174, 175; icd10 = c50).
- uterine (icd8/9 = 179, 182; icd10 = c54, c55).
- ovary (icd8/9 = 183; icd10 = c56 c57).
- cervix (icd8/9 = 180; icd10 = c53).
NB: this does not include benign neoplasms, carcinoma or neoplasms of uncertain / unknown behaviour (icd8/9 209-239 and 630 (hydatidiform mole; icd10 = codes starting with D)).

Please note that researchers using the ONS Longitudinal Study will need to ensure that their data includes the following variables:
- eventord
- iccs3bcc and iccsxbcc (ICD8 site and subsite valid 1971 - 31/12/1978).
- sidc3cc sicd1cc (ICD9 site and subsite  valid 01/01/1979 - 31/12/1994).
- sicd30cc sicd10cc (ICD10 site and subsite valid from 01/01/1995 onwards).
