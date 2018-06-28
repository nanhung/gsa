/* ACAT_like.c
   ___________________________________________________

   Model File:  ACAT_like.model

   Date:  Thu Jun 28 13:18:44 2018

   Created by:  "mod v6.0.0"
    -- a model preprocessor by Don Maszle
   ___________________________________________________

   Copyright (c) 1993-2018 Free Software Foundation, Inc.

   Model calculations for compartmental model:

   42 States:
     A_kid -> 0.0;
     A_rpt -> 0.0;
     A_liver -> 0.0;
     A_adip -> 0.0;
     A_ppt -> 0.0;
     A_blood -> 0.0;
     A_stom_lu -> 0.0;
     A_duod_lu -> 0.0;
     A_jeju_lu -> 0.0;
     A_ileon_lu -> 0.0;
     A_cecum_lu -> 0.0;
     A_colon_lu -> 0.0;
     A_stom_ep -> 0.0;
     A_duod_ep -> 0.0;
     A_jeju_ep -> 0.0;
     A_ileon_ep -> 0.0;
     A_cecum_ep -> 0.0;
     A_colon_ep -> 0.0;
     A_stom_w -> 0.0;
     A_duod_w -> 0.0;
     A_jeju_w -> 0.0;
     A_ileon_w -> 0.0;
     A_cecum_w -> 0.0;
     A_colon_w -> 0.0;
     A_absorb_stom -> 0.0;
     A_absorb_duod -> 0.0;
     A_absorb_jeju -> 0.0;
     A_absorb_ileon -> 0.0;
     A_absorb_cecum -> 0.0;
     A_absorb_colon -> 0.0;
     A_absorb_pv -> 0.0;
     A_elim_kid -> 0.0;
     A_met_liver -> 0.0;
     A_met_stom -> 0.0;
     A_met_duod -> 0.0;
     A_met_jeju -> 0.0;
     A_met_ileon -> 0.0;
     A_met_cecum -> 0.0;
     A_met_colon -> 0.0;
     A_feces -> 0.0;
     AUC_blood -> 0.0;
     AUC_liver -> 0.0;

   34 Outputs:
     C_plasma -> 0.0;
     C_kid -> 0.0;
     C_rpt -> 0.0;
     C_liver -> 0.0;
     C_adip -> 0.0;
     C_ppt -> 0.0;
     C_blood -> 0.0;
     C_stom_lu -> 0.0;
     C_duod_lu -> 0.0;
     C_jeju_lu -> 0.0;
     C_ileon_lu -> 0.0;
     C_cecum_lu -> 0.0;
     C_colon_lu -> 0.0;
     C_stom_ep -> 0.0;
     C_duod_ep -> 0.0;
     C_jeju_ep -> 0.0;
     C_ileon_ep -> 0.0;
     C_cecum_ep -> 0.0;
     C_colon_ep -> 0.0;
     C_stom_w -> 0.0;
     C_duod_w -> 0.0;
     C_jeju_w -> 0.0;
     C_ileon_w -> 0.0;
     C_cecum_w -> 0.0;
     C_colon_w -> 0.0;
     A_gi_lu -> 0.0;
     A_gi_ep -> 0.0;
     A_gi_w -> 0.0;
     A_absorb -> 0.0;
     A_elim -> 0.0;
     A_elim_gi -> 0.0;
     A_organ -> 0.0;
     A_total -> 0.0;
     Instant_Ka_gi -> 0.0;

   1 Input:
     Oral_dose_rate (is a function)

   167 Parameters:
     InDose = 0.0;
     Tlag = 0.0;
     Period = 0.0;
     Exposure = 0.0;
     BDM = 0;
     sc_F_total = 15;
     f_Flow_adip = 0.06;
     f_Flow_kid = 0.21;
     f_Flow_ppt = 0.20;
     f_Flow_liver_art = 0.077;
     f_Flow_stom = 0.024;
     f_Flow_duod = 0.016;
     f_Flow_jeju = 0.056;
     f_Flow_ileon = 0.033;
     f_Flow_cecum = 0.006;
     f_Flow_colon = 0.038;
     f_BDM_adip = 0.16;
     f_BDM_blood = 0.065;
     f_BDM_kid = 0.0096;
     f_BDM_rpt = 0.1;
     f_BDM_liver = 0.0243;
     f_BDM_stom = 0.0021;
     f_BDM_duod = 0.0003;
     f_BDM_jeju = 0.0009;
     f_BDM_ileon = 0.0006;
     f_BDM_cecum = 0.0005;
     f_BDM_colon = 0.0048;
     f_BDM_stom_lu = 0.0036;
     f_BDM_duod_lu = 0.0003;
     f_BDM_jeju_lu = 0.0023;
     f_BDM_ileon_lu = 0.0032;
     f_BDM_cecum_lu = 0.0001;
     f_BDM_colon_lu = 0.0051;
     Length_stom = 2.5;
     Length_duod = 2.5;
     Length_jeju = 20;
     Length_ileon = 30;
     Length_cecum = 1.7;
     Length_colon = 12.5;
     Radius_stom = 0.85;
     Radius_duod = 0.2;
     Radius_jeju = 0.18;
     Radius_ileon = 0.15;
     Radius_cecum = 0.35;
     Radius_colon = 0.25;
     T12_stom_lu = 0.25;
     T12_duod_lu = 0.25;
     T12_jeju_lu = 1.02;
     T12_ileon_lu = 2.04;
     T12_cecum_lu = 4.55;
     T12_colon_lu = 13.5;
     PH_stom = 1.7;
     PH_duod = 6;
     PH_jeju = 6.5;
     PH_ileon = 7.4;
     PH_cecum = 5.9;
     PH_colon = 7;
     MicroProt_liver = 45;
     MicroProt_stom = 0;
     MicroProt_duod = 9.45;
     MicroProt_jeju = 8.82;
     MicroProt_ileon = 1.62;
     MicroProt_cecum = 0.0;
     MicroProt_colon = 0.0;
     V_ep = 5.25E-4;
     MM = 0;
     f_Abs_stom = 0;
     f_Abs_duod = 0;
     f_Abs_jeju = 0;
     f_Abs_ileon = 0;
     f_Abs_cecum = 0;
     f_Abs_colon = 0;
     Peff = 0;
     Ratio_BP = 0;
     PC_adip = 0;
     PC_rpt = 0;
     PC_ppt = 0;
     PC_kid = 0;
     PC_liver = 0;
     PC_stom = 0;
     PC_duod = 0;
     PC_jeju = 0;
     PC_ileon = 0;
     PC_cecum = 0;
     PC_colon = 0;
     Fu_adip = 1.0;
     Fu_kid = 1.0;
     Fu_ppt = 1.0;
     Fu_rpt = 1.0;
     Fu_blood = 1.0;
     Fu_liver = 1.0;
     Fu_portvein = 1.0;
     Fu_stom = 1.0;
     Fu_duod = 1.0;
     Fu_jeju = 1.0;
     Fu_ileon = 1.0;
     Fu_cecum = 1.0;
     Fu_colon = 1.0;
     Fu_plasma = 1.0;
     Vmax_vitro = 0;
     Km_vitro = 0;
     Kle_kid = 0;
     F_total = 0;
     f_Flow_portvein = 0;
     V_adip = 0;
     V_blood = 0;
     V_kid = 0;
     V_liver = 0;
     V_rpt = 0;
     V_ppt = 0;
     V_stom = 0;
     V_duod = 0;
     V_jeju = 0;
     V_ileon = 0;
     V_cecum = 0;
     V_colon = 0;
     V_stom_w = 0;
     V_duod_w = 0;
     V_jeju_w = 0;
     V_ileon_w = 0;
     V_cecum_w = 0;
     V_colon_w = 0;
     V_stom_lu = 0;
     V_colon_lu = 0;
     V_duod_lu = 0;
     V_jeju_lu = 0;
     V_ileon_lu = 0;
     V_cecum_lu = 0;
     V_stom_ep = 0;
     V_duod_ep = 0;
     V_jeju_ep = 0;
     V_ileon_ep = 0;
     V_cecum_ep = 0;
     V_colon_ep = 0;
     SA_stom = 0;
     SA_duod = 0;
     SA_jeju = 0;
     SA_ileon = 0;
     SA_cecum = 0;
     SA_colon = 0;
     Flow_adip = 0;
     Flow_kid = 0;
     Flow_liver = 0;
     Flow_liver_art = 0;
     Flow_rpt = 0;
     Flow_ppt = 0;
     Flow_portvein = 0;
     Flow_stom = 0;
     Flow_duod = 0;
     Flow_jeju = 0;
     Flow_ileon = 0;
     Flow_cecum = 0;
     Flow_colon = 0;
     Kle_stom = 0;
     Kle_duod = 0;
     Kle_jeju = 0;
     Kle_ileon = 0;
     Kle_cecum = 0;
     Kle_colon = 0;
     Vmax_vivo_liver = 0;
     Vmax_vivo_stom = 0;
     Vmax_vivo_duod = 0;
     Vmax_vivo_jeju = 0;
     Vmax_vivo_ileon = 0;
     Vmax_vivo_cecum = 0;
     Vmax_vivo_colon = 0;
     Km_vivo = 0;
*/


#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <float.h>
#include "modelu.h"
#include "random.h"
#include "yourcode.h"


/*----- Indices to Global Variables */

/* Model variables: States and other outputs */
#define ID_A_kid 0x00000
#define ID_A_rpt 0x00001
#define ID_A_liver 0x00002
#define ID_A_adip 0x00003
#define ID_A_ppt 0x00004
#define ID_A_blood 0x00005
#define ID_A_stom_lu 0x00006
#define ID_A_duod_lu 0x00007
#define ID_A_jeju_lu 0x00008
#define ID_A_ileon_lu 0x00009
#define ID_A_cecum_lu 0x0000a
#define ID_A_colon_lu 0x0000b
#define ID_A_stom_ep 0x0000c
#define ID_A_duod_ep 0x0000d
#define ID_A_jeju_ep 0x0000e
#define ID_A_ileon_ep 0x0000f
#define ID_A_cecum_ep 0x00010
#define ID_A_colon_ep 0x00011
#define ID_A_stom_w 0x00012
#define ID_A_duod_w 0x00013
#define ID_A_jeju_w 0x00014
#define ID_A_ileon_w 0x00015
#define ID_A_cecum_w 0x00016
#define ID_A_colon_w 0x00017
#define ID_A_absorb_stom 0x00018
#define ID_A_absorb_duod 0x00019
#define ID_A_absorb_jeju 0x0001a
#define ID_A_absorb_ileon 0x0001b
#define ID_A_absorb_cecum 0x0001c
#define ID_A_absorb_colon 0x0001d
#define ID_A_absorb_pv 0x0001e
#define ID_A_elim_kid 0x0001f
#define ID_A_met_liver 0x00020
#define ID_A_met_stom 0x00021
#define ID_A_met_duod 0x00022
#define ID_A_met_jeju 0x00023
#define ID_A_met_ileon 0x00024
#define ID_A_met_cecum 0x00025
#define ID_A_met_colon 0x00026
#define ID_A_feces 0x00027
#define ID_AUC_blood 0x00028
#define ID_AUC_liver 0x00029
#define ID_C_plasma 0x0002a
#define ID_C_kid 0x0002b
#define ID_C_rpt 0x0002c
#define ID_C_liver 0x0002d
#define ID_C_adip 0x0002e
#define ID_C_ppt 0x0002f
#define ID_C_blood 0x00030
#define ID_C_stom_lu 0x00031
#define ID_C_duod_lu 0x00032
#define ID_C_jeju_lu 0x00033
#define ID_C_ileon_lu 0x00034
#define ID_C_cecum_lu 0x00035
#define ID_C_colon_lu 0x00036
#define ID_C_stom_ep 0x00037
#define ID_C_duod_ep 0x00038
#define ID_C_jeju_ep 0x00039
#define ID_C_ileon_ep 0x0003a
#define ID_C_cecum_ep 0x0003b
#define ID_C_colon_ep 0x0003c
#define ID_C_stom_w 0x0003d
#define ID_C_duod_w 0x0003e
#define ID_C_jeju_w 0x0003f
#define ID_C_ileon_w 0x00040
#define ID_C_cecum_w 0x00041
#define ID_C_colon_w 0x00042
#define ID_A_gi_lu 0x00043
#define ID_A_gi_ep 0x00044
#define ID_A_gi_w 0x00045
#define ID_A_absorb 0x00046
#define ID_A_elim 0x00047
#define ID_A_elim_gi 0x00048
#define ID_A_organ 0x00049
#define ID_A_total 0x0004a
#define ID_Instant_Ka_gi 0x0004b

/* Inputs */
#define ID_Oral_dose_rate 0x00000

/* Parameters */
#define ID_InDose 0x0004d
#define ID_Tlag 0x0004e
#define ID_Period 0x0004f
#define ID_Exposure 0x00050
#define ID_BDM 0x00051
#define ID_sc_F_total 0x00052
#define ID_f_Flow_adip 0x00053
#define ID_f_Flow_kid 0x00054
#define ID_f_Flow_ppt 0x00055
#define ID_f_Flow_liver_art 0x00056
#define ID_f_Flow_stom 0x00057
#define ID_f_Flow_duod 0x00058
#define ID_f_Flow_jeju 0x00059
#define ID_f_Flow_ileon 0x0005a
#define ID_f_Flow_cecum 0x0005b
#define ID_f_Flow_colon 0x0005c
#define ID_f_BDM_adip 0x0005d
#define ID_f_BDM_blood 0x0005e
#define ID_f_BDM_kid 0x0005f
#define ID_f_BDM_rpt 0x00060
#define ID_f_BDM_liver 0x00061
#define ID_f_BDM_stom 0x00062
#define ID_f_BDM_duod 0x00063
#define ID_f_BDM_jeju 0x00064
#define ID_f_BDM_ileon 0x00065
#define ID_f_BDM_cecum 0x00066
#define ID_f_BDM_colon 0x00067
#define ID_f_BDM_stom_lu 0x00068
#define ID_f_BDM_duod_lu 0x00069
#define ID_f_BDM_jeju_lu 0x0006a
#define ID_f_BDM_ileon_lu 0x0006b
#define ID_f_BDM_cecum_lu 0x0006c
#define ID_f_BDM_colon_lu 0x0006d
#define ID_Length_stom 0x0006e
#define ID_Length_duod 0x0006f
#define ID_Length_jeju 0x00070
#define ID_Length_ileon 0x00071
#define ID_Length_cecum 0x00072
#define ID_Length_colon 0x00073
#define ID_Radius_stom 0x00074
#define ID_Radius_duod 0x00075
#define ID_Radius_jeju 0x00076
#define ID_Radius_ileon 0x00077
#define ID_Radius_cecum 0x00078
#define ID_Radius_colon 0x00079
#define ID_T12_stom_lu 0x0007a
#define ID_T12_duod_lu 0x0007b
#define ID_T12_jeju_lu 0x0007c
#define ID_T12_ileon_lu 0x0007d
#define ID_T12_cecum_lu 0x0007e
#define ID_T12_colon_lu 0x0007f
#define ID_PH_stom 0x00080
#define ID_PH_duod 0x00081
#define ID_PH_jeju 0x00082
#define ID_PH_ileon 0x00083
#define ID_PH_cecum 0x00084
#define ID_PH_colon 0x00085
#define ID_MicroProt_liver 0x00086
#define ID_MicroProt_stom 0x00087
#define ID_MicroProt_duod 0x00088
#define ID_MicroProt_jeju 0x00089
#define ID_MicroProt_ileon 0x0008a
#define ID_MicroProt_cecum 0x0008b
#define ID_MicroProt_colon 0x0008c
#define ID_V_ep 0x0008d
#define ID_MM 0x0008e
#define ID_f_Abs_stom 0x0008f
#define ID_f_Abs_duod 0x00090
#define ID_f_Abs_jeju 0x00091
#define ID_f_Abs_ileon 0x00092
#define ID_f_Abs_cecum 0x00093
#define ID_f_Abs_colon 0x00094
#define ID_Peff 0x00095
#define ID_Ratio_BP 0x00096
#define ID_PC_adip 0x00097
#define ID_PC_rpt 0x00098
#define ID_PC_ppt 0x00099
#define ID_PC_kid 0x0009a
#define ID_PC_liver 0x0009b
#define ID_PC_stom 0x0009c
#define ID_PC_duod 0x0009d
#define ID_PC_jeju 0x0009e
#define ID_PC_ileon 0x0009f
#define ID_PC_cecum 0x000a0
#define ID_PC_colon 0x000a1
#define ID_Fu_adip 0x000a2
#define ID_Fu_kid 0x000a3
#define ID_Fu_ppt 0x000a4
#define ID_Fu_rpt 0x000a5
#define ID_Fu_blood 0x000a6
#define ID_Fu_liver 0x000a7
#define ID_Fu_portvein 0x000a8
#define ID_Fu_stom 0x000a9
#define ID_Fu_duod 0x000aa
#define ID_Fu_jeju 0x000ab
#define ID_Fu_ileon 0x000ac
#define ID_Fu_cecum 0x000ad
#define ID_Fu_colon 0x000ae
#define ID_Fu_plasma 0x000af
#define ID_Vmax_vitro 0x000b0
#define ID_Km_vitro 0x000b1
#define ID_Kle_kid 0x000b2
#define ID_F_total 0x000b3
#define ID_f_Flow_portvein 0x000b4
#define ID_V_adip 0x000b5
#define ID_V_blood 0x000b6
#define ID_V_kid 0x000b7
#define ID_V_liver 0x000b8
#define ID_V_rpt 0x000b9
#define ID_V_ppt 0x000ba
#define ID_V_stom 0x000bb
#define ID_V_duod 0x000bc
#define ID_V_jeju 0x000bd
#define ID_V_ileon 0x000be
#define ID_V_cecum 0x000bf
#define ID_V_colon 0x000c0
#define ID_V_stom_w 0x000c1
#define ID_V_duod_w 0x000c2
#define ID_V_jeju_w 0x000c3
#define ID_V_ileon_w 0x000c4
#define ID_V_cecum_w 0x000c5
#define ID_V_colon_w 0x000c6
#define ID_V_stom_lu 0x000c7
#define ID_V_colon_lu 0x000c8
#define ID_V_duod_lu 0x000c9
#define ID_V_jeju_lu 0x000ca
#define ID_V_ileon_lu 0x000cb
#define ID_V_cecum_lu 0x000cc
#define ID_V_stom_ep 0x000cd
#define ID_V_duod_ep 0x000ce
#define ID_V_jeju_ep 0x000cf
#define ID_V_ileon_ep 0x000d0
#define ID_V_cecum_ep 0x000d1
#define ID_V_colon_ep 0x000d2
#define ID_SA_stom 0x000d3
#define ID_SA_duod 0x000d4
#define ID_SA_jeju 0x000d5
#define ID_SA_ileon 0x000d6
#define ID_SA_cecum 0x000d7
#define ID_SA_colon 0x000d8
#define ID_Flow_adip 0x000d9
#define ID_Flow_kid 0x000da
#define ID_Flow_liver 0x000db
#define ID_Flow_liver_art 0x000dc
#define ID_Flow_rpt 0x000dd
#define ID_Flow_ppt 0x000de
#define ID_Flow_portvein 0x000df
#define ID_Flow_stom 0x000e0
#define ID_Flow_duod 0x000e1
#define ID_Flow_jeju 0x000e2
#define ID_Flow_ileon 0x000e3
#define ID_Flow_cecum 0x000e4
#define ID_Flow_colon 0x000e5
#define ID_Kle_stom 0x000e6
#define ID_Kle_duod 0x000e7
#define ID_Kle_jeju 0x000e8
#define ID_Kle_ileon 0x000e9
#define ID_Kle_cecum 0x000ea
#define ID_Kle_colon 0x000eb
#define ID_Vmax_vivo_liver 0x000ec
#define ID_Vmax_vivo_stom 0x000ed
#define ID_Vmax_vivo_duod 0x000ee
#define ID_Vmax_vivo_jeju 0x000ef
#define ID_Vmax_vivo_ileon 0x000f0
#define ID_Vmax_vivo_cecum 0x000f1
#define ID_Vmax_vivo_colon 0x000f2
#define ID_Km_vivo 0x000f3


/*----- Global Variables */

/* For export. Keep track of who we are. */
char szModelDescFilename[] = "ACAT_like.model";
char szModelSourceFilename[] = __FILE__;
char szModelGenAndVersion[] = "mod v6.0.0";

/* Externs */
extern BOOL vbModelReinitd;

/* Model Dimensions */
int vnStates = 42;
int vnOutputs = 34;
int vnModelVars = 76;
int vnInputs = 1;
int vnParms = 167;

/* States and Outputs*/
double vrgModelVars[76];

/* Inputs */
IFN vrgInputs[1];

/* Parameters */
double InDose;
double Tlag;
double Period;
double Exposure;
double BDM;
double sc_F_total;
double f_Flow_adip;
double f_Flow_kid;
double f_Flow_ppt;
double f_Flow_liver_art;
double f_Flow_stom;
double f_Flow_duod;
double f_Flow_jeju;
double f_Flow_ileon;
double f_Flow_cecum;
double f_Flow_colon;
double f_BDM_adip;
double f_BDM_blood;
double f_BDM_kid;
double f_BDM_rpt;
double f_BDM_liver;
double f_BDM_stom;
double f_BDM_duod;
double f_BDM_jeju;
double f_BDM_ileon;
double f_BDM_cecum;
double f_BDM_colon;
double f_BDM_stom_lu;
double f_BDM_duod_lu;
double f_BDM_jeju_lu;
double f_BDM_ileon_lu;
double f_BDM_cecum_lu;
double f_BDM_colon_lu;
double Length_stom;
double Length_duod;
double Length_jeju;
double Length_ileon;
double Length_cecum;
double Length_colon;
double Radius_stom;
double Radius_duod;
double Radius_jeju;
double Radius_ileon;
double Radius_cecum;
double Radius_colon;
double T12_stom_lu;
double T12_duod_lu;
double T12_jeju_lu;
double T12_ileon_lu;
double T12_cecum_lu;
double T12_colon_lu;
double PH_stom;
double PH_duod;
double PH_jeju;
double PH_ileon;
double PH_cecum;
double PH_colon;
double MicroProt_liver;
double MicroProt_stom;
double MicroProt_duod;
double MicroProt_jeju;
double MicroProt_ileon;
double MicroProt_cecum;
double MicroProt_colon;
double V_ep;
double MM;
double f_Abs_stom;
double f_Abs_duod;
double f_Abs_jeju;
double f_Abs_ileon;
double f_Abs_cecum;
double f_Abs_colon;
double Peff;
double Ratio_BP;
double PC_adip;
double PC_rpt;
double PC_ppt;
double PC_kid;
double PC_liver;
double PC_stom;
double PC_duod;
double PC_jeju;
double PC_ileon;
double PC_cecum;
double PC_colon;
double Fu_adip;
double Fu_kid;
double Fu_ppt;
double Fu_rpt;
double Fu_blood;
double Fu_liver;
double Fu_portvein;
double Fu_stom;
double Fu_duod;
double Fu_jeju;
double Fu_ileon;
double Fu_cecum;
double Fu_colon;
double Fu_plasma;
double Vmax_vitro;
double Km_vitro;
double Kle_kid;
double F_total;
double f_Flow_portvein;
double V_adip;
double V_blood;
double V_kid;
double V_liver;
double V_rpt;
double V_ppt;
double V_stom;
double V_duod;
double V_jeju;
double V_ileon;
double V_cecum;
double V_colon;
double V_stom_w;
double V_duod_w;
double V_jeju_w;
double V_ileon_w;
double V_cecum_w;
double V_colon_w;
double V_stom_lu;
double V_colon_lu;
double V_duod_lu;
double V_jeju_lu;
double V_ileon_lu;
double V_cecum_lu;
double V_stom_ep;
double V_duod_ep;
double V_jeju_ep;
double V_ileon_ep;
double V_cecum_ep;
double V_colon_ep;
double SA_stom;
double SA_duod;
double SA_jeju;
double SA_ileon;
double SA_cecum;
double SA_colon;
double Flow_adip;
double Flow_kid;
double Flow_liver;
double Flow_liver_art;
double Flow_rpt;
double Flow_ppt;
double Flow_portvein;
double Flow_stom;
double Flow_duod;
double Flow_jeju;
double Flow_ileon;
double Flow_cecum;
double Flow_colon;
double Kle_stom;
double Kle_duod;
double Kle_jeju;
double Kle_ileon;
double Kle_cecum;
double Kle_colon;
double Vmax_vivo_liver;
double Vmax_vivo_stom;
double Vmax_vivo_duod;
double Vmax_vivo_jeju;
double Vmax_vivo_ileon;
double Vmax_vivo_cecum;
double Vmax_vivo_colon;
double Km_vivo;

BOOL bDelays = 0;


/*----- Global Variable Map */

VMMAPSTRCT vrgvmGlo[] = {
  {"A_kid", (PVOID) &vrgModelVars[ID_A_kid], ID_STATE | ID_A_kid},
  {"A_rpt", (PVOID) &vrgModelVars[ID_A_rpt], ID_STATE | ID_A_rpt},
  {"A_liver", (PVOID) &vrgModelVars[ID_A_liver], ID_STATE | ID_A_liver},
  {"A_adip", (PVOID) &vrgModelVars[ID_A_adip], ID_STATE | ID_A_adip},
  {"A_ppt", (PVOID) &vrgModelVars[ID_A_ppt], ID_STATE | ID_A_ppt},
  {"A_blood", (PVOID) &vrgModelVars[ID_A_blood], ID_STATE | ID_A_blood},
  {"A_stom_lu", (PVOID) &vrgModelVars[ID_A_stom_lu], ID_STATE | ID_A_stom_lu},
  {"A_duod_lu", (PVOID) &vrgModelVars[ID_A_duod_lu], ID_STATE | ID_A_duod_lu},
  {"A_jeju_lu", (PVOID) &vrgModelVars[ID_A_jeju_lu], ID_STATE | ID_A_jeju_lu},
  {"A_ileon_lu", (PVOID) &vrgModelVars[ID_A_ileon_lu], ID_STATE | ID_A_ileon_lu},
  {"A_cecum_lu", (PVOID) &vrgModelVars[ID_A_cecum_lu], ID_STATE | ID_A_cecum_lu},
  {"A_colon_lu", (PVOID) &vrgModelVars[ID_A_colon_lu], ID_STATE | ID_A_colon_lu},
  {"A_stom_ep", (PVOID) &vrgModelVars[ID_A_stom_ep], ID_STATE | ID_A_stom_ep},
  {"A_duod_ep", (PVOID) &vrgModelVars[ID_A_duod_ep], ID_STATE | ID_A_duod_ep},
  {"A_jeju_ep", (PVOID) &vrgModelVars[ID_A_jeju_ep], ID_STATE | ID_A_jeju_ep},
  {"A_ileon_ep", (PVOID) &vrgModelVars[ID_A_ileon_ep], ID_STATE | ID_A_ileon_ep},
  {"A_cecum_ep", (PVOID) &vrgModelVars[ID_A_cecum_ep], ID_STATE | ID_A_cecum_ep},
  {"A_colon_ep", (PVOID) &vrgModelVars[ID_A_colon_ep], ID_STATE | ID_A_colon_ep},
  {"A_stom_w", (PVOID) &vrgModelVars[ID_A_stom_w], ID_STATE | ID_A_stom_w},
  {"A_duod_w", (PVOID) &vrgModelVars[ID_A_duod_w], ID_STATE | ID_A_duod_w},
  {"A_jeju_w", (PVOID) &vrgModelVars[ID_A_jeju_w], ID_STATE | ID_A_jeju_w},
  {"A_ileon_w", (PVOID) &vrgModelVars[ID_A_ileon_w], ID_STATE | ID_A_ileon_w},
  {"A_cecum_w", (PVOID) &vrgModelVars[ID_A_cecum_w], ID_STATE | ID_A_cecum_w},
  {"A_colon_w", (PVOID) &vrgModelVars[ID_A_colon_w], ID_STATE | ID_A_colon_w},
  {"A_absorb_stom", (PVOID) &vrgModelVars[ID_A_absorb_stom], ID_STATE | ID_A_absorb_stom},
  {"A_absorb_duod", (PVOID) &vrgModelVars[ID_A_absorb_duod], ID_STATE | ID_A_absorb_duod},
  {"A_absorb_jeju", (PVOID) &vrgModelVars[ID_A_absorb_jeju], ID_STATE | ID_A_absorb_jeju},
  {"A_absorb_ileon", (PVOID) &vrgModelVars[ID_A_absorb_ileon], ID_STATE | ID_A_absorb_ileon},
  {"A_absorb_cecum", (PVOID) &vrgModelVars[ID_A_absorb_cecum], ID_STATE | ID_A_absorb_cecum},
  {"A_absorb_colon", (PVOID) &vrgModelVars[ID_A_absorb_colon], ID_STATE | ID_A_absorb_colon},
  {"A_absorb_pv", (PVOID) &vrgModelVars[ID_A_absorb_pv], ID_STATE | ID_A_absorb_pv},
  {"A_elim_kid", (PVOID) &vrgModelVars[ID_A_elim_kid], ID_STATE | ID_A_elim_kid},
  {"A_met_liver", (PVOID) &vrgModelVars[ID_A_met_liver], ID_STATE | ID_A_met_liver},
  {"A_met_stom", (PVOID) &vrgModelVars[ID_A_met_stom], ID_STATE | ID_A_met_stom},
  {"A_met_duod", (PVOID) &vrgModelVars[ID_A_met_duod], ID_STATE | ID_A_met_duod},
  {"A_met_jeju", (PVOID) &vrgModelVars[ID_A_met_jeju], ID_STATE | ID_A_met_jeju},
  {"A_met_ileon", (PVOID) &vrgModelVars[ID_A_met_ileon], ID_STATE | ID_A_met_ileon},
  {"A_met_cecum", (PVOID) &vrgModelVars[ID_A_met_cecum], ID_STATE | ID_A_met_cecum},
  {"A_met_colon", (PVOID) &vrgModelVars[ID_A_met_colon], ID_STATE | ID_A_met_colon},
  {"A_feces", (PVOID) &vrgModelVars[ID_A_feces], ID_STATE | ID_A_feces},
  {"AUC_blood", (PVOID) &vrgModelVars[ID_AUC_blood], ID_STATE | ID_AUC_blood},
  {"AUC_liver", (PVOID) &vrgModelVars[ID_AUC_liver], ID_STATE | ID_AUC_liver},
  {"C_plasma", (PVOID) &vrgModelVars[ID_C_plasma], ID_OUTPUT | ID_C_plasma},
  {"C_kid", (PVOID) &vrgModelVars[ID_C_kid], ID_OUTPUT | ID_C_kid},
  {"C_rpt", (PVOID) &vrgModelVars[ID_C_rpt], ID_OUTPUT | ID_C_rpt},
  {"C_liver", (PVOID) &vrgModelVars[ID_C_liver], ID_OUTPUT | ID_C_liver},
  {"C_adip", (PVOID) &vrgModelVars[ID_C_adip], ID_OUTPUT | ID_C_adip},
  {"C_ppt", (PVOID) &vrgModelVars[ID_C_ppt], ID_OUTPUT | ID_C_ppt},
  {"C_blood", (PVOID) &vrgModelVars[ID_C_blood], ID_OUTPUT | ID_C_blood},
  {"C_stom_lu", (PVOID) &vrgModelVars[ID_C_stom_lu], ID_OUTPUT | ID_C_stom_lu},
  {"C_duod_lu", (PVOID) &vrgModelVars[ID_C_duod_lu], ID_OUTPUT | ID_C_duod_lu},
  {"C_jeju_lu", (PVOID) &vrgModelVars[ID_C_jeju_lu], ID_OUTPUT | ID_C_jeju_lu},
  {"C_ileon_lu", (PVOID) &vrgModelVars[ID_C_ileon_lu], ID_OUTPUT | ID_C_ileon_lu},
  {"C_cecum_lu", (PVOID) &vrgModelVars[ID_C_cecum_lu], ID_OUTPUT | ID_C_cecum_lu},
  {"C_colon_lu", (PVOID) &vrgModelVars[ID_C_colon_lu], ID_OUTPUT | ID_C_colon_lu},
  {"C_stom_ep", (PVOID) &vrgModelVars[ID_C_stom_ep], ID_OUTPUT | ID_C_stom_ep},
  {"C_duod_ep", (PVOID) &vrgModelVars[ID_C_duod_ep], ID_OUTPUT | ID_C_duod_ep},
  {"C_jeju_ep", (PVOID) &vrgModelVars[ID_C_jeju_ep], ID_OUTPUT | ID_C_jeju_ep},
  {"C_ileon_ep", (PVOID) &vrgModelVars[ID_C_ileon_ep], ID_OUTPUT | ID_C_ileon_ep},
  {"C_cecum_ep", (PVOID) &vrgModelVars[ID_C_cecum_ep], ID_OUTPUT | ID_C_cecum_ep},
  {"C_colon_ep", (PVOID) &vrgModelVars[ID_C_colon_ep], ID_OUTPUT | ID_C_colon_ep},
  {"C_stom_w", (PVOID) &vrgModelVars[ID_C_stom_w], ID_OUTPUT | ID_C_stom_w},
  {"C_duod_w", (PVOID) &vrgModelVars[ID_C_duod_w], ID_OUTPUT | ID_C_duod_w},
  {"C_jeju_w", (PVOID) &vrgModelVars[ID_C_jeju_w], ID_OUTPUT | ID_C_jeju_w},
  {"C_ileon_w", (PVOID) &vrgModelVars[ID_C_ileon_w], ID_OUTPUT | ID_C_ileon_w},
  {"C_cecum_w", (PVOID) &vrgModelVars[ID_C_cecum_w], ID_OUTPUT | ID_C_cecum_w},
  {"C_colon_w", (PVOID) &vrgModelVars[ID_C_colon_w], ID_OUTPUT | ID_C_colon_w},
  {"A_gi_lu", (PVOID) &vrgModelVars[ID_A_gi_lu], ID_OUTPUT | ID_A_gi_lu},
  {"A_gi_ep", (PVOID) &vrgModelVars[ID_A_gi_ep], ID_OUTPUT | ID_A_gi_ep},
  {"A_gi_w", (PVOID) &vrgModelVars[ID_A_gi_w], ID_OUTPUT | ID_A_gi_w},
  {"A_absorb", (PVOID) &vrgModelVars[ID_A_absorb], ID_OUTPUT | ID_A_absorb},
  {"A_elim", (PVOID) &vrgModelVars[ID_A_elim], ID_OUTPUT | ID_A_elim},
  {"A_elim_gi", (PVOID) &vrgModelVars[ID_A_elim_gi], ID_OUTPUT | ID_A_elim_gi},
  {"A_organ", (PVOID) &vrgModelVars[ID_A_organ], ID_OUTPUT | ID_A_organ},
  {"A_total", (PVOID) &vrgModelVars[ID_A_total], ID_OUTPUT | ID_A_total},
  {"Instant_Ka_gi", (PVOID) &vrgModelVars[ID_Instant_Ka_gi], ID_OUTPUT | ID_Instant_Ka_gi},
  {"Oral_dose_rate", (PVOID) &vrgInputs[ID_Oral_dose_rate], ID_INPUT | ID_Oral_dose_rate},
  {"InDose", (PVOID) &InDose, ID_PARM | ID_InDose},
  {"Tlag", (PVOID) &Tlag, ID_PARM | ID_Tlag},
  {"Period", (PVOID) &Period, ID_PARM | ID_Period},
  {"Exposure", (PVOID) &Exposure, ID_PARM | ID_Exposure},
  {"BDM", (PVOID) &BDM, ID_PARM | ID_BDM},
  {"sc_F_total", (PVOID) &sc_F_total, ID_PARM | ID_sc_F_total},
  {"f_Flow_adip", (PVOID) &f_Flow_adip, ID_PARM | ID_f_Flow_adip},
  {"f_Flow_kid", (PVOID) &f_Flow_kid, ID_PARM | ID_f_Flow_kid},
  {"f_Flow_ppt", (PVOID) &f_Flow_ppt, ID_PARM | ID_f_Flow_ppt},
  {"f_Flow_liver_art", (PVOID) &f_Flow_liver_art, ID_PARM | ID_f_Flow_liver_art},
  {"f_Flow_stom", (PVOID) &f_Flow_stom, ID_PARM | ID_f_Flow_stom},
  {"f_Flow_duod", (PVOID) &f_Flow_duod, ID_PARM | ID_f_Flow_duod},
  {"f_Flow_jeju", (PVOID) &f_Flow_jeju, ID_PARM | ID_f_Flow_jeju},
  {"f_Flow_ileon", (PVOID) &f_Flow_ileon, ID_PARM | ID_f_Flow_ileon},
  {"f_Flow_cecum", (PVOID) &f_Flow_cecum, ID_PARM | ID_f_Flow_cecum},
  {"f_Flow_colon", (PVOID) &f_Flow_colon, ID_PARM | ID_f_Flow_colon},
  {"f_BDM_adip", (PVOID) &f_BDM_adip, ID_PARM | ID_f_BDM_adip},
  {"f_BDM_blood", (PVOID) &f_BDM_blood, ID_PARM | ID_f_BDM_blood},
  {"f_BDM_kid", (PVOID) &f_BDM_kid, ID_PARM | ID_f_BDM_kid},
  {"f_BDM_rpt", (PVOID) &f_BDM_rpt, ID_PARM | ID_f_BDM_rpt},
  {"f_BDM_liver", (PVOID) &f_BDM_liver, ID_PARM | ID_f_BDM_liver},
  {"f_BDM_stom", (PVOID) &f_BDM_stom, ID_PARM | ID_f_BDM_stom},
  {"f_BDM_duod", (PVOID) &f_BDM_duod, ID_PARM | ID_f_BDM_duod},
  {"f_BDM_jeju", (PVOID) &f_BDM_jeju, ID_PARM | ID_f_BDM_jeju},
  {"f_BDM_ileon", (PVOID) &f_BDM_ileon, ID_PARM | ID_f_BDM_ileon},
  {"f_BDM_cecum", (PVOID) &f_BDM_cecum, ID_PARM | ID_f_BDM_cecum},
  {"f_BDM_colon", (PVOID) &f_BDM_colon, ID_PARM | ID_f_BDM_colon},
  {"f_BDM_stom_lu", (PVOID) &f_BDM_stom_lu, ID_PARM | ID_f_BDM_stom_lu},
  {"f_BDM_duod_lu", (PVOID) &f_BDM_duod_lu, ID_PARM | ID_f_BDM_duod_lu},
  {"f_BDM_jeju_lu", (PVOID) &f_BDM_jeju_lu, ID_PARM | ID_f_BDM_jeju_lu},
  {"f_BDM_ileon_lu", (PVOID) &f_BDM_ileon_lu, ID_PARM | ID_f_BDM_ileon_lu},
  {"f_BDM_cecum_lu", (PVOID) &f_BDM_cecum_lu, ID_PARM | ID_f_BDM_cecum_lu},
  {"f_BDM_colon_lu", (PVOID) &f_BDM_colon_lu, ID_PARM | ID_f_BDM_colon_lu},
  {"Length_stom", (PVOID) &Length_stom, ID_PARM | ID_Length_stom},
  {"Length_duod", (PVOID) &Length_duod, ID_PARM | ID_Length_duod},
  {"Length_jeju", (PVOID) &Length_jeju, ID_PARM | ID_Length_jeju},
  {"Length_ileon", (PVOID) &Length_ileon, ID_PARM | ID_Length_ileon},
  {"Length_cecum", (PVOID) &Length_cecum, ID_PARM | ID_Length_cecum},
  {"Length_colon", (PVOID) &Length_colon, ID_PARM | ID_Length_colon},
  {"Radius_stom", (PVOID) &Radius_stom, ID_PARM | ID_Radius_stom},
  {"Radius_duod", (PVOID) &Radius_duod, ID_PARM | ID_Radius_duod},
  {"Radius_jeju", (PVOID) &Radius_jeju, ID_PARM | ID_Radius_jeju},
  {"Radius_ileon", (PVOID) &Radius_ileon, ID_PARM | ID_Radius_ileon},
  {"Radius_cecum", (PVOID) &Radius_cecum, ID_PARM | ID_Radius_cecum},
  {"Radius_colon", (PVOID) &Radius_colon, ID_PARM | ID_Radius_colon},
  {"T12_stom_lu", (PVOID) &T12_stom_lu, ID_PARM | ID_T12_stom_lu},
  {"T12_duod_lu", (PVOID) &T12_duod_lu, ID_PARM | ID_T12_duod_lu},
  {"T12_jeju_lu", (PVOID) &T12_jeju_lu, ID_PARM | ID_T12_jeju_lu},
  {"T12_ileon_lu", (PVOID) &T12_ileon_lu, ID_PARM | ID_T12_ileon_lu},
  {"T12_cecum_lu", (PVOID) &T12_cecum_lu, ID_PARM | ID_T12_cecum_lu},
  {"T12_colon_lu", (PVOID) &T12_colon_lu, ID_PARM | ID_T12_colon_lu},
  {"PH_stom", (PVOID) &PH_stom, ID_PARM | ID_PH_stom},
  {"PH_duod", (PVOID) &PH_duod, ID_PARM | ID_PH_duod},
  {"PH_jeju", (PVOID) &PH_jeju, ID_PARM | ID_PH_jeju},
  {"PH_ileon", (PVOID) &PH_ileon, ID_PARM | ID_PH_ileon},
  {"PH_cecum", (PVOID) &PH_cecum, ID_PARM | ID_PH_cecum},
  {"PH_colon", (PVOID) &PH_colon, ID_PARM | ID_PH_colon},
  {"MicroProt_liver", (PVOID) &MicroProt_liver, ID_PARM | ID_MicroProt_liver},
  {"MicroProt_stom", (PVOID) &MicroProt_stom, ID_PARM | ID_MicroProt_stom},
  {"MicroProt_duod", (PVOID) &MicroProt_duod, ID_PARM | ID_MicroProt_duod},
  {"MicroProt_jeju", (PVOID) &MicroProt_jeju, ID_PARM | ID_MicroProt_jeju},
  {"MicroProt_ileon", (PVOID) &MicroProt_ileon, ID_PARM | ID_MicroProt_ileon},
  {"MicroProt_cecum", (PVOID) &MicroProt_cecum, ID_PARM | ID_MicroProt_cecum},
  {"MicroProt_colon", (PVOID) &MicroProt_colon, ID_PARM | ID_MicroProt_colon},
  {"V_ep", (PVOID) &V_ep, ID_PARM | ID_V_ep},
  {"MM", (PVOID) &MM, ID_PARM | ID_MM},
  {"f_Abs_stom", (PVOID) &f_Abs_stom, ID_PARM | ID_f_Abs_stom},
  {"f_Abs_duod", (PVOID) &f_Abs_duod, ID_PARM | ID_f_Abs_duod},
  {"f_Abs_jeju", (PVOID) &f_Abs_jeju, ID_PARM | ID_f_Abs_jeju},
  {"f_Abs_ileon", (PVOID) &f_Abs_ileon, ID_PARM | ID_f_Abs_ileon},
  {"f_Abs_cecum", (PVOID) &f_Abs_cecum, ID_PARM | ID_f_Abs_cecum},
  {"f_Abs_colon", (PVOID) &f_Abs_colon, ID_PARM | ID_f_Abs_colon},
  {"Peff", (PVOID) &Peff, ID_PARM | ID_Peff},
  {"Ratio_BP", (PVOID) &Ratio_BP, ID_PARM | ID_Ratio_BP},
  {"PC_adip", (PVOID) &PC_adip, ID_PARM | ID_PC_adip},
  {"PC_rpt", (PVOID) &PC_rpt, ID_PARM | ID_PC_rpt},
  {"PC_ppt", (PVOID) &PC_ppt, ID_PARM | ID_PC_ppt},
  {"PC_kid", (PVOID) &PC_kid, ID_PARM | ID_PC_kid},
  {"PC_liver", (PVOID) &PC_liver, ID_PARM | ID_PC_liver},
  {"PC_stom", (PVOID) &PC_stom, ID_PARM | ID_PC_stom},
  {"PC_duod", (PVOID) &PC_duod, ID_PARM | ID_PC_duod},
  {"PC_jeju", (PVOID) &PC_jeju, ID_PARM | ID_PC_jeju},
  {"PC_ileon", (PVOID) &PC_ileon, ID_PARM | ID_PC_ileon},
  {"PC_cecum", (PVOID) &PC_cecum, ID_PARM | ID_PC_cecum},
  {"PC_colon", (PVOID) &PC_colon, ID_PARM | ID_PC_colon},
  {"Fu_adip", (PVOID) &Fu_adip, ID_PARM | ID_Fu_adip},
  {"Fu_kid", (PVOID) &Fu_kid, ID_PARM | ID_Fu_kid},
  {"Fu_ppt", (PVOID) &Fu_ppt, ID_PARM | ID_Fu_ppt},
  {"Fu_rpt", (PVOID) &Fu_rpt, ID_PARM | ID_Fu_rpt},
  {"Fu_blood", (PVOID) &Fu_blood, ID_PARM | ID_Fu_blood},
  {"Fu_liver", (PVOID) &Fu_liver, ID_PARM | ID_Fu_liver},
  {"Fu_portvein", (PVOID) &Fu_portvein, ID_PARM | ID_Fu_portvein},
  {"Fu_stom", (PVOID) &Fu_stom, ID_PARM | ID_Fu_stom},
  {"Fu_duod", (PVOID) &Fu_duod, ID_PARM | ID_Fu_duod},
  {"Fu_jeju", (PVOID) &Fu_jeju, ID_PARM | ID_Fu_jeju},
  {"Fu_ileon", (PVOID) &Fu_ileon, ID_PARM | ID_Fu_ileon},
  {"Fu_cecum", (PVOID) &Fu_cecum, ID_PARM | ID_Fu_cecum},
  {"Fu_colon", (PVOID) &Fu_colon, ID_PARM | ID_Fu_colon},
  {"Fu_plasma", (PVOID) &Fu_plasma, ID_PARM | ID_Fu_plasma},
  {"Vmax_vitro", (PVOID) &Vmax_vitro, ID_PARM | ID_Vmax_vitro},
  {"Km_vitro", (PVOID) &Km_vitro, ID_PARM | ID_Km_vitro},
  {"Kle_kid", (PVOID) &Kle_kid, ID_PARM | ID_Kle_kid},
  {"F_total", (PVOID) &F_total, ID_PARM | ID_F_total},
  {"f_Flow_portvein", (PVOID) &f_Flow_portvein, ID_PARM | ID_f_Flow_portvein},
  {"V_adip", (PVOID) &V_adip, ID_PARM | ID_V_adip},
  {"V_blood", (PVOID) &V_blood, ID_PARM | ID_V_blood},
  {"V_kid", (PVOID) &V_kid, ID_PARM | ID_V_kid},
  {"V_liver", (PVOID) &V_liver, ID_PARM | ID_V_liver},
  {"V_rpt", (PVOID) &V_rpt, ID_PARM | ID_V_rpt},
  {"V_ppt", (PVOID) &V_ppt, ID_PARM | ID_V_ppt},
  {"V_stom", (PVOID) &V_stom, ID_PARM | ID_V_stom},
  {"V_duod", (PVOID) &V_duod, ID_PARM | ID_V_duod},
  {"V_jeju", (PVOID) &V_jeju, ID_PARM | ID_V_jeju},
  {"V_ileon", (PVOID) &V_ileon, ID_PARM | ID_V_ileon},
  {"V_cecum", (PVOID) &V_cecum, ID_PARM | ID_V_cecum},
  {"V_colon", (PVOID) &V_colon, ID_PARM | ID_V_colon},
  {"V_stom_w", (PVOID) &V_stom_w, ID_PARM | ID_V_stom_w},
  {"V_duod_w", (PVOID) &V_duod_w, ID_PARM | ID_V_duod_w},
  {"V_jeju_w", (PVOID) &V_jeju_w, ID_PARM | ID_V_jeju_w},
  {"V_ileon_w", (PVOID) &V_ileon_w, ID_PARM | ID_V_ileon_w},
  {"V_cecum_w", (PVOID) &V_cecum_w, ID_PARM | ID_V_cecum_w},
  {"V_colon_w", (PVOID) &V_colon_w, ID_PARM | ID_V_colon_w},
  {"V_stom_lu", (PVOID) &V_stom_lu, ID_PARM | ID_V_stom_lu},
  {"V_colon_lu", (PVOID) &V_colon_lu, ID_PARM | ID_V_colon_lu},
  {"V_duod_lu", (PVOID) &V_duod_lu, ID_PARM | ID_V_duod_lu},
  {"V_jeju_lu", (PVOID) &V_jeju_lu, ID_PARM | ID_V_jeju_lu},
  {"V_ileon_lu", (PVOID) &V_ileon_lu, ID_PARM | ID_V_ileon_lu},
  {"V_cecum_lu", (PVOID) &V_cecum_lu, ID_PARM | ID_V_cecum_lu},
  {"V_stom_ep", (PVOID) &V_stom_ep, ID_PARM | ID_V_stom_ep},
  {"V_duod_ep", (PVOID) &V_duod_ep, ID_PARM | ID_V_duod_ep},
  {"V_jeju_ep", (PVOID) &V_jeju_ep, ID_PARM | ID_V_jeju_ep},
  {"V_ileon_ep", (PVOID) &V_ileon_ep, ID_PARM | ID_V_ileon_ep},
  {"V_cecum_ep", (PVOID) &V_cecum_ep, ID_PARM | ID_V_cecum_ep},
  {"V_colon_ep", (PVOID) &V_colon_ep, ID_PARM | ID_V_colon_ep},
  {"SA_stom", (PVOID) &SA_stom, ID_PARM | ID_SA_stom},
  {"SA_duod", (PVOID) &SA_duod, ID_PARM | ID_SA_duod},
  {"SA_jeju", (PVOID) &SA_jeju, ID_PARM | ID_SA_jeju},
  {"SA_ileon", (PVOID) &SA_ileon, ID_PARM | ID_SA_ileon},
  {"SA_cecum", (PVOID) &SA_cecum, ID_PARM | ID_SA_cecum},
  {"SA_colon", (PVOID) &SA_colon, ID_PARM | ID_SA_colon},
  {"Flow_adip", (PVOID) &Flow_adip, ID_PARM | ID_Flow_adip},
  {"Flow_kid", (PVOID) &Flow_kid, ID_PARM | ID_Flow_kid},
  {"Flow_liver", (PVOID) &Flow_liver, ID_PARM | ID_Flow_liver},
  {"Flow_liver_art", (PVOID) &Flow_liver_art, ID_PARM | ID_Flow_liver_art},
  {"Flow_rpt", (PVOID) &Flow_rpt, ID_PARM | ID_Flow_rpt},
  {"Flow_ppt", (PVOID) &Flow_ppt, ID_PARM | ID_Flow_ppt},
  {"Flow_portvein", (PVOID) &Flow_portvein, ID_PARM | ID_Flow_portvein},
  {"Flow_stom", (PVOID) &Flow_stom, ID_PARM | ID_Flow_stom},
  {"Flow_duod", (PVOID) &Flow_duod, ID_PARM | ID_Flow_duod},
  {"Flow_jeju", (PVOID) &Flow_jeju, ID_PARM | ID_Flow_jeju},
  {"Flow_ileon", (PVOID) &Flow_ileon, ID_PARM | ID_Flow_ileon},
  {"Flow_cecum", (PVOID) &Flow_cecum, ID_PARM | ID_Flow_cecum},
  {"Flow_colon", (PVOID) &Flow_colon, ID_PARM | ID_Flow_colon},
  {"Kle_stom", (PVOID) &Kle_stom, ID_PARM | ID_Kle_stom},
  {"Kle_duod", (PVOID) &Kle_duod, ID_PARM | ID_Kle_duod},
  {"Kle_jeju", (PVOID) &Kle_jeju, ID_PARM | ID_Kle_jeju},
  {"Kle_ileon", (PVOID) &Kle_ileon, ID_PARM | ID_Kle_ileon},
  {"Kle_cecum", (PVOID) &Kle_cecum, ID_PARM | ID_Kle_cecum},
  {"Kle_colon", (PVOID) &Kle_colon, ID_PARM | ID_Kle_colon},
  {"Vmax_vivo_liver", (PVOID) &Vmax_vivo_liver, ID_PARM | ID_Vmax_vivo_liver},
  {"Vmax_vivo_stom", (PVOID) &Vmax_vivo_stom, ID_PARM | ID_Vmax_vivo_stom},
  {"Vmax_vivo_duod", (PVOID) &Vmax_vivo_duod, ID_PARM | ID_Vmax_vivo_duod},
  {"Vmax_vivo_jeju", (PVOID) &Vmax_vivo_jeju, ID_PARM | ID_Vmax_vivo_jeju},
  {"Vmax_vivo_ileon", (PVOID) &Vmax_vivo_ileon, ID_PARM | ID_Vmax_vivo_ileon},
  {"Vmax_vivo_cecum", (PVOID) &Vmax_vivo_cecum, ID_PARM | ID_Vmax_vivo_cecum},
  {"Vmax_vivo_colon", (PVOID) &Vmax_vivo_colon, ID_PARM | ID_Vmax_vivo_colon},
  {"Km_vivo", (PVOID) &Km_vivo, ID_PARM | ID_Km_vivo},
  {"", NULL, 0} /* End flag */
};  /* vrgpvmGlo[] */


/*----- InitModel
   Should be called to initialize model variables at
   the beginning of experiment before reading
   variants from the simulation spec file.
*/

void InitModel(void)
{
  /* Initialize things in the order that they appear in
     model definition file so that dependencies are
     handled correctly. */

  vrgModelVars[ID_A_kid] = 0.0;
  vrgModelVars[ID_A_rpt] = 0.0;
  vrgModelVars[ID_A_liver] = 0.0;
  vrgModelVars[ID_A_adip] = 0.0;
  vrgModelVars[ID_A_ppt] = 0.0;
  vrgModelVars[ID_A_blood] = 0.0;
  vrgModelVars[ID_A_stom_lu] = 0.0;
  vrgModelVars[ID_A_duod_lu] = 0.0;
  vrgModelVars[ID_A_jeju_lu] = 0.0;
  vrgModelVars[ID_A_ileon_lu] = 0.0;
  vrgModelVars[ID_A_cecum_lu] = 0.0;
  vrgModelVars[ID_A_colon_lu] = 0.0;
  vrgModelVars[ID_A_stom_ep] = 0.0;
  vrgModelVars[ID_A_duod_ep] = 0.0;
  vrgModelVars[ID_A_jeju_ep] = 0.0;
  vrgModelVars[ID_A_ileon_ep] = 0.0;
  vrgModelVars[ID_A_cecum_ep] = 0.0;
  vrgModelVars[ID_A_colon_ep] = 0.0;
  vrgModelVars[ID_A_stom_w] = 0.0;
  vrgModelVars[ID_A_duod_w] = 0.0;
  vrgModelVars[ID_A_jeju_w] = 0.0;
  vrgModelVars[ID_A_ileon_w] = 0.0;
  vrgModelVars[ID_A_cecum_w] = 0.0;
  vrgModelVars[ID_A_colon_w] = 0.0;
  vrgModelVars[ID_A_absorb_stom] = 0.0;
  vrgModelVars[ID_A_absorb_duod] = 0.0;
  vrgModelVars[ID_A_absorb_jeju] = 0.0;
  vrgModelVars[ID_A_absorb_ileon] = 0.0;
  vrgModelVars[ID_A_absorb_cecum] = 0.0;
  vrgModelVars[ID_A_absorb_colon] = 0.0;
  vrgModelVars[ID_A_absorb_pv] = 0.0;
  vrgModelVars[ID_A_elim_kid] = 0.0;
  vrgModelVars[ID_A_met_liver] = 0.0;
  vrgModelVars[ID_A_met_stom] = 0.0;
  vrgModelVars[ID_A_met_duod] = 0.0;
  vrgModelVars[ID_A_met_jeju] = 0.0;
  vrgModelVars[ID_A_met_ileon] = 0.0;
  vrgModelVars[ID_A_met_cecum] = 0.0;
  vrgModelVars[ID_A_met_colon] = 0.0;
  vrgModelVars[ID_A_feces] = 0.0;
  vrgModelVars[ID_AUC_blood] = 0.0;
  vrgModelVars[ID_AUC_liver] = 0.0;
  vrgModelVars[ID_C_plasma] = 0.0;
  vrgModelVars[ID_C_kid] = 0.0;
  vrgModelVars[ID_C_rpt] = 0.0;
  vrgModelVars[ID_C_liver] = 0.0;
  vrgModelVars[ID_C_adip] = 0.0;
  vrgModelVars[ID_C_ppt] = 0.0;
  vrgModelVars[ID_C_blood] = 0.0;
  vrgModelVars[ID_C_stom_lu] = 0.0;
  vrgModelVars[ID_C_duod_lu] = 0.0;
  vrgModelVars[ID_C_jeju_lu] = 0.0;
  vrgModelVars[ID_C_ileon_lu] = 0.0;
  vrgModelVars[ID_C_cecum_lu] = 0.0;
  vrgModelVars[ID_C_colon_lu] = 0.0;
  vrgModelVars[ID_C_stom_ep] = 0.0;
  vrgModelVars[ID_C_duod_ep] = 0.0;
  vrgModelVars[ID_C_jeju_ep] = 0.0;
  vrgModelVars[ID_C_ileon_ep] = 0.0;
  vrgModelVars[ID_C_cecum_ep] = 0.0;
  vrgModelVars[ID_C_colon_ep] = 0.0;
  vrgModelVars[ID_C_stom_w] = 0.0;
  vrgModelVars[ID_C_duod_w] = 0.0;
  vrgModelVars[ID_C_jeju_w] = 0.0;
  vrgModelVars[ID_C_ileon_w] = 0.0;
  vrgModelVars[ID_C_cecum_w] = 0.0;
  vrgModelVars[ID_C_colon_w] = 0.0;
  vrgModelVars[ID_A_gi_lu] = 0.0;
  vrgModelVars[ID_A_gi_ep] = 0.0;
  vrgModelVars[ID_A_gi_w] = 0.0;
  vrgModelVars[ID_A_absorb] = 0.0;
  vrgModelVars[ID_A_elim] = 0.0;
  vrgModelVars[ID_A_elim_gi] = 0.0;
  vrgModelVars[ID_A_organ] = 0.0;
  vrgModelVars[ID_A_total] = 0.0;
  vrgModelVars[ID_Instant_Ka_gi] = 0.0;
  vrgInputs[ID_Oral_dose_rate].iType = IFN_PERDOSE;
  vrgInputs[ID_Oral_dose_rate].dTStartPeriod = 0;
  vrgInputs[ID_Oral_dose_rate].bOn = FALSE;
  vrgInputs[ID_Oral_dose_rate].dMag = 0.000000;
  vrgInputs[ID_Oral_dose_rate].dT0 = 0.000000;
  vrgInputs[ID_Oral_dose_rate].dTexp = 0.000000;
  vrgInputs[ID_Oral_dose_rate].dDecay = 0.000000;
  vrgInputs[ID_Oral_dose_rate].dTper = 0.000000;
  vrgInputs[ID_Oral_dose_rate].hMag = 0x4004d;
  vrgInputs[ID_Oral_dose_rate].hT0 = 0x4004e;
  vrgInputs[ID_Oral_dose_rate].hTexp = 0x40050;
  vrgInputs[ID_Oral_dose_rate].hDecay = 0;
  vrgInputs[ID_Oral_dose_rate].hTper = 0x4004f;
  vrgInputs[ID_Oral_dose_rate].dVal = 0.0;
  vrgInputs[ID_Oral_dose_rate].nDoses = 0;
  InDose = 0.0;
  Tlag = 0.0;
  Period = 0.0;
  Exposure = 0.0;
  BDM = 0;
  sc_F_total = 15;
  f_Flow_adip = 0.06;
  f_Flow_kid = 0.21;
  f_Flow_ppt = 0.20;
  f_Flow_liver_art = 0.077;
  f_Flow_stom = 0.024;
  f_Flow_duod = 0.016;
  f_Flow_jeju = 0.056;
  f_Flow_ileon = 0.033;
  f_Flow_cecum = 0.006;
  f_Flow_colon = 0.038;
  f_BDM_adip = 0.16;
  f_BDM_blood = 0.065;
  f_BDM_kid = 0.0096;
  f_BDM_rpt = 0.1;
  f_BDM_liver = 0.0243;
  f_BDM_stom = 0.0021;
  f_BDM_duod = 0.0003;
  f_BDM_jeju = 0.0009;
  f_BDM_ileon = 0.0006;
  f_BDM_cecum = 0.0005;
  f_BDM_colon = 0.0048;
  f_BDM_stom_lu = 0.0036;
  f_BDM_duod_lu = 0.0003;
  f_BDM_jeju_lu = 0.0023;
  f_BDM_ileon_lu = 0.0032;
  f_BDM_cecum_lu = 0.0001;
  f_BDM_colon_lu = 0.0051;
  Length_stom = 2.5;
  Length_duod = 2.5;
  Length_jeju = 20;
  Length_ileon = 30;
  Length_cecum = 1.7;
  Length_colon = 12.5;
  Radius_stom = 0.85;
  Radius_duod = 0.2;
  Radius_jeju = 0.18;
  Radius_ileon = 0.15;
  Radius_cecum = 0.35;
  Radius_colon = 0.25;
  T12_stom_lu = 0.25;
  T12_duod_lu = 0.25;
  T12_jeju_lu = 1.02;
  T12_ileon_lu = 2.04;
  T12_cecum_lu = 4.55;
  T12_colon_lu = 13.5;
  PH_stom = 1.7;
  PH_duod = 6;
  PH_jeju = 6.5;
  PH_ileon = 7.4;
  PH_cecum = 5.9;
  PH_colon = 7;
  MicroProt_liver = 45;
  MicroProt_stom = 0;
  MicroProt_duod = 9.45;
  MicroProt_jeju = 8.82;
  MicroProt_ileon = 1.62;
  MicroProt_cecum = 0.0;
  MicroProt_colon = 0.0;
  V_ep = 5.25E-4;
  MM = 0;
  f_Abs_stom = 0;
  f_Abs_duod = 0;
  f_Abs_jeju = 0;
  f_Abs_ileon = 0;
  f_Abs_cecum = 0;
  f_Abs_colon = 0;
  Peff = 0;
  Ratio_BP = 0;
  PC_adip = 0;
  PC_rpt = 0;
  PC_ppt = 0;
  PC_kid = 0;
  PC_liver = 0;
  PC_stom = 0;
  PC_duod = 0;
  PC_jeju = 0;
  PC_ileon = 0;
  PC_cecum = 0;
  PC_colon = 0;
  Fu_adip = 1.0;
  Fu_kid = 1.0;
  Fu_ppt = 1.0;
  Fu_rpt = 1.0;
  Fu_blood = 1.0;
  Fu_liver = 1.0;
  Fu_portvein = 1.0;
  Fu_stom = 1.0;
  Fu_duod = 1.0;
  Fu_jeju = 1.0;
  Fu_ileon = 1.0;
  Fu_cecum = 1.0;
  Fu_colon = 1.0;
  Fu_plasma = 1.0;
  Vmax_vitro = 0;
  Km_vitro = 0;
  Kle_kid = 0;
  F_total = 0;
  f_Flow_portvein = 0;
  V_adip = 0;
  V_blood = 0;
  V_kid = 0;
  V_liver = 0;
  V_rpt = 0;
  V_ppt = 0;
  V_stom = 0;
  V_duod = 0;
  V_jeju = 0;
  V_ileon = 0;
  V_cecum = 0;
  V_colon = 0;
  V_stom_w = 0;
  V_duod_w = 0;
  V_jeju_w = 0;
  V_ileon_w = 0;
  V_cecum_w = 0;
  V_colon_w = 0;
  V_stom_lu = 0;
  V_colon_lu = 0;
  V_duod_lu = 0;
  V_jeju_lu = 0;
  V_ileon_lu = 0;
  V_cecum_lu = 0;
  V_stom_ep = 0;
  V_duod_ep = 0;
  V_jeju_ep = 0;
  V_ileon_ep = 0;
  V_cecum_ep = 0;
  V_colon_ep = 0;
  SA_stom = 0;
  SA_duod = 0;
  SA_jeju = 0;
  SA_ileon = 0;
  SA_cecum = 0;
  SA_colon = 0;
  Flow_adip = 0;
  Flow_kid = 0;
  Flow_liver = 0;
  Flow_liver_art = 0;
  Flow_rpt = 0;
  Flow_ppt = 0;
  Flow_portvein = 0;
  Flow_stom = 0;
  Flow_duod = 0;
  Flow_jeju = 0;
  Flow_ileon = 0;
  Flow_cecum = 0;
  Flow_colon = 0;
  Kle_stom = 0;
  Kle_duod = 0;
  Kle_jeju = 0;
  Kle_ileon = 0;
  Kle_cecum = 0;
  Kle_colon = 0;
  Vmax_vivo_liver = 0;
  Vmax_vivo_stom = 0;
  Vmax_vivo_duod = 0;
  Vmax_vivo_jeju = 0;
  Vmax_vivo_ileon = 0;
  Vmax_vivo_cecum = 0;
  Vmax_vivo_colon = 0;
  Km_vivo = 0;

  vbModelReinitd = TRUE;

} /* InitModel */


/*----- Dynamics section */

void CalcDeriv (double  rgModelVars[], double  rgDerivs[], PDOUBLE pdTime)
{
  /* local */ double Ctb_kid;
  /* local */ double Ctb_liver;
  /* local */ double Ctb_rpt;
  /* local */ double Ctb_ppt;
  /* local */ double Ctb_adip;
  /* local */ double Ctb_stom_w;
  /* local */ double Ctb_duod_w;
  /* local */ double Ctb_jeju_w;
  /* local */ double Ctb_ileon_w;
  /* local */ double Ctb_cecum_w;
  /* local */ double Ctb_colon_w;
  /* local */ double Rate_stl2dul;
  /* local */ double Rate_dul2jel;
  /* local */ double Rate_jel2ill;
  /* local */ double Rate_ill2cel;
  /* local */ double Rate_cel2col;
  /* local */ double Rate_col2fel;
  /* local */ double Rate_stl2ste;
  /* local */ double Rate_dul2due;
  /* local */ double Rate_jel2jee;
  /* local */ double Rate_ill2ile;
  /* local */ double Rate_cel2cee;
  /* local */ double Rate_col2coe;
  /* local */ double Rate_ste2stw;
  /* local */ double Rate_due2duw;
  /* local */ double Rate_jee2jew;
  /* local */ double Rate_ile2ilw;
  /* local */ double Rate_cee2cew;
  /* local */ double Rate_coe2cow;
  /* local */ double Rate_stw2pv;
  /* local */ double Rate_duw2pv;
  /* local */ double Rate_jew2pv;
  /* local */ double Rate_ilw2pv;
  /* local */ double Rate_cew2pv;
  /* local */ double Rate_cow2pv;
  /* local */ double RateIn_portvein;
  /* local */ double Ctb_portvein;

  CalcInputs (pdTime); /* Get new input vals */


  rgModelVars[ID_C_adip] = rgModelVars[ID_A_adip] / V_adip ;

  rgModelVars[ID_C_kid] = rgModelVars[ID_A_kid] / V_kid ;

  rgModelVars[ID_C_rpt] = rgModelVars[ID_A_rpt] / V_rpt ;

  rgModelVars[ID_C_ppt] = rgModelVars[ID_A_ppt] / V_ppt ;

  rgModelVars[ID_C_liver] = rgModelVars[ID_A_liver] / V_liver ;

  rgModelVars[ID_C_stom_w] = rgModelVars[ID_A_stom_w] / V_stom_w ;

  rgModelVars[ID_C_duod_w] = rgModelVars[ID_A_duod_w] / V_duod_w ;

  rgModelVars[ID_C_jeju_w] = rgModelVars[ID_A_jeju_w] / V_jeju_w ;

  rgModelVars[ID_C_ileon_w] = rgModelVars[ID_A_ileon_w] / V_ileon_w ;

  rgModelVars[ID_C_cecum_w] = rgModelVars[ID_A_cecum_w] / V_cecum_w ;

  rgModelVars[ID_C_colon_w] = rgModelVars[ID_A_colon_w] / V_colon_w ;

  rgModelVars[ID_C_blood] = rgModelVars[ID_A_blood] / V_blood ;

  Ctb_kid = rgModelVars[ID_C_kid] / PC_kid ;

  Ctb_liver = rgModelVars[ID_C_liver] / PC_liver ;

  Ctb_rpt = rgModelVars[ID_C_rpt] / PC_rpt ;

  Ctb_ppt = rgModelVars[ID_C_ppt] / PC_ppt ;

  Ctb_adip = rgModelVars[ID_C_adip] / PC_adip ;

  Ctb_stom_w = rgModelVars[ID_C_stom_w] / PC_stom ;

  Ctb_duod_w = rgModelVars[ID_C_duod_w] / PC_duod ;

  Ctb_jeju_w = rgModelVars[ID_C_jeju_w] / PC_jeju ;

  Ctb_ileon_w = rgModelVars[ID_C_ileon_w] / PC_ileon ;

  Ctb_cecum_w = rgModelVars[ID_C_cecum_w] / PC_cecum ;

  Ctb_colon_w = rgModelVars[ID_C_colon_w] / PC_colon ;

  rgModelVars[ID_C_stom_lu] = rgModelVars[ID_A_stom_lu] / V_stom_lu ;

  rgModelVars[ID_C_duod_lu] = rgModelVars[ID_A_duod_lu] / V_duod_lu ;

  rgModelVars[ID_C_jeju_lu] = rgModelVars[ID_A_jeju_lu] / V_jeju_lu ;

  rgModelVars[ID_C_ileon_lu] = rgModelVars[ID_A_ileon_lu] / V_ileon_lu ;

  rgModelVars[ID_C_cecum_lu] = rgModelVars[ID_A_cecum_lu] / V_cecum_lu ;

  rgModelVars[ID_C_colon_lu] = rgModelVars[ID_A_colon_lu] / V_colon_lu ;

  rgModelVars[ID_C_stom_ep] = rgModelVars[ID_A_stom_ep] / V_stom_ep ;

  rgModelVars[ID_C_duod_ep] = rgModelVars[ID_A_duod_ep] / V_duod_ep ;

  rgModelVars[ID_C_jeju_ep] = rgModelVars[ID_A_jeju_ep] / V_jeju_ep ;

  rgModelVars[ID_C_ileon_ep] = rgModelVars[ID_A_ileon_ep] / V_ileon_ep ;

  rgModelVars[ID_C_cecum_ep] = rgModelVars[ID_A_cecum_ep] / V_cecum_ep ;

  rgModelVars[ID_C_colon_ep] = rgModelVars[ID_A_colon_ep] / V_colon_ep ;

  Rate_stl2dul = ( log ( 2.0 ) * V_stom_lu / T12_stom_lu ) * rgModelVars[ID_C_stom_lu] ;

  Rate_dul2jel = ( log ( 2.0 ) * V_duod_lu / T12_duod_lu ) * rgModelVars[ID_C_duod_lu] ;

  Rate_jel2ill = ( log ( 2.0 ) * V_jeju_lu / T12_jeju_lu ) * rgModelVars[ID_C_jeju_lu] ;

  Rate_ill2cel = ( log ( 2.0 ) * V_ileon_lu / T12_ileon_lu ) * rgModelVars[ID_C_ileon_lu] ;

  Rate_cel2col = ( log ( 2.0 ) * V_cecum_lu / T12_cecum_lu ) * rgModelVars[ID_C_cecum_lu] ;

  Rate_col2fel = ( log ( 2.0 ) * V_colon_lu / T12_colon_lu ) * rgModelVars[ID_C_colon_lu] ;

  Rate_stl2ste = Kle_stom * ( rgModelVars[ID_C_stom_lu] - rgModelVars[ID_C_stom_ep] ) ;

  Rate_dul2due = Kle_duod * ( rgModelVars[ID_C_duod_lu] - rgModelVars[ID_C_duod_ep] ) ;

  Rate_jel2jee = Kle_jeju * ( rgModelVars[ID_C_jeju_lu] - rgModelVars[ID_C_jeju_ep] ) ;

  Rate_ill2ile = Kle_ileon * ( rgModelVars[ID_C_ileon_lu] - rgModelVars[ID_C_ileon_ep] ) ;

  Rate_cel2cee = Kle_cecum * ( rgModelVars[ID_C_cecum_lu] - rgModelVars[ID_C_cecum_ep] ) ;

  Rate_col2coe = Kle_colon * ( rgModelVars[ID_C_colon_lu] - rgModelVars[ID_C_colon_ep] ) ;

  Rate_ste2stw = Kle_stom * ( rgModelVars[ID_C_stom_ep] - Ctb_stom_w ) ;

  Rate_due2duw = Kle_duod * ( rgModelVars[ID_C_duod_ep] - Ctb_duod_w ) ;

  Rate_jee2jew = Kle_jeju * ( rgModelVars[ID_C_jeju_ep] - Ctb_jeju_w ) ;

  Rate_ile2ilw = Kle_ileon * ( rgModelVars[ID_C_ileon_ep] - Ctb_ileon_w ) ;

  Rate_cee2cew = Kle_cecum * ( rgModelVars[ID_C_cecum_ep] - Ctb_cecum_w ) ;

  Rate_coe2cow = Kle_colon * ( rgModelVars[ID_C_colon_ep] - Ctb_colon_w ) ;

  Rate_stw2pv = Flow_stom * Ctb_stom_w ;

  Rate_duw2pv = Flow_duod * Ctb_duod_w ;

  Rate_jew2pv = Flow_jeju * Ctb_jeju_w ;

  Rate_ilw2pv = Flow_ileon * Ctb_ileon_w ;

  Rate_cew2pv = Flow_cecum * Ctb_cecum_w ;

  Rate_cow2pv = Flow_colon * Ctb_colon_w ;

  RateIn_portvein = Rate_stw2pv + Rate_duw2pv + Rate_jew2pv + Rate_ilw2pv + Rate_cew2pv + Rate_cow2pv ;

  Ctb_portvein = RateIn_portvein / Flow_portvein ;

  rgDerivs[ID_A_absorb_stom] = Rate_stl2ste ;

  rgDerivs[ID_A_absorb_duod] = Rate_dul2due ;

  rgDerivs[ID_A_absorb_jeju] = Rate_jel2jee ;

  rgDerivs[ID_A_absorb_ileon] = Rate_ill2ile ;

  rgDerivs[ID_A_absorb_cecum] = Rate_cel2cee ;

  rgDerivs[ID_A_absorb_colon] = Rate_col2coe ;

  rgDerivs[ID_A_absorb_pv] = RateIn_portvein ;

  rgDerivs[ID_A_elim_kid] = Kle_kid * Ctb_kid * Fu_kid ;

  rgDerivs[ID_A_met_liver] = Vmax_vivo_liver * Ctb_liver / ( Km_vivo + Ctb_liver ) ;

  rgDerivs[ID_A_met_stom] = Vmax_vivo_stom * rgModelVars[ID_C_stom_ep] / ( Km_vivo + rgModelVars[ID_C_stom_ep] ) ;

  rgDerivs[ID_A_met_duod] = Vmax_vivo_duod * rgModelVars[ID_C_duod_ep] / ( Km_vivo + rgModelVars[ID_C_duod_ep] ) ;

  rgDerivs[ID_A_met_jeju] = Vmax_vivo_jeju * rgModelVars[ID_C_jeju_ep] / ( Km_vivo + rgModelVars[ID_C_jeju_ep] ) ;

  rgDerivs[ID_A_met_ileon] = Vmax_vivo_ileon * rgModelVars[ID_C_ileon_ep] / ( Km_vivo + rgModelVars[ID_C_ileon_ep] ) ;

  rgDerivs[ID_A_met_cecum] = Vmax_vivo_cecum * rgModelVars[ID_C_cecum_ep] / ( Km_vivo + rgModelVars[ID_C_cecum_ep] ) ;

  rgDerivs[ID_A_met_colon] = Vmax_vivo_colon * rgModelVars[ID_C_colon_ep] / ( Km_vivo + rgModelVars[ID_C_colon_ep] ) ;

  rgDerivs[ID_A_feces] = Rate_col2fel ;

  rgDerivs[ID_A_kid] = Flow_kid * ( rgModelVars[ID_C_blood] - Ctb_kid ) - rgDerivs[ID_A_elim_kid] ;

  rgDerivs[ID_A_adip] = Flow_adip * ( rgModelVars[ID_C_blood] - Ctb_adip ) ;

  rgDerivs[ID_A_ppt] = Flow_ppt * ( rgModelVars[ID_C_blood] - Ctb_ppt ) ;

  rgDerivs[ID_A_rpt] = Flow_rpt * ( rgModelVars[ID_C_blood] - Ctb_rpt ) ;

  rgDerivs[ID_A_liver] = Flow_liver_art * rgModelVars[ID_C_blood] + Flow_portvein * Ctb_portvein - Flow_liver * Ctb_liver - rgDerivs[ID_A_met_liver] ;

  rgDerivs[ID_A_blood] = Flow_rpt * Ctb_rpt + Flow_ppt * Ctb_ppt + Flow_adip * Ctb_adip + Flow_liver * Ctb_liver + Flow_kid * Ctb_kid - F_total * rgModelVars[ID_C_blood] ;

  rgDerivs[ID_A_stom_lu] = vrgInputs[ID_Oral_dose_rate].dVal - Rate_stl2dul - Rate_stl2ste ;

  rgDerivs[ID_A_stom_ep] = Rate_stl2ste - Rate_ste2stw - rgDerivs[ID_A_met_stom] ;

  rgDerivs[ID_A_stom_w] = Flow_stom * rgModelVars[ID_C_blood] + Rate_ste2stw - Rate_stw2pv ;

  rgDerivs[ID_A_duod_lu] = Rate_stl2dul - Rate_dul2jel - Rate_dul2due ;

  rgDerivs[ID_A_duod_ep] = Rate_dul2due - Rate_due2duw - rgDerivs[ID_A_met_duod] ;

  rgDerivs[ID_A_duod_w] = Flow_duod * rgModelVars[ID_C_blood] + Rate_due2duw - Rate_duw2pv ;

  rgDerivs[ID_A_jeju_lu] = Rate_dul2jel - Rate_jel2ill - Rate_jel2jee ;

  rgDerivs[ID_A_jeju_ep] = Rate_jel2jee - Rate_jee2jew - rgDerivs[ID_A_met_jeju] ;

  rgDerivs[ID_A_jeju_w] = Flow_jeju * rgModelVars[ID_C_blood] + Rate_jee2jew - Rate_jew2pv ;

  rgDerivs[ID_A_ileon_lu] = Rate_jel2ill - Rate_ill2cel - Rate_ill2ile ;

  rgDerivs[ID_A_ileon_ep] = Rate_ill2ile - Rate_ile2ilw - rgDerivs[ID_A_met_ileon] ;

  rgDerivs[ID_A_ileon_w] = Flow_ileon * rgModelVars[ID_C_blood] + Rate_ile2ilw - Rate_ilw2pv ;

  rgDerivs[ID_A_cecum_lu] = Rate_ill2cel - Rate_cel2col - Rate_cel2cee ;

  rgDerivs[ID_A_cecum_ep] = Rate_cel2cee - Rate_cee2cew - rgDerivs[ID_A_met_cecum] ;

  rgDerivs[ID_A_cecum_w] = Flow_cecum * rgModelVars[ID_C_blood] + Rate_cee2cew - Rate_cew2pv ;

  rgDerivs[ID_A_colon_lu] = Rate_cel2col - Rate_col2coe - rgDerivs[ID_A_feces] ;

  rgDerivs[ID_A_colon_ep] = Rate_col2coe - Rate_coe2cow - rgDerivs[ID_A_met_colon] ;

  rgDerivs[ID_A_colon_w] = Flow_colon * rgModelVars[ID_C_blood] + Rate_coe2cow - Rate_cow2pv ;

  rgDerivs[ID_AUC_blood] = rgModelVars[ID_C_blood] ;

  rgDerivs[ID_AUC_liver] = rgModelVars[ID_C_liver] ;

} /* CalcDeriv */


/*----- Model scaling */

void ScaleModel (PDOUBLE pdTime)
{

  F_total = sc_F_total * pow ( BDM , 0.75 ) ;

  V_adip = BDM * f_BDM_adip ;
  V_blood = BDM * f_BDM_blood ;
  V_kid = BDM * f_BDM_kid ;
  V_liver = BDM * f_BDM_liver ;
  V_rpt = BDM * f_BDM_rpt ;
  V_stom_w = BDM * f_BDM_stom ;
  V_duod_w = BDM * f_BDM_duod ;
  V_jeju_w = BDM * f_BDM_jeju ;
  V_ileon_w = BDM * f_BDM_ileon ;
  V_cecum_w = BDM * f_BDM_cecum ;
  V_colon_w = BDM * f_BDM_colon ;

  V_ppt = BDM * ( 1 - f_BDM_adip - f_BDM_blood - f_BDM_kid - f_BDM_liver - f_BDM_rpt - f_BDM_stom - f_BDM_duod - f_BDM_jeju - f_BDM_ileon - f_BDM_cecum - f_BDM_colon ) ;

  f_Flow_portvein = f_Flow_stom + f_Flow_duod + f_Flow_jeju + f_Flow_ileon + f_Flow_cecum + f_Flow_colon ;

  Flow_adip = F_total * f_Flow_adip ;
  Flow_kid = F_total * f_Flow_kid ;
  Flow_ppt = F_total * f_Flow_ppt ;
  Flow_liver_art = F_total * f_Flow_liver_art ;
  Flow_portvein = F_total * f_Flow_portvein ;
  Flow_stom = F_total * f_Flow_stom ;
  Flow_duod = F_total * f_Flow_duod ;
  Flow_jeju = F_total * f_Flow_jeju ;
  Flow_ileon = F_total * f_Flow_ileon ;
  Flow_cecum = F_total * f_Flow_cecum ;
  Flow_colon = F_total * f_Flow_colon ;

  Flow_liver = Flow_liver_art + Flow_portvein ;

  Flow_rpt = F_total - Flow_adip - Flow_kid - Flow_ppt - Flow_liver ;

  SA_stom = Length_stom * 2 * 3.1416 * Radius_stom ;
  SA_duod = Length_duod * 2 * 3.1416 * Radius_duod ;
  SA_jeju = Length_jeju * 2 * 3.1416 * Radius_jeju ;
  SA_ileon = Length_ileon * 2 * 3.1416 * Radius_ileon ;
  SA_cecum = Length_cecum * 2 * 3.1416 * Radius_cecum ;
  SA_colon = Length_colon * 2 * 3.1416 * Radius_colon ;

  V_stom_lu = f_BDM_stom_lu * BDM ;
  V_duod_lu = f_BDM_duod_lu * BDM ;
  V_jeju_lu = f_BDM_jeju_lu * BDM ;
  V_ileon_lu = f_BDM_ileon_lu * BDM ;
  V_cecum_lu = f_BDM_cecum_lu * BDM ;
  V_colon_lu = f_BDM_colon_lu * BDM ;

  V_stom_ep = V_ep * SA_stom ;
  V_duod_ep = V_ep * SA_duod ;
  V_jeju_ep = V_ep * SA_jeju ;
  V_ileon_ep = V_ep * SA_ileon ;
  V_cecum_ep = V_ep * SA_cecum ;
  V_colon_ep = V_ep * SA_colon ;

  Vmax_vivo_liver = Vmax_vitro * 60 * MM * MicroProt_liver * V_liver ;
  Vmax_vivo_stom = Vmax_vitro * 60 * MM * MicroProt_stom * V_stom_ep ;
  Vmax_vivo_duod = Vmax_vitro * 60 * MM * MicroProt_duod * V_duod_ep ;
  Vmax_vivo_jeju = Vmax_vitro * 60 * MM * MicroProt_jeju * V_jeju_ep ;
  Vmax_vivo_ileon = Vmax_vitro * 60 * MM * MicroProt_ileon * V_ileon_ep ;
  Vmax_vivo_cecum = Vmax_vitro * 60 * MM * MicroProt_cecum * V_cecum_ep ;
  Vmax_vivo_colon = Vmax_vitro * 60 * MM * MicroProt_colon * V_colon_ep ;

  Km_vivo = Km_vitro * MM ;

  Kle_stom = Peff * SA_stom * f_Abs_stom ;
  Kle_duod = Peff * SA_duod * f_Abs_duod ;
  Kle_jeju = Peff * SA_jeju * f_Abs_jeju ;
  Kle_ileon = Peff * SA_ileon * f_Abs_ileon ;
  Kle_cecum = Peff * SA_cecum * f_Abs_cecum ;
  Kle_colon = Peff * SA_colon * f_Abs_colon ;

} /* ScaleModel */


/*----- Jacobian calculations */

void CalcJacob (PDOUBLE pdTime, double rgModelVars[],
                long column, double rgdJac[])
{

} /* CalcJacob */


/*----- Outputs calculations */

void CalcOutputs (double  rgModelVars[], double  rgDerivs[], PDOUBLE pdTime)
{

  rgModelVars[ID_C_plasma] = ( rgModelVars[ID_C_blood] > 0 ? rgModelVars[ID_C_blood] / Ratio_BP : 1E-10 ) ;

  rgModelVars[ID_A_gi_lu] = rgModelVars[ID_A_stom_lu] + rgModelVars[ID_A_duod_lu] + rgModelVars[ID_A_jeju_lu] + rgModelVars[ID_A_ileon_lu] + rgModelVars[ID_A_cecum_lu] + rgModelVars[ID_A_colon_lu] ;

  rgModelVars[ID_A_gi_ep] = rgModelVars[ID_A_stom_ep] + rgModelVars[ID_A_duod_ep] + rgModelVars[ID_A_jeju_ep] + rgModelVars[ID_A_ileon_ep] + rgModelVars[ID_A_cecum_ep] + rgModelVars[ID_A_colon_ep] ;

  rgModelVars[ID_A_gi_w] = rgModelVars[ID_A_stom_w] + rgModelVars[ID_A_duod_w] + rgModelVars[ID_A_jeju_w] + rgModelVars[ID_A_ileon_w] + rgModelVars[ID_A_cecum_w] + rgModelVars[ID_A_colon_w] ;

  rgModelVars[ID_A_absorb] = rgModelVars[ID_A_absorb_stom] + rgModelVars[ID_A_absorb_duod] + rgModelVars[ID_A_absorb_jeju] + rgModelVars[ID_A_absorb_ileon] + rgModelVars[ID_A_absorb_cecum] + rgModelVars[ID_A_absorb_colon] ;

  rgModelVars[ID_A_elim_gi] = rgModelVars[ID_A_met_stom] + rgModelVars[ID_A_met_duod] + rgModelVars[ID_A_met_jeju] + rgModelVars[ID_A_met_ileon] + rgModelVars[ID_A_met_cecum] + rgModelVars[ID_A_met_colon] + rgModelVars[ID_A_feces] ;

  rgModelVars[ID_A_elim] = rgModelVars[ID_A_elim_kid] + rgModelVars[ID_A_met_liver] + rgModelVars[ID_A_elim_gi] ;

  rgModelVars[ID_A_organ] = rgModelVars[ID_A_kid] + rgModelVars[ID_A_rpt] + rgModelVars[ID_A_liver] + rgModelVars[ID_A_adip] + rgModelVars[ID_A_ppt] + rgModelVars[ID_A_blood] + rgModelVars[ID_A_gi_lu] + rgModelVars[ID_A_gi_ep] + rgModelVars[ID_A_gi_w] ;

  rgModelVars[ID_A_total] = rgModelVars[ID_A_organ] + rgModelVars[ID_A_elim] ;

  rgModelVars[ID_Instant_Ka_gi] = rgModelVars[ID_A_absorb_pv] / rgModelVars[ID_A_gi_lu] ;

}  /* CalcOutputs */


