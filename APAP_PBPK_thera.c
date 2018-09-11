/* APAP_PBPK_thera.c
   ___________________________________________________

   Model File:  APAP_PBPK_thera.model

   Date:  Tue Sep 11 15:48:23 2018

   Created by:  "mod v5.6.6"
    -- a model preprocessor by Don Maszle
   ___________________________________________________

   Copyright (c) 1993-2017 Free Software Foundation, Inc.

   Model calculations for compartmental model:

   44 States:
     CL_APAP_to_NAPQI_CYP -> 0.0;
     CL_APAP_to_AS_SULT -> 0.0;
     CL_APAP_to_AG_UGT -> 0.0;
     AST_Oral_APAP -> 0.0;
     AST_APAP -> 0.0;
     AST_to_Gut_APAP -> 0.0;
     AF_APAP -> 0.0;
     AR_APAP -> 0.0;
     AS_APAP -> 0.0;
     AF_AS -> 0.0;
     AR_AS -> 0.0;
     AS_AS -> 0.0;
     AF_AG -> 0.0;
     AR_AG -> 0.0;
     AS_AG -> 0.0;
     AKE_APAP -> 0.0;
     AKE_AS -> 0.0;
     AKE_AG -> 0.0;
     AK_APAP -> 0.0;
     AK_AS -> 0.0;
     AK_AG -> 0.0;
     AL_APAP -> 0.0;
     AL_AS -> 0.0;
     AL_AG -> 0.0;
     AL_PAPS -> 0.0;
     AL_GA -> 0.0;
     CH_AG -> 0.0;
     CH_AG_to_CL_AG -> 0.0;
     CH_AS -> 0.0;
     CH_AS_to_CL_AS -> 0.0;
     AM_APAP -> 0.0;
     AM_AS -> 0.0;
     AM_AG -> 0.0;
     ABLA_APAP -> 0.0;
     ABLA_AS -> 0.0;
     ABLA_AG -> 0.0;
     ABL_IV_APAP -> 0.0;
     ABLV_APAP -> 0.0;
     ABLV_AS -> 0.0;
     ABLV_AG -> 0.0;
     AU_APAP -> 0.0;
     AU_AS -> 0.0;
     AU_AG -> 0.0;
     pct_abs -> 0.0;

   55 Outputs:
     CF_APAP -> 0.0;
     CK_APAP -> 0.0;
     CL_APAP -> 0.0;
     CR_APAP -> 0.0;
     CS_APAP -> 0.0;
     CF_AS -> 0.0;
     CK_AS -> 0.0;
     CL_AS -> 0.0;
     CR_AS -> 0.0;
     CS_AS -> 0.0;
     CF_AG -> 0.0;
     CK_AG -> 0.0;
     CL_AG -> 0.0;
     CR_AG -> 0.0;
     CS_AG -> 0.0;
     CA_APAP -> 0.0;
     CV_APAP -> 0.0;
     CPL_APAP -> 0.0;
     CA_AS -> 0.0;
     CV_AS -> 0.0;
     CPL_AS -> 0.0;
     CA_AG -> 0.0;
     CV_AG -> 0.0;
     CPL_AG -> 0.0;
     CPL_APAP_mcmolL -> 0.0;
     CPL_APAP_mcgL -> 0.0;
     CPL_AG_mcmolL -> 0.0;
     CPL_AG_mcgL -> 0.0;
     CPL_AS_mcmolL -> 0.0;
     CPL_AS_mcgL -> 0.0;
     CL_APAP_mcmolL -> 0.0;
     CL_APAP_mcgL -> 0.0;
     CU_APAP_mcg -> 0.0;
     CU_AG_mcg -> 0.0;
     CU_AS_mcg -> 0.0;
     f_abs -> 0.0;
     lntrue_dose -> 0.0;
     lnODose_APAP -> 0.0;
     lnfa -> 0.0;
     lnCPL_APAP_mcgL -> 0.0;
     lnCPL_AG_mcgL -> 0.0;
     lnCPL_AS_mcgL -> 0.0;
     lnCU_APAP_mcg -> 0.0;
     lnCU_AG_mcg -> 0.0;
     lnCU_AS_mcg -> 0.0;
     lnf_abs -> 0.0;
     Verr_lnCPL_APAP_mcmolL -> 0.0;
     Verr_lnCPL_APAP_mcgL -> 0.0;
     Verr_lnCPL_AG_mcmolL -> 0.0;
     Verr_lnCPL_AG_mcgL -> 0.0;
     Verr_lnCPL_AS_mcmolL -> 0.0;
     Verr_lnCPL_AS_mcgL -> 0.0;
     Verr_lnCU_APAP_mcg -> 0.0;
     Verr_lnCU_AG_mcg -> 0.0;
     Verr_lnCU_AS_mcg -> 0.0;

   2 Inputs:
     OralExp_APAP (is a function)
     IVExp_APAP (is a function)

   373 Parameters:
     MW_APAP = 151.17;
     MW_AG = 327.28;
     MW_AS = 231.22;
     BW = 0;
     lnBW = 4.0;
     QCC = 16.2;
     VFC = 0.214;
     VKC = 0.0044;
     VGC = 0.0144;
     VLC = 0.0257;
     VMC = 0.4;
     VBLAC = 0.0243;
     VBLVC = 0.0557;
     VSC = 0.185;
     VRC = 0.0765;
     QFC = 0.052;
     QKC = 0.175;
     QGC = 0.181;
     QLBC = 0.046;
     QMC = 0.191;
     QSC = 0.14;
     QRC = 0.215;
     kSG_Vm = 0;
     lnkSG_Vm = 7.75;
     kSG_Km = 0;
     lnkSG_Km = 7.47;
     Tg = 0;
     lnTg = -1.0;
     Tp = 0;
     lnTp = -3.0;
     CLC_APAP = 0;
     lnCLC_APAP = -2.0;
     CLC_AS = 0;
     lnCLC_AS = -2.0;
     CLC_AG = 0;
     lnCLC_AG = -2.0;
     alpha_APAP = 1.;
     alpha_AS = 1.;
     alpha_AG = 1.;
     BP_APAP = 0.9;
     lnBP_APAP = log(0.9);
     PF_APAP = 0.447;
     lnPF_APAP = log(0.447);
     PG_APAP = 0.907;
     lnPG_APAP = log(0.907);
     PK_APAP = 0.711;
     lnPK_APAP = log(0.711);
     PL_APAP = 0.687;
     lnPL_APAP = log(0.687);
     PM_APAP = 0.687;
     lnPM_APAP = log(0.687);
     PR_APAP = 0.676;
     lnPR_APAP = log(0.676);
     PS_APAP = 0.606;
     lnPS_APAP = log(0.606);
     PF_AS = 0.088;
     lnPF_AS = log(0.088);
     PG_AS = 0.297;
     lnPG_AS = log(0.297);
     PK_AS = 0.261;
     lnPK_AS = log(0.261);
     PL_AS = 0.203;
     lnPL_AS = log(0.203);
     PM_AS = 0.199;
     lnPM_AS = log(0.199);
     PR_AS = 0.207;
     lnPR_AS = log(0.207);
     PS_AS = 0.254;
     lnPS_AS = log(0.254);
     PF_AG = 0.128;
     lnPF_AG = log(0.128);
     PG_AG = 0.436;
     lnPG_AG = log(0.436);
     PK_AG = 0.392;
     lnPK_AG = log(0.392);
     PL_AG = 0.321;
     lnPL_AG = log(0.321);
     PM_AG = 0.336;
     lnPM_AG = log(0.366);
     PR_AG = 0.364;
     lnPR_AG = log(0.364);
     PS_AG = 0.351;
     lnPS_AG = log(0.351);
     kPAPS = 0.018;
     lnkPAPS = log(0.018);
     kPAPS_syn = 0;
     lnkPAPS_syn = -30;
     kGA = 0.008;
     lnkGA = log(0.008);
     kGA_syn = 0;
     lnkGA_syn = -30;
     CYP_Km = 0;
     lnCYP_Km = 7.6;
     CYP_VmaxC = 0;
     lnCYP_VmaxC = 8.4;
     UGT_Km = 0;
     lnUGT_Km = 9;
     UGT_Ki = 0;
     lnUGT_Ki = 23;
     UGT_VmaxC = 0;
     lnUGT_VmaxC = 7.3;
     UGT_Km_GA = 0;
     lnUGT_Km_GA = 2.3;
     Vmax_AG = 0;
     lnVmax_AG = 30;
     Km_AG = 0;
     lnKm_AG = 9.9;
     SULT_Km_apap = 0;
     lnSULT_Km_apap = 3.0;
     SULT_Km_paps = 0;
     lnSULT_Km_paps = 3.0;
     SULT_Ki = 0;
     lnSULT_Ki = 20;
     SULT_VmaxC = 0;
     lnSULT_VmaxC = 10;
     Vmax_AS = 0;
     lnVmax_AS = 20;
     Km_AS = 0;
     lnKm_AS = 10;
     mgkg_flag = 1.;
     OralDose_APAP_mgkg = 1;
     OralDose_APAP_mg = 1;
     OralDur_APAP = 0.001;
     ODose_APAP_mg = 0;
     fa = 0;
     ODose_APAP = 0;
     true_dose = 0;
     IVDose_APAP_mgkg = 0.;
     lnIVDose_APAP_mgkg = 0;
     IVDose_APAP_mg = 0.;
     lnIVDose_APAP_mg = 0;
     IVDur_APAP = 0.001;
     IVD_APAP_mg = 0;
     IVDR_APAP = 0;
     CYP_Vmax = 0;
     UGT_Vmax = 0;
     SULT_Vmax = 0;
     VTC = 0;
     VF = 0;
     VK = 0;
     VG = 0;
     VM = 0;
     VL = 0;
     VBLA = 0;
     VBLV = 0;
     VR = 0;
     VS = 0;
     QTC = 0;
     QC = 0;
     QF = 0;
     QK = 0;
     QG = 0;
     QM = 0;
     QLB = 0;
     QR = 0;
     QS = 0;
     QL = 0;
     CLR_APAP = 0;
     CLR_AS = 0;
     CLR_AG = 0;
     M_OralDose_APAP = 0;
     Var_OralDose_APAP = 0;
     M_IVDose_APAP = 0;
     Var_IVDose_APAP = 0;
     M_lnOralDose_APAP = 0;
     Var_lnOralDose_APAP = 0;
     M_lnIVDose_APAP = 0;
     M_lnVar_IVDose_APAP = 0;
     M_BW = 0;
     M_lnBW = 0;
     M_fa = 0;
     M_lnfa = 0;
     M_kSG_Vm = 0;
     M_lnkSG_Vm = 0;
     M_kSG_Km = 0;
     M_lnkSG_Km = 0;
     M_Tg = 0;
     M_lnTg = 0;
     M_Tp = 0;
     M_lnTp = 0;
     M_CLC_APAP = 0;
     M_lnCLC_APAP = 0;
     M_CLC_AS = 0;
     M_lnCLC_AS = 0;
     M_CLC_AG = 0;
     M_lnCLC_AG = 0;
     M_BP_APAP = 0;
     M_lnBP_APAP = 0;
     M_PF_APAP = 0;
     M_lnPF_APAP = 0;
     M_PG_APAP = 0;
     M_lnPG_APAP = 0;
     M_PK_APAP = 0;
     M_lnPK_APAP = 0;
     M_PL_APAP = 0;
     M_lnPL_APAP = 0;
     M_PM_APAP = 0;
     M_lnPM_APAP = 0;
     M_PR_APAP = 0;
     M_lnPR_APAP = 0;
     M_PS_APAP = 0;
     M_lnPS_APAP = 0;
     M_PK_AS = 0;
     M_lnPK_AS = 0;
     M_PF_AS = 0;
     M_lnPF_AS = 0;
     M_PL_AS = 0;
     M_lnPL_AS = 0;
     M_PG_AS = 0;
     M_lnPG_AS = 0;
     M_PM_AS = 0;
     M_lnPM_AS = 0;
     M_PR_AS = 0;
     M_lnPR_AS = 0;
     M_PS_AS = 0;
     M_lnPS_AS = 0;
     M_PK_AG = 0;
     M_lnPK_AG = 0;
     M_PF_AG = 0;
     M_lnPF_AG = 0;
     M_PL_AG = 0;
     M_lnPL_AG = 0;
     M_PG_AG = 0;
     M_lnPG_AG = 0;
     M_PM_AG = 0;
     M_lnPM_AG = 0;
     M_PR_AG = 0;
     M_lnPR_AG = 0;
     M_PS_AG = 0;
     M_lnPS_AG = 0;
     M_kPAPS = 0;
     M_lnkPAPS = 0;
     M_kPAPS_syn = 0;
     M_lnkPAPS_syn = 0;
     M_kGA = 0;
     M_lnkGA = 0;
     M_kGA_syn = 0;
     M_lnkGA_syn = 0;
     M_CYP_Km = 0;
     M_lnCYP_Km = 0;
     M_CYP_VmaxC = 0;
     M_lnCYP_VmaxC = 0;
     M_UGT_Km = 0;
     M_lnUGT_Km = 0;
     M_UGT_VmaxC = 0;
     M_lnUGT_VmaxC = 0;
     M_UGT_Km_GA = 0;
     M_lnUGT_Km_GA = 0;
     M_UGT_Ki = 0;
     M_lnUGT_Ki = 0;
     M_Vmax_AG = 0;
     M_lnVmax_AG = 0;
     M_Km_AG = 0;
     M_lnKm_AG = 0;
     M_SULT_Km_apap = 0;
     M_lnSULT_Km_apap = 0;
     M_SULT_Km_paps = 0;
     M_lnSULT_Km_paps = 0;
     M_SULT_Ki = 0;
     M_lnSULT_Ki = 0;
     M_SULT_VmaxC = 0;
     M_lnSULT_VmaxC = 0;
     M_Vmax_AS = 0;
     M_lnVmax_AS = 0;
     M_Km_AS = 0;
     M_lnKm_AS = 0;
     Var_BW = 0;
     Var_lnBW = 0;
     Var_fa = 0;
     Var_lnfa = 0;
     Var_kSG_Vm = 0;
     Var_lnkSG_Vm = 0;
     Var_kSG_Km = 0;
     Var_lnkSG_Km = 0;
     Var_Tg = 0;
     Var_lnTg = 0;
     Var_Tp = 0;
     Var_lnTp = 0;
     Var_CLC_APAP = 0;
     Var_lnCLC_APAP = 0;
     Var_CLC_AS = 0;
     Var_lnCLC_AS = 0;
     Var_CLC_AG = 0;
     Var_lnCLC_AG = 0;
     Var_BP_APAP = 0;
     Var_lnBP_APAP = 0;
     Var_PF_APAP = 0;
     Var_lnPF_APAP = 0;
     Var_PG_APAP = 0;
     Var_lnPG_APAP = 0;
     Var_PK_APAP = 0;
     Var_lnPK_APAP = 0;
     Var_PL_APAP = 0;
     Var_lnPL_APAP = 0;
     Var_PM_APAP = 0;
     Var_lnPM_APAP = 0;
     Var_PR_APAP = 0;
     Var_lnPR_APAP = 0;
     Var_PS_APAP = 0;
     Var_lnPS_APAP = 0;
     Var_PK_AS = 0;
     Var_lnPK_AS = 0;
     Var_PF_AS = 0;
     Var_lnPF_AS = 0;
     Var_PL_AS = 0;
     Var_lnPL_AS = 0;
     Var_PG_AS = 0;
     Var_lnPG_AS = 0;
     Var_PM_AS = 0;
     Var_lnPM_AS = 0;
     Var_PR_AS = 0;
     Var_lnPR_AS = 0;
     Var_PS_AS = 0;
     Var_lnPS_AS = 0;
     Var_PK_AG = 0;
     Var_lnPK_AG = 0;
     Var_PF_AG = 0;
     Var_lnPF_AG = 0;
     Var_PL_AG = 0;
     Var_lnPL_AG = 0;
     Var_PG_AG = 0;
     Var_lnPG_AG = 0;
     Var_PM_AG = 0;
     Var_lnPM_AG = 0;
     Var_PR_AG = 0;
     Var_lnPR_AG = 0;
     Var_PS_AG = 0;
     Var_lnPS_AG = 0;
     Var_kPAPS = 0;
     Var_lnkPAPS = 0;
     Var_kPAPS_syn = 0;
     Var_lnkPAPS_syn = 0;
     Var_kGA = 0;
     Var_lnkGA = 0;
     Var_kGA_syn = 0;
     Var_lnkGA_syn = 0;
     Var_CYP_Km = 0;
     Var_lnCYP_Km = 0;
     Var_CYP_VmaxC = 0;
     Var_lnCYP_VmaxC = 0;
     Var_UGT_Km = 0;
     Var_lnUGT_Km = 0;
     Var_UGT_VmaxC = 0;
     Var_lnUGT_VmaxC = 0;
     Var_UGT_Km_GA = 0;
     Var_lnUGT_Km_GA = 0;
     Var_UGT_Ki = 0;
     Var_lnUGT_Ki = 0;
     Var_Vmax_AG = 0;
     Var_lnVmax_AG = 0;
     Var_Km_AG = 0;
     Var_lnKm_AG = 0;
     Var_SULT_KVar_apap = 0;
     Var_lnSULT_Km_apap = 0;
     Var_SULT_KVar_paps = 0;
     Var_lnSULT_Km_paps = 0;
     Var_SULT_Ki = 0;
     Var_lnSULT_Ki = 0;
     Var_SULT_VmaxC = 0;
     Var_lnSULT_VmaxC = 0;
     Var_Vmax_AS = 0;
     Var_lnVmax_AS = 0;
     Var_Km_AS = 0;
     Var_lnKm_AS = 0;
     Verr_CPL_APAP_mcmolL = 0;
     Verr_CPL_APAP_mcgL = 0;
     Verr_CPL_AG_mcmolL = 0;
     Verr_CPL_AG_mcgL = 0;
     Verr_CPL_AS_mcmolL = 0;
     Verr_CPL_AS_mcgL = 0;
     Verr_CU_APAP_mcg = 0;
     Verr_CU_AG_mcg = 0;
     Verr_CU_AS_mcg = 0;
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
#define ID_CL_APAP_to_NAPQI_CYP 0x00000
#define ID_CL_APAP_to_AS_SULT 0x00001
#define ID_CL_APAP_to_AG_UGT 0x00002
#define ID_AST_Oral_APAP 0x00003
#define ID_AST_APAP 0x00004
#define ID_AST_to_Gut_APAP 0x00005
#define ID_AF_APAP 0x00006
#define ID_AR_APAP 0x00007
#define ID_AS_APAP 0x00008
#define ID_AF_AS 0x00009
#define ID_AR_AS 0x0000a
#define ID_AS_AS 0x0000b
#define ID_AF_AG 0x0000c
#define ID_AR_AG 0x0000d
#define ID_AS_AG 0x0000e
#define ID_AKE_APAP 0x0000f
#define ID_AKE_AS 0x00010
#define ID_AKE_AG 0x00011
#define ID_AK_APAP 0x00012
#define ID_AK_AS 0x00013
#define ID_AK_AG 0x00014
#define ID_AL_APAP 0x00015
#define ID_AL_AS 0x00016
#define ID_AL_AG 0x00017
#define ID_AL_PAPS 0x00018
#define ID_AL_GA 0x00019
#define ID_CH_AG 0x0001a
#define ID_CH_AG_to_CL_AG 0x0001b
#define ID_CH_AS 0x0001c
#define ID_CH_AS_to_CL_AS 0x0001d
#define ID_AM_APAP 0x0001e
#define ID_AM_AS 0x0001f
#define ID_AM_AG 0x00020
#define ID_ABLA_APAP 0x00021
#define ID_ABLA_AS 0x00022
#define ID_ABLA_AG 0x00023
#define ID_ABL_IV_APAP 0x00024
#define ID_ABLV_APAP 0x00025
#define ID_ABLV_AS 0x00026
#define ID_ABLV_AG 0x00027
#define ID_AU_APAP 0x00028
#define ID_AU_AS 0x00029
#define ID_AU_AG 0x0002a
#define ID_pct_abs 0x0002b
#define ID_CF_APAP 0x0002c
#define ID_CK_APAP 0x0002d
#define ID_CL_APAP 0x0002e
#define ID_CR_APAP 0x0002f
#define ID_CS_APAP 0x00030
#define ID_CF_AS 0x00031
#define ID_CK_AS 0x00032
#define ID_CL_AS 0x00033
#define ID_CR_AS 0x00034
#define ID_CS_AS 0x00035
#define ID_CF_AG 0x00036
#define ID_CK_AG 0x00037
#define ID_CL_AG 0x00038
#define ID_CR_AG 0x00039
#define ID_CS_AG 0x0003a
#define ID_CA_APAP 0x0003b
#define ID_CV_APAP 0x0003c
#define ID_CPL_APAP 0x0003d
#define ID_CA_AS 0x0003e
#define ID_CV_AS 0x0003f
#define ID_CPL_AS 0x00040
#define ID_CA_AG 0x00041
#define ID_CV_AG 0x00042
#define ID_CPL_AG 0x00043
#define ID_CPL_APAP_mcmolL 0x00044
#define ID_CPL_APAP_mcgL 0x00045
#define ID_CPL_AG_mcmolL 0x00046
#define ID_CPL_AG_mcgL 0x00047
#define ID_CPL_AS_mcmolL 0x00048
#define ID_CPL_AS_mcgL 0x00049
#define ID_CL_APAP_mcmolL 0x0004a
#define ID_CL_APAP_mcgL 0x0004b
#define ID_CU_APAP_mcg 0x0004c
#define ID_CU_AG_mcg 0x0004d
#define ID_CU_AS_mcg 0x0004e
#define ID_f_abs 0x0004f
#define ID_lntrue_dose 0x00050
#define ID_lnODose_APAP 0x00051
#define ID_lnfa 0x00052
#define ID_lnCPL_APAP_mcgL 0x00053
#define ID_lnCPL_AG_mcgL 0x00054
#define ID_lnCPL_AS_mcgL 0x00055
#define ID_lnCU_APAP_mcg 0x00056
#define ID_lnCU_AG_mcg 0x00057
#define ID_lnCU_AS_mcg 0x00058
#define ID_lnf_abs 0x00059
#define ID_Verr_lnCPL_APAP_mcmolL 0x0005a
#define ID_Verr_lnCPL_APAP_mcgL 0x0005b
#define ID_Verr_lnCPL_AG_mcmolL 0x0005c
#define ID_Verr_lnCPL_AG_mcgL 0x0005d
#define ID_Verr_lnCPL_AS_mcmolL 0x0005e
#define ID_Verr_lnCPL_AS_mcgL 0x0005f
#define ID_Verr_lnCU_APAP_mcg 0x00060
#define ID_Verr_lnCU_AG_mcg 0x00061
#define ID_Verr_lnCU_AS_mcg 0x00062

/* Inputs */
#define ID_OralExp_APAP 0x00000
#define ID_IVExp_APAP 0x00001

/* Parameters */
#define ID_MW_APAP 0x00065
#define ID_MW_AG 0x00066
#define ID_MW_AS 0x00067
#define ID_BW 0x00068
#define ID_lnBW 0x00069
#define ID_QCC 0x0006a
#define ID_VFC 0x0006b
#define ID_VKC 0x0006c
#define ID_VGC 0x0006d
#define ID_VLC 0x0006e
#define ID_VMC 0x0006f
#define ID_VBLAC 0x00070
#define ID_VBLVC 0x00071
#define ID_VSC 0x00072
#define ID_VRC 0x00073
#define ID_QFC 0x00074
#define ID_QKC 0x00075
#define ID_QGC 0x00076
#define ID_QLBC 0x00077
#define ID_QMC 0x00078
#define ID_QSC 0x00079
#define ID_QRC 0x0007a
#define ID_kSG_Vm 0x0007b
#define ID_lnkSG_Vm 0x0007c
#define ID_kSG_Km 0x0007d
#define ID_lnkSG_Km 0x0007e
#define ID_Tg 0x0007f
#define ID_lnTg 0x00080
#define ID_Tp 0x00081
#define ID_lnTp 0x00082
#define ID_CLC_APAP 0x00083
#define ID_lnCLC_APAP 0x00084
#define ID_CLC_AS 0x00085
#define ID_lnCLC_AS 0x00086
#define ID_CLC_AG 0x00087
#define ID_lnCLC_AG 0x00088
#define ID_alpha_APAP 0x00089
#define ID_alpha_AS 0x0008a
#define ID_alpha_AG 0x0008b
#define ID_BP_APAP 0x0008c
#define ID_lnBP_APAP 0x0008d
#define ID_PF_APAP 0x0008e
#define ID_lnPF_APAP 0x0008f
#define ID_PG_APAP 0x00090
#define ID_lnPG_APAP 0x00091
#define ID_PK_APAP 0x00092
#define ID_lnPK_APAP 0x00093
#define ID_PL_APAP 0x00094
#define ID_lnPL_APAP 0x00095
#define ID_PM_APAP 0x00096
#define ID_lnPM_APAP 0x00097
#define ID_PR_APAP 0x00098
#define ID_lnPR_APAP 0x00099
#define ID_PS_APAP 0x0009a
#define ID_lnPS_APAP 0x0009b
#define ID_PF_AS 0x0009c
#define ID_lnPF_AS 0x0009d
#define ID_PG_AS 0x0009e
#define ID_lnPG_AS 0x0009f
#define ID_PK_AS 0x000a0
#define ID_lnPK_AS 0x000a1
#define ID_PL_AS 0x000a2
#define ID_lnPL_AS 0x000a3
#define ID_PM_AS 0x000a4
#define ID_lnPM_AS 0x000a5
#define ID_PR_AS 0x000a6
#define ID_lnPR_AS 0x000a7
#define ID_PS_AS 0x000a8
#define ID_lnPS_AS 0x000a9
#define ID_PF_AG 0x000aa
#define ID_lnPF_AG 0x000ab
#define ID_PG_AG 0x000ac
#define ID_lnPG_AG 0x000ad
#define ID_PK_AG 0x000ae
#define ID_lnPK_AG 0x000af
#define ID_PL_AG 0x000b0
#define ID_lnPL_AG 0x000b1
#define ID_PM_AG 0x000b2
#define ID_lnPM_AG 0x000b3
#define ID_PR_AG 0x000b4
#define ID_lnPR_AG 0x000b5
#define ID_PS_AG 0x000b6
#define ID_lnPS_AG 0x000b7
#define ID_kPAPS 0x000b8
#define ID_lnkPAPS 0x000b9
#define ID_kPAPS_syn 0x000ba
#define ID_lnkPAPS_syn 0x000bb
#define ID_kGA 0x000bc
#define ID_lnkGA 0x000bd
#define ID_kGA_syn 0x000be
#define ID_lnkGA_syn 0x000bf
#define ID_CYP_Km 0x000c0
#define ID_lnCYP_Km 0x000c1
#define ID_CYP_VmaxC 0x000c2
#define ID_lnCYP_VmaxC 0x000c3
#define ID_UGT_Km 0x000c4
#define ID_lnUGT_Km 0x000c5
#define ID_UGT_Ki 0x000c6
#define ID_lnUGT_Ki 0x000c7
#define ID_UGT_VmaxC 0x000c8
#define ID_lnUGT_VmaxC 0x000c9
#define ID_UGT_Km_GA 0x000ca
#define ID_lnUGT_Km_GA 0x000cb
#define ID_Vmax_AG 0x000cc
#define ID_lnVmax_AG 0x000cd
#define ID_Km_AG 0x000ce
#define ID_lnKm_AG 0x000cf
#define ID_SULT_Km_apap 0x000d0
#define ID_lnSULT_Km_apap 0x000d1
#define ID_SULT_Km_paps 0x000d2
#define ID_lnSULT_Km_paps 0x000d3
#define ID_SULT_Ki 0x000d4
#define ID_lnSULT_Ki 0x000d5
#define ID_SULT_VmaxC 0x000d6
#define ID_lnSULT_VmaxC 0x000d7
#define ID_Vmax_AS 0x000d8
#define ID_lnVmax_AS 0x000d9
#define ID_Km_AS 0x000da
#define ID_lnKm_AS 0x000db
#define ID_mgkg_flag 0x000dc
#define ID_OralDose_APAP_mgkg 0x000dd
#define ID_OralDose_APAP_mg 0x000de
#define ID_OralDur_APAP 0x000df
#define ID_ODose_APAP_mg 0x000e0
#define ID_fa 0x000e1
#define ID_ODose_APAP 0x000e2
#define ID_true_dose 0x000e3
#define ID_IVDose_APAP_mgkg 0x000e4
#define ID_lnIVDose_APAP_mgkg 0x000e5
#define ID_IVDose_APAP_mg 0x000e6
#define ID_lnIVDose_APAP_mg 0x000e7
#define ID_IVDur_APAP 0x000e8
#define ID_IVD_APAP_mg 0x000e9
#define ID_IVDR_APAP 0x000ea
#define ID_CYP_Vmax 0x000eb
#define ID_UGT_Vmax 0x000ec
#define ID_SULT_Vmax 0x000ed
#define ID_VTC 0x000ee
#define ID_VF 0x000ef
#define ID_VK 0x000f0
#define ID_VG 0x000f1
#define ID_VM 0x000f2
#define ID_VL 0x000f3
#define ID_VBLA 0x000f4
#define ID_VBLV 0x000f5
#define ID_VR 0x000f6
#define ID_VS 0x000f7
#define ID_QTC 0x000f8
#define ID_QC 0x000f9
#define ID_QF 0x000fa
#define ID_QK 0x000fb
#define ID_QG 0x000fc
#define ID_QM 0x000fd
#define ID_QLB 0x000fe
#define ID_QR 0x000ff
#define ID_QS 0x00100
#define ID_QL 0x00101
#define ID_CLR_APAP 0x00102
#define ID_CLR_AS 0x00103
#define ID_CLR_AG 0x00104
#define ID_M_OralDose_APAP 0x00105
#define ID_Var_OralDose_APAP 0x00106
#define ID_M_IVDose_APAP 0x00107
#define ID_Var_IVDose_APAP 0x00108
#define ID_M_lnOralDose_APAP 0x00109
#define ID_Var_lnOralDose_APAP 0x0010a
#define ID_M_lnIVDose_APAP 0x0010b
#define ID_M_lnVar_IVDose_APAP 0x0010c
#define ID_M_BW 0x0010d
#define ID_M_lnBW 0x0010e
#define ID_M_fa 0x0010f
#define ID_M_lnfa 0x00110
#define ID_M_kSG_Vm 0x00111
#define ID_M_lnkSG_Vm 0x00112
#define ID_M_kSG_Km 0x00113
#define ID_M_lnkSG_Km 0x00114
#define ID_M_Tg 0x00115
#define ID_M_lnTg 0x00116
#define ID_M_Tp 0x00117
#define ID_M_lnTp 0x00118
#define ID_M_CLC_APAP 0x00119
#define ID_M_lnCLC_APAP 0x0011a
#define ID_M_CLC_AS 0x0011b
#define ID_M_lnCLC_AS 0x0011c
#define ID_M_CLC_AG 0x0011d
#define ID_M_lnCLC_AG 0x0011e
#define ID_M_BP_APAP 0x0011f
#define ID_M_lnBP_APAP 0x00120
#define ID_M_PF_APAP 0x00121
#define ID_M_lnPF_APAP 0x00122
#define ID_M_PG_APAP 0x00123
#define ID_M_lnPG_APAP 0x00124
#define ID_M_PK_APAP 0x00125
#define ID_M_lnPK_APAP 0x00126
#define ID_M_PL_APAP 0x00127
#define ID_M_lnPL_APAP 0x00128
#define ID_M_PM_APAP 0x00129
#define ID_M_lnPM_APAP 0x0012a
#define ID_M_PR_APAP 0x0012b
#define ID_M_lnPR_APAP 0x0012c
#define ID_M_PS_APAP 0x0012d
#define ID_M_lnPS_APAP 0x0012e
#define ID_M_PK_AS 0x0012f
#define ID_M_lnPK_AS 0x00130
#define ID_M_PF_AS 0x00131
#define ID_M_lnPF_AS 0x00132
#define ID_M_PL_AS 0x00133
#define ID_M_lnPL_AS 0x00134
#define ID_M_PG_AS 0x00135
#define ID_M_lnPG_AS 0x00136
#define ID_M_PM_AS 0x00137
#define ID_M_lnPM_AS 0x00138
#define ID_M_PR_AS 0x00139
#define ID_M_lnPR_AS 0x0013a
#define ID_M_PS_AS 0x0013b
#define ID_M_lnPS_AS 0x0013c
#define ID_M_PK_AG 0x0013d
#define ID_M_lnPK_AG 0x0013e
#define ID_M_PF_AG 0x0013f
#define ID_M_lnPF_AG 0x00140
#define ID_M_PL_AG 0x00141
#define ID_M_lnPL_AG 0x00142
#define ID_M_PG_AG 0x00143
#define ID_M_lnPG_AG 0x00144
#define ID_M_PM_AG 0x00145
#define ID_M_lnPM_AG 0x00146
#define ID_M_PR_AG 0x00147
#define ID_M_lnPR_AG 0x00148
#define ID_M_PS_AG 0x00149
#define ID_M_lnPS_AG 0x0014a
#define ID_M_kPAPS 0x0014b
#define ID_M_lnkPAPS 0x0014c
#define ID_M_kPAPS_syn 0x0014d
#define ID_M_lnkPAPS_syn 0x0014e
#define ID_M_kGA 0x0014f
#define ID_M_lnkGA 0x00150
#define ID_M_kGA_syn 0x00151
#define ID_M_lnkGA_syn 0x00152
#define ID_M_CYP_Km 0x00153
#define ID_M_lnCYP_Km 0x00154
#define ID_M_CYP_VmaxC 0x00155
#define ID_M_lnCYP_VmaxC 0x00156
#define ID_M_UGT_Km 0x00157
#define ID_M_lnUGT_Km 0x00158
#define ID_M_UGT_VmaxC 0x00159
#define ID_M_lnUGT_VmaxC 0x0015a
#define ID_M_UGT_Km_GA 0x0015b
#define ID_M_lnUGT_Km_GA 0x0015c
#define ID_M_UGT_Ki 0x0015d
#define ID_M_lnUGT_Ki 0x0015e
#define ID_M_Vmax_AG 0x0015f
#define ID_M_lnVmax_AG 0x00160
#define ID_M_Km_AG 0x00161
#define ID_M_lnKm_AG 0x00162
#define ID_M_SULT_Km_apap 0x00163
#define ID_M_lnSULT_Km_apap 0x00164
#define ID_M_SULT_Km_paps 0x00165
#define ID_M_lnSULT_Km_paps 0x00166
#define ID_M_SULT_Ki 0x00167
#define ID_M_lnSULT_Ki 0x00168
#define ID_M_SULT_VmaxC 0x00169
#define ID_M_lnSULT_VmaxC 0x0016a
#define ID_M_Vmax_AS 0x0016b
#define ID_M_lnVmax_AS 0x0016c
#define ID_M_Km_AS 0x0016d
#define ID_M_lnKm_AS 0x0016e
#define ID_Var_BW 0x0016f
#define ID_Var_lnBW 0x00170
#define ID_Var_fa 0x00171
#define ID_Var_lnfa 0x00172
#define ID_Var_kSG_Vm 0x00173
#define ID_Var_lnkSG_Vm 0x00174
#define ID_Var_kSG_Km 0x00175
#define ID_Var_lnkSG_Km 0x00176
#define ID_Var_Tg 0x00177
#define ID_Var_lnTg 0x00178
#define ID_Var_Tp 0x00179
#define ID_Var_lnTp 0x0017a
#define ID_Var_CLC_APAP 0x0017b
#define ID_Var_lnCLC_APAP 0x0017c
#define ID_Var_CLC_AS 0x0017d
#define ID_Var_lnCLC_AS 0x0017e
#define ID_Var_CLC_AG 0x0017f
#define ID_Var_lnCLC_AG 0x00180
#define ID_Var_BP_APAP 0x00181
#define ID_Var_lnBP_APAP 0x00182
#define ID_Var_PF_APAP 0x00183
#define ID_Var_lnPF_APAP 0x00184
#define ID_Var_PG_APAP 0x00185
#define ID_Var_lnPG_APAP 0x00186
#define ID_Var_PK_APAP 0x00187
#define ID_Var_lnPK_APAP 0x00188
#define ID_Var_PL_APAP 0x00189
#define ID_Var_lnPL_APAP 0x0018a
#define ID_Var_PM_APAP 0x0018b
#define ID_Var_lnPM_APAP 0x0018c
#define ID_Var_PR_APAP 0x0018d
#define ID_Var_lnPR_APAP 0x0018e
#define ID_Var_PS_APAP 0x0018f
#define ID_Var_lnPS_APAP 0x00190
#define ID_Var_PK_AS 0x00191
#define ID_Var_lnPK_AS 0x00192
#define ID_Var_PF_AS 0x00193
#define ID_Var_lnPF_AS 0x00194
#define ID_Var_PL_AS 0x00195
#define ID_Var_lnPL_AS 0x00196
#define ID_Var_PG_AS 0x00197
#define ID_Var_lnPG_AS 0x00198
#define ID_Var_PM_AS 0x00199
#define ID_Var_lnPM_AS 0x0019a
#define ID_Var_PR_AS 0x0019b
#define ID_Var_lnPR_AS 0x0019c
#define ID_Var_PS_AS 0x0019d
#define ID_Var_lnPS_AS 0x0019e
#define ID_Var_PK_AG 0x0019f
#define ID_Var_lnPK_AG 0x001a0
#define ID_Var_PF_AG 0x001a1
#define ID_Var_lnPF_AG 0x001a2
#define ID_Var_PL_AG 0x001a3
#define ID_Var_lnPL_AG 0x001a4
#define ID_Var_PG_AG 0x001a5
#define ID_Var_lnPG_AG 0x001a6
#define ID_Var_PM_AG 0x001a7
#define ID_Var_lnPM_AG 0x001a8
#define ID_Var_PR_AG 0x001a9
#define ID_Var_lnPR_AG 0x001aa
#define ID_Var_PS_AG 0x001ab
#define ID_Var_lnPS_AG 0x001ac
#define ID_Var_kPAPS 0x001ad
#define ID_Var_lnkPAPS 0x001ae
#define ID_Var_kPAPS_syn 0x001af
#define ID_Var_lnkPAPS_syn 0x001b0
#define ID_Var_kGA 0x001b1
#define ID_Var_lnkGA 0x001b2
#define ID_Var_kGA_syn 0x001b3
#define ID_Var_lnkGA_syn 0x001b4
#define ID_Var_CYP_Km 0x001b5
#define ID_Var_lnCYP_Km 0x001b6
#define ID_Var_CYP_VmaxC 0x001b7
#define ID_Var_lnCYP_VmaxC 0x001b8
#define ID_Var_UGT_Km 0x001b9
#define ID_Var_lnUGT_Km 0x001ba
#define ID_Var_UGT_VmaxC 0x001bb
#define ID_Var_lnUGT_VmaxC 0x001bc
#define ID_Var_UGT_Km_GA 0x001bd
#define ID_Var_lnUGT_Km_GA 0x001be
#define ID_Var_UGT_Ki 0x001bf
#define ID_Var_lnUGT_Ki 0x001c0
#define ID_Var_Vmax_AG 0x001c1
#define ID_Var_lnVmax_AG 0x001c2
#define ID_Var_Km_AG 0x001c3
#define ID_Var_lnKm_AG 0x001c4
#define ID_Var_SULT_KVar_apap 0x001c5
#define ID_Var_lnSULT_Km_apap 0x001c6
#define ID_Var_SULT_KVar_paps 0x001c7
#define ID_Var_lnSULT_Km_paps 0x001c8
#define ID_Var_SULT_Ki 0x001c9
#define ID_Var_lnSULT_Ki 0x001ca
#define ID_Var_SULT_VmaxC 0x001cb
#define ID_Var_lnSULT_VmaxC 0x001cc
#define ID_Var_Vmax_AS 0x001cd
#define ID_Var_lnVmax_AS 0x001ce
#define ID_Var_Km_AS 0x001cf
#define ID_Var_lnKm_AS 0x001d0
#define ID_Verr_CPL_APAP_mcmolL 0x001d1
#define ID_Verr_CPL_APAP_mcgL 0x001d2
#define ID_Verr_CPL_AG_mcmolL 0x001d3
#define ID_Verr_CPL_AG_mcgL 0x001d4
#define ID_Verr_CPL_AS_mcmolL 0x001d5
#define ID_Verr_CPL_AS_mcgL 0x001d6
#define ID_Verr_CU_APAP_mcg 0x001d7
#define ID_Verr_CU_AG_mcg 0x001d8
#define ID_Verr_CU_AS_mcg 0x001d9


/*----- Global Variables */

/* For export. Keep track of who we are. */
char szModelDescFilename[] = "APAP_PBPK_thera.model";
char szModelSourceFilename[] = __FILE__;
char szModelGenAndVersion[] = "mod v5.6.6";

/* Externs */
extern BOOL vbModelReinitd;

/* Model Dimensions */
int vnStates = 44;
int vnOutputs = 55;
int vnModelVars = 99;
int vnInputs = 2;
int vnParms = 373;

/* States and Outputs*/
double vrgModelVars[99];

/* Inputs */
IFN vrgInputs[2];

/* Parameters */
double MW_APAP;
double MW_AG;
double MW_AS;
double BW;
double lnBW;
double QCC;
double VFC;
double VKC;
double VGC;
double VLC;
double VMC;
double VBLAC;
double VBLVC;
double VSC;
double VRC;
double QFC;
double QKC;
double QGC;
double QLBC;
double QMC;
double QSC;
double QRC;
double kSG_Vm;
double lnkSG_Vm;
double kSG_Km;
double lnkSG_Km;
double Tg;
double lnTg;
double Tp;
double lnTp;
double CLC_APAP;
double lnCLC_APAP;
double CLC_AS;
double lnCLC_AS;
double CLC_AG;
double lnCLC_AG;
double alpha_APAP;
double alpha_AS;
double alpha_AG;
double BP_APAP;
double lnBP_APAP;
double PF_APAP;
double lnPF_APAP;
double PG_APAP;
double lnPG_APAP;
double PK_APAP;
double lnPK_APAP;
double PL_APAP;
double lnPL_APAP;
double PM_APAP;
double lnPM_APAP;
double PR_APAP;
double lnPR_APAP;
double PS_APAP;
double lnPS_APAP;
double PF_AS;
double lnPF_AS;
double PG_AS;
double lnPG_AS;
double PK_AS;
double lnPK_AS;
double PL_AS;
double lnPL_AS;
double PM_AS;
double lnPM_AS;
double PR_AS;
double lnPR_AS;
double PS_AS;
double lnPS_AS;
double PF_AG;
double lnPF_AG;
double PG_AG;
double lnPG_AG;
double PK_AG;
double lnPK_AG;
double PL_AG;
double lnPL_AG;
double PM_AG;
double lnPM_AG;
double PR_AG;
double lnPR_AG;
double PS_AG;
double lnPS_AG;
double kPAPS;
double lnkPAPS;
double kPAPS_syn;
double lnkPAPS_syn;
double kGA;
double lnkGA;
double kGA_syn;
double lnkGA_syn;
double CYP_Km;
double lnCYP_Km;
double CYP_VmaxC;
double lnCYP_VmaxC;
double UGT_Km;
double lnUGT_Km;
double UGT_Ki;
double lnUGT_Ki;
double UGT_VmaxC;
double lnUGT_VmaxC;
double UGT_Km_GA;
double lnUGT_Km_GA;
double Vmax_AG;
double lnVmax_AG;
double Km_AG;
double lnKm_AG;
double SULT_Km_apap;
double lnSULT_Km_apap;
double SULT_Km_paps;
double lnSULT_Km_paps;
double SULT_Ki;
double lnSULT_Ki;
double SULT_VmaxC;
double lnSULT_VmaxC;
double Vmax_AS;
double lnVmax_AS;
double Km_AS;
double lnKm_AS;
double mgkg_flag;
double OralDose_APAP_mgkg;
double OralDose_APAP_mg;
double OralDur_APAP;
double ODose_APAP_mg;
double fa;
double ODose_APAP;
double true_dose;
double IVDose_APAP_mgkg;
double lnIVDose_APAP_mgkg;
double IVDose_APAP_mg;
double lnIVDose_APAP_mg;
double IVDur_APAP;
double IVD_APAP_mg;
double IVDR_APAP;
double CYP_Vmax;
double UGT_Vmax;
double SULT_Vmax;
double VTC;
double VF;
double VK;
double VG;
double VM;
double VL;
double VBLA;
double VBLV;
double VR;
double VS;
double QTC;
double QC;
double QF;
double QK;
double QG;
double QM;
double QLB;
double QR;
double QS;
double QL;
double CLR_APAP;
double CLR_AS;
double CLR_AG;
double M_OralDose_APAP;
double Var_OralDose_APAP;
double M_IVDose_APAP;
double Var_IVDose_APAP;
double M_lnOralDose_APAP;
double Var_lnOralDose_APAP;
double M_lnIVDose_APAP;
double M_lnVar_IVDose_APAP;
double M_BW;
double M_lnBW;
double M_fa;
double M_lnfa;
double M_kSG_Vm;
double M_lnkSG_Vm;
double M_kSG_Km;
double M_lnkSG_Km;
double M_Tg;
double M_lnTg;
double M_Tp;
double M_lnTp;
double M_CLC_APAP;
double M_lnCLC_APAP;
double M_CLC_AS;
double M_lnCLC_AS;
double M_CLC_AG;
double M_lnCLC_AG;
double M_BP_APAP;
double M_lnBP_APAP;
double M_PF_APAP;
double M_lnPF_APAP;
double M_PG_APAP;
double M_lnPG_APAP;
double M_PK_APAP;
double M_lnPK_APAP;
double M_PL_APAP;
double M_lnPL_APAP;
double M_PM_APAP;
double M_lnPM_APAP;
double M_PR_APAP;
double M_lnPR_APAP;
double M_PS_APAP;
double M_lnPS_APAP;
double M_PK_AS;
double M_lnPK_AS;
double M_PF_AS;
double M_lnPF_AS;
double M_PL_AS;
double M_lnPL_AS;
double M_PG_AS;
double M_lnPG_AS;
double M_PM_AS;
double M_lnPM_AS;
double M_PR_AS;
double M_lnPR_AS;
double M_PS_AS;
double M_lnPS_AS;
double M_PK_AG;
double M_lnPK_AG;
double M_PF_AG;
double M_lnPF_AG;
double M_PL_AG;
double M_lnPL_AG;
double M_PG_AG;
double M_lnPG_AG;
double M_PM_AG;
double M_lnPM_AG;
double M_PR_AG;
double M_lnPR_AG;
double M_PS_AG;
double M_lnPS_AG;
double M_kPAPS;
double M_lnkPAPS;
double M_kPAPS_syn;
double M_lnkPAPS_syn;
double M_kGA;
double M_lnkGA;
double M_kGA_syn;
double M_lnkGA_syn;
double M_CYP_Km;
double M_lnCYP_Km;
double M_CYP_VmaxC;
double M_lnCYP_VmaxC;
double M_UGT_Km;
double M_lnUGT_Km;
double M_UGT_VmaxC;
double M_lnUGT_VmaxC;
double M_UGT_Km_GA;
double M_lnUGT_Km_GA;
double M_UGT_Ki;
double M_lnUGT_Ki;
double M_Vmax_AG;
double M_lnVmax_AG;
double M_Km_AG;
double M_lnKm_AG;
double M_SULT_Km_apap;
double M_lnSULT_Km_apap;
double M_SULT_Km_paps;
double M_lnSULT_Km_paps;
double M_SULT_Ki;
double M_lnSULT_Ki;
double M_SULT_VmaxC;
double M_lnSULT_VmaxC;
double M_Vmax_AS;
double M_lnVmax_AS;
double M_Km_AS;
double M_lnKm_AS;
double Var_BW;
double Var_lnBW;
double Var_fa;
double Var_lnfa;
double Var_kSG_Vm;
double Var_lnkSG_Vm;
double Var_kSG_Km;
double Var_lnkSG_Km;
double Var_Tg;
double Var_lnTg;
double Var_Tp;
double Var_lnTp;
double Var_CLC_APAP;
double Var_lnCLC_APAP;
double Var_CLC_AS;
double Var_lnCLC_AS;
double Var_CLC_AG;
double Var_lnCLC_AG;
double Var_BP_APAP;
double Var_lnBP_APAP;
double Var_PF_APAP;
double Var_lnPF_APAP;
double Var_PG_APAP;
double Var_lnPG_APAP;
double Var_PK_APAP;
double Var_lnPK_APAP;
double Var_PL_APAP;
double Var_lnPL_APAP;
double Var_PM_APAP;
double Var_lnPM_APAP;
double Var_PR_APAP;
double Var_lnPR_APAP;
double Var_PS_APAP;
double Var_lnPS_APAP;
double Var_PK_AS;
double Var_lnPK_AS;
double Var_PF_AS;
double Var_lnPF_AS;
double Var_PL_AS;
double Var_lnPL_AS;
double Var_PG_AS;
double Var_lnPG_AS;
double Var_PM_AS;
double Var_lnPM_AS;
double Var_PR_AS;
double Var_lnPR_AS;
double Var_PS_AS;
double Var_lnPS_AS;
double Var_PK_AG;
double Var_lnPK_AG;
double Var_PF_AG;
double Var_lnPF_AG;
double Var_PL_AG;
double Var_lnPL_AG;
double Var_PG_AG;
double Var_lnPG_AG;
double Var_PM_AG;
double Var_lnPM_AG;
double Var_PR_AG;
double Var_lnPR_AG;
double Var_PS_AG;
double Var_lnPS_AG;
double Var_kPAPS;
double Var_lnkPAPS;
double Var_kPAPS_syn;
double Var_lnkPAPS_syn;
double Var_kGA;
double Var_lnkGA;
double Var_kGA_syn;
double Var_lnkGA_syn;
double Var_CYP_Km;
double Var_lnCYP_Km;
double Var_CYP_VmaxC;
double Var_lnCYP_VmaxC;
double Var_UGT_Km;
double Var_lnUGT_Km;
double Var_UGT_VmaxC;
double Var_lnUGT_VmaxC;
double Var_UGT_Km_GA;
double Var_lnUGT_Km_GA;
double Var_UGT_Ki;
double Var_lnUGT_Ki;
double Var_Vmax_AG;
double Var_lnVmax_AG;
double Var_Km_AG;
double Var_lnKm_AG;
double Var_SULT_KVar_apap;
double Var_lnSULT_Km_apap;
double Var_SULT_KVar_paps;
double Var_lnSULT_Km_paps;
double Var_SULT_Ki;
double Var_lnSULT_Ki;
double Var_SULT_VmaxC;
double Var_lnSULT_VmaxC;
double Var_Vmax_AS;
double Var_lnVmax_AS;
double Var_Km_AS;
double Var_lnKm_AS;
double Verr_CPL_APAP_mcmolL;
double Verr_CPL_APAP_mcgL;
double Verr_CPL_AG_mcmolL;
double Verr_CPL_AG_mcgL;
double Verr_CPL_AS_mcmolL;
double Verr_CPL_AS_mcgL;
double Verr_CU_APAP_mcg;
double Verr_CU_AG_mcg;
double Verr_CU_AS_mcg;

BOOL bDelays = 0;


/*----- Global Variable Map */

VMMAPSTRCT vrgvmGlo[] = {
  {"CL_APAP_to_NAPQI_CYP", (PVOID) &vrgModelVars[ID_CL_APAP_to_NAPQI_CYP], ID_STATE | ID_CL_APAP_to_NAPQI_CYP},
  {"CL_APAP_to_AS_SULT", (PVOID) &vrgModelVars[ID_CL_APAP_to_AS_SULT], ID_STATE | ID_CL_APAP_to_AS_SULT},
  {"CL_APAP_to_AG_UGT", (PVOID) &vrgModelVars[ID_CL_APAP_to_AG_UGT], ID_STATE | ID_CL_APAP_to_AG_UGT},
  {"AST_Oral_APAP", (PVOID) &vrgModelVars[ID_AST_Oral_APAP], ID_STATE | ID_AST_Oral_APAP},
  {"AST_APAP", (PVOID) &vrgModelVars[ID_AST_APAP], ID_STATE | ID_AST_APAP},
  {"AST_to_Gut_APAP", (PVOID) &vrgModelVars[ID_AST_to_Gut_APAP], ID_STATE | ID_AST_to_Gut_APAP},
  {"AF_APAP", (PVOID) &vrgModelVars[ID_AF_APAP], ID_STATE | ID_AF_APAP},
  {"AR_APAP", (PVOID) &vrgModelVars[ID_AR_APAP], ID_STATE | ID_AR_APAP},
  {"AS_APAP", (PVOID) &vrgModelVars[ID_AS_APAP], ID_STATE | ID_AS_APAP},
  {"AF_AS", (PVOID) &vrgModelVars[ID_AF_AS], ID_STATE | ID_AF_AS},
  {"AR_AS", (PVOID) &vrgModelVars[ID_AR_AS], ID_STATE | ID_AR_AS},
  {"AS_AS", (PVOID) &vrgModelVars[ID_AS_AS], ID_STATE | ID_AS_AS},
  {"AF_AG", (PVOID) &vrgModelVars[ID_AF_AG], ID_STATE | ID_AF_AG},
  {"AR_AG", (PVOID) &vrgModelVars[ID_AR_AG], ID_STATE | ID_AR_AG},
  {"AS_AG", (PVOID) &vrgModelVars[ID_AS_AG], ID_STATE | ID_AS_AG},
  {"AKE_APAP", (PVOID) &vrgModelVars[ID_AKE_APAP], ID_STATE | ID_AKE_APAP},
  {"AKE_AS", (PVOID) &vrgModelVars[ID_AKE_AS], ID_STATE | ID_AKE_AS},
  {"AKE_AG", (PVOID) &vrgModelVars[ID_AKE_AG], ID_STATE | ID_AKE_AG},
  {"AK_APAP", (PVOID) &vrgModelVars[ID_AK_APAP], ID_STATE | ID_AK_APAP},
  {"AK_AS", (PVOID) &vrgModelVars[ID_AK_AS], ID_STATE | ID_AK_AS},
  {"AK_AG", (PVOID) &vrgModelVars[ID_AK_AG], ID_STATE | ID_AK_AG},
  {"AL_APAP", (PVOID) &vrgModelVars[ID_AL_APAP], ID_STATE | ID_AL_APAP},
  {"AL_AS", (PVOID) &vrgModelVars[ID_AL_AS], ID_STATE | ID_AL_AS},
  {"AL_AG", (PVOID) &vrgModelVars[ID_AL_AG], ID_STATE | ID_AL_AG},
  {"AL_PAPS", (PVOID) &vrgModelVars[ID_AL_PAPS], ID_STATE | ID_AL_PAPS},
  {"AL_GA", (PVOID) &vrgModelVars[ID_AL_GA], ID_STATE | ID_AL_GA},
  {"CH_AG", (PVOID) &vrgModelVars[ID_CH_AG], ID_STATE | ID_CH_AG},
  {"CH_AG_to_CL_AG", (PVOID) &vrgModelVars[ID_CH_AG_to_CL_AG], ID_STATE | ID_CH_AG_to_CL_AG},
  {"CH_AS", (PVOID) &vrgModelVars[ID_CH_AS], ID_STATE | ID_CH_AS},
  {"CH_AS_to_CL_AS", (PVOID) &vrgModelVars[ID_CH_AS_to_CL_AS], ID_STATE | ID_CH_AS_to_CL_AS},
  {"AM_APAP", (PVOID) &vrgModelVars[ID_AM_APAP], ID_STATE | ID_AM_APAP},
  {"AM_AS", (PVOID) &vrgModelVars[ID_AM_AS], ID_STATE | ID_AM_AS},
  {"AM_AG", (PVOID) &vrgModelVars[ID_AM_AG], ID_STATE | ID_AM_AG},
  {"ABLA_APAP", (PVOID) &vrgModelVars[ID_ABLA_APAP], ID_STATE | ID_ABLA_APAP},
  {"ABLA_AS", (PVOID) &vrgModelVars[ID_ABLA_AS], ID_STATE | ID_ABLA_AS},
  {"ABLA_AG", (PVOID) &vrgModelVars[ID_ABLA_AG], ID_STATE | ID_ABLA_AG},
  {"ABL_IV_APAP", (PVOID) &vrgModelVars[ID_ABL_IV_APAP], ID_STATE | ID_ABL_IV_APAP},
  {"ABLV_APAP", (PVOID) &vrgModelVars[ID_ABLV_APAP], ID_STATE | ID_ABLV_APAP},
  {"ABLV_AS", (PVOID) &vrgModelVars[ID_ABLV_AS], ID_STATE | ID_ABLV_AS},
  {"ABLV_AG", (PVOID) &vrgModelVars[ID_ABLV_AG], ID_STATE | ID_ABLV_AG},
  {"AU_APAP", (PVOID) &vrgModelVars[ID_AU_APAP], ID_STATE | ID_AU_APAP},
  {"AU_AS", (PVOID) &vrgModelVars[ID_AU_AS], ID_STATE | ID_AU_AS},
  {"AU_AG", (PVOID) &vrgModelVars[ID_AU_AG], ID_STATE | ID_AU_AG},
  {"pct_abs", (PVOID) &vrgModelVars[ID_pct_abs], ID_STATE | ID_pct_abs},
  {"CF_APAP", (PVOID) &vrgModelVars[ID_CF_APAP], ID_OUTPUT | ID_CF_APAP},
  {"CK_APAP", (PVOID) &vrgModelVars[ID_CK_APAP], ID_OUTPUT | ID_CK_APAP},
  {"CL_APAP", (PVOID) &vrgModelVars[ID_CL_APAP], ID_OUTPUT | ID_CL_APAP},
  {"CR_APAP", (PVOID) &vrgModelVars[ID_CR_APAP], ID_OUTPUT | ID_CR_APAP},
  {"CS_APAP", (PVOID) &vrgModelVars[ID_CS_APAP], ID_OUTPUT | ID_CS_APAP},
  {"CF_AS", (PVOID) &vrgModelVars[ID_CF_AS], ID_OUTPUT | ID_CF_AS},
  {"CK_AS", (PVOID) &vrgModelVars[ID_CK_AS], ID_OUTPUT | ID_CK_AS},
  {"CL_AS", (PVOID) &vrgModelVars[ID_CL_AS], ID_OUTPUT | ID_CL_AS},
  {"CR_AS", (PVOID) &vrgModelVars[ID_CR_AS], ID_OUTPUT | ID_CR_AS},
  {"CS_AS", (PVOID) &vrgModelVars[ID_CS_AS], ID_OUTPUT | ID_CS_AS},
  {"CF_AG", (PVOID) &vrgModelVars[ID_CF_AG], ID_OUTPUT | ID_CF_AG},
  {"CK_AG", (PVOID) &vrgModelVars[ID_CK_AG], ID_OUTPUT | ID_CK_AG},
  {"CL_AG", (PVOID) &vrgModelVars[ID_CL_AG], ID_OUTPUT | ID_CL_AG},
  {"CR_AG", (PVOID) &vrgModelVars[ID_CR_AG], ID_OUTPUT | ID_CR_AG},
  {"CS_AG", (PVOID) &vrgModelVars[ID_CS_AG], ID_OUTPUT | ID_CS_AG},
  {"CA_APAP", (PVOID) &vrgModelVars[ID_CA_APAP], ID_OUTPUT | ID_CA_APAP},
  {"CV_APAP", (PVOID) &vrgModelVars[ID_CV_APAP], ID_OUTPUT | ID_CV_APAP},
  {"CPL_APAP", (PVOID) &vrgModelVars[ID_CPL_APAP], ID_OUTPUT | ID_CPL_APAP},
  {"CA_AS", (PVOID) &vrgModelVars[ID_CA_AS], ID_OUTPUT | ID_CA_AS},
  {"CV_AS", (PVOID) &vrgModelVars[ID_CV_AS], ID_OUTPUT | ID_CV_AS},
  {"CPL_AS", (PVOID) &vrgModelVars[ID_CPL_AS], ID_OUTPUT | ID_CPL_AS},
  {"CA_AG", (PVOID) &vrgModelVars[ID_CA_AG], ID_OUTPUT | ID_CA_AG},
  {"CV_AG", (PVOID) &vrgModelVars[ID_CV_AG], ID_OUTPUT | ID_CV_AG},
  {"CPL_AG", (PVOID) &vrgModelVars[ID_CPL_AG], ID_OUTPUT | ID_CPL_AG},
  {"CPL_APAP_mcmolL", (PVOID) &vrgModelVars[ID_CPL_APAP_mcmolL], ID_OUTPUT | ID_CPL_APAP_mcmolL},
  {"CPL_APAP_mcgL", (PVOID) &vrgModelVars[ID_CPL_APAP_mcgL], ID_OUTPUT | ID_CPL_APAP_mcgL},
  {"CPL_AG_mcmolL", (PVOID) &vrgModelVars[ID_CPL_AG_mcmolL], ID_OUTPUT | ID_CPL_AG_mcmolL},
  {"CPL_AG_mcgL", (PVOID) &vrgModelVars[ID_CPL_AG_mcgL], ID_OUTPUT | ID_CPL_AG_mcgL},
  {"CPL_AS_mcmolL", (PVOID) &vrgModelVars[ID_CPL_AS_mcmolL], ID_OUTPUT | ID_CPL_AS_mcmolL},
  {"CPL_AS_mcgL", (PVOID) &vrgModelVars[ID_CPL_AS_mcgL], ID_OUTPUT | ID_CPL_AS_mcgL},
  {"CL_APAP_mcmolL", (PVOID) &vrgModelVars[ID_CL_APAP_mcmolL], ID_OUTPUT | ID_CL_APAP_mcmolL},
  {"CL_APAP_mcgL", (PVOID) &vrgModelVars[ID_CL_APAP_mcgL], ID_OUTPUT | ID_CL_APAP_mcgL},
  {"CU_APAP_mcg", (PVOID) &vrgModelVars[ID_CU_APAP_mcg], ID_OUTPUT | ID_CU_APAP_mcg},
  {"CU_AG_mcg", (PVOID) &vrgModelVars[ID_CU_AG_mcg], ID_OUTPUT | ID_CU_AG_mcg},
  {"CU_AS_mcg", (PVOID) &vrgModelVars[ID_CU_AS_mcg], ID_OUTPUT | ID_CU_AS_mcg},
  {"f_abs", (PVOID) &vrgModelVars[ID_f_abs], ID_OUTPUT | ID_f_abs},
  {"lntrue_dose", (PVOID) &vrgModelVars[ID_lntrue_dose], ID_OUTPUT | ID_lntrue_dose},
  {"lnODose_APAP", (PVOID) &vrgModelVars[ID_lnODose_APAP], ID_OUTPUT | ID_lnODose_APAP},
  {"lnfa", (PVOID) &vrgModelVars[ID_lnfa], ID_OUTPUT | ID_lnfa},
  {"lnCPL_APAP_mcgL", (PVOID) &vrgModelVars[ID_lnCPL_APAP_mcgL], ID_OUTPUT | ID_lnCPL_APAP_mcgL},
  {"lnCPL_AG_mcgL", (PVOID) &vrgModelVars[ID_lnCPL_AG_mcgL], ID_OUTPUT | ID_lnCPL_AG_mcgL},
  {"lnCPL_AS_mcgL", (PVOID) &vrgModelVars[ID_lnCPL_AS_mcgL], ID_OUTPUT | ID_lnCPL_AS_mcgL},
  {"lnCU_APAP_mcg", (PVOID) &vrgModelVars[ID_lnCU_APAP_mcg], ID_OUTPUT | ID_lnCU_APAP_mcg},
  {"lnCU_AG_mcg", (PVOID) &vrgModelVars[ID_lnCU_AG_mcg], ID_OUTPUT | ID_lnCU_AG_mcg},
  {"lnCU_AS_mcg", (PVOID) &vrgModelVars[ID_lnCU_AS_mcg], ID_OUTPUT | ID_lnCU_AS_mcg},
  {"lnf_abs", (PVOID) &vrgModelVars[ID_lnf_abs], ID_OUTPUT | ID_lnf_abs},
  {"Verr_lnCPL_APAP_mcmolL", (PVOID) &vrgModelVars[ID_Verr_lnCPL_APAP_mcmolL], ID_OUTPUT | ID_Verr_lnCPL_APAP_mcmolL},
  {"Verr_lnCPL_APAP_mcgL", (PVOID) &vrgModelVars[ID_Verr_lnCPL_APAP_mcgL], ID_OUTPUT | ID_Verr_lnCPL_APAP_mcgL},
  {"Verr_lnCPL_AG_mcmolL", (PVOID) &vrgModelVars[ID_Verr_lnCPL_AG_mcmolL], ID_OUTPUT | ID_Verr_lnCPL_AG_mcmolL},
  {"Verr_lnCPL_AG_mcgL", (PVOID) &vrgModelVars[ID_Verr_lnCPL_AG_mcgL], ID_OUTPUT | ID_Verr_lnCPL_AG_mcgL},
  {"Verr_lnCPL_AS_mcmolL", (PVOID) &vrgModelVars[ID_Verr_lnCPL_AS_mcmolL], ID_OUTPUT | ID_Verr_lnCPL_AS_mcmolL},
  {"Verr_lnCPL_AS_mcgL", (PVOID) &vrgModelVars[ID_Verr_lnCPL_AS_mcgL], ID_OUTPUT | ID_Verr_lnCPL_AS_mcgL},
  {"Verr_lnCU_APAP_mcg", (PVOID) &vrgModelVars[ID_Verr_lnCU_APAP_mcg], ID_OUTPUT | ID_Verr_lnCU_APAP_mcg},
  {"Verr_lnCU_AG_mcg", (PVOID) &vrgModelVars[ID_Verr_lnCU_AG_mcg], ID_OUTPUT | ID_Verr_lnCU_AG_mcg},
  {"Verr_lnCU_AS_mcg", (PVOID) &vrgModelVars[ID_Verr_lnCU_AS_mcg], ID_OUTPUT | ID_Verr_lnCU_AS_mcg},
  {"OralExp_APAP", (PVOID) &vrgInputs[ID_OralExp_APAP], ID_INPUT | ID_OralExp_APAP},
  {"IVExp_APAP", (PVOID) &vrgInputs[ID_IVExp_APAP], ID_INPUT | ID_IVExp_APAP},
  {"MW_APAP", (PVOID) &MW_APAP, ID_PARM | ID_MW_APAP},
  {"MW_AG", (PVOID) &MW_AG, ID_PARM | ID_MW_AG},
  {"MW_AS", (PVOID) &MW_AS, ID_PARM | ID_MW_AS},
  {"BW", (PVOID) &BW, ID_PARM | ID_BW},
  {"lnBW", (PVOID) &lnBW, ID_PARM | ID_lnBW},
  {"QCC", (PVOID) &QCC, ID_PARM | ID_QCC},
  {"VFC", (PVOID) &VFC, ID_PARM | ID_VFC},
  {"VKC", (PVOID) &VKC, ID_PARM | ID_VKC},
  {"VGC", (PVOID) &VGC, ID_PARM | ID_VGC},
  {"VLC", (PVOID) &VLC, ID_PARM | ID_VLC},
  {"VMC", (PVOID) &VMC, ID_PARM | ID_VMC},
  {"VBLAC", (PVOID) &VBLAC, ID_PARM | ID_VBLAC},
  {"VBLVC", (PVOID) &VBLVC, ID_PARM | ID_VBLVC},
  {"VSC", (PVOID) &VSC, ID_PARM | ID_VSC},
  {"VRC", (PVOID) &VRC, ID_PARM | ID_VRC},
  {"QFC", (PVOID) &QFC, ID_PARM | ID_QFC},
  {"QKC", (PVOID) &QKC, ID_PARM | ID_QKC},
  {"QGC", (PVOID) &QGC, ID_PARM | ID_QGC},
  {"QLBC", (PVOID) &QLBC, ID_PARM | ID_QLBC},
  {"QMC", (PVOID) &QMC, ID_PARM | ID_QMC},
  {"QSC", (PVOID) &QSC, ID_PARM | ID_QSC},
  {"QRC", (PVOID) &QRC, ID_PARM | ID_QRC},
  {"kSG_Vm", (PVOID) &kSG_Vm, ID_PARM | ID_kSG_Vm},
  {"lnkSG_Vm", (PVOID) &lnkSG_Vm, ID_PARM | ID_lnkSG_Vm},
  {"kSG_Km", (PVOID) &kSG_Km, ID_PARM | ID_kSG_Km},
  {"lnkSG_Km", (PVOID) &lnkSG_Km, ID_PARM | ID_lnkSG_Km},
  {"Tg", (PVOID) &Tg, ID_PARM | ID_Tg},
  {"lnTg", (PVOID) &lnTg, ID_PARM | ID_lnTg},
  {"Tp", (PVOID) &Tp, ID_PARM | ID_Tp},
  {"lnTp", (PVOID) &lnTp, ID_PARM | ID_lnTp},
  {"CLC_APAP", (PVOID) &CLC_APAP, ID_PARM | ID_CLC_APAP},
  {"lnCLC_APAP", (PVOID) &lnCLC_APAP, ID_PARM | ID_lnCLC_APAP},
  {"CLC_AS", (PVOID) &CLC_AS, ID_PARM | ID_CLC_AS},
  {"lnCLC_AS", (PVOID) &lnCLC_AS, ID_PARM | ID_lnCLC_AS},
  {"CLC_AG", (PVOID) &CLC_AG, ID_PARM | ID_CLC_AG},
  {"lnCLC_AG", (PVOID) &lnCLC_AG, ID_PARM | ID_lnCLC_AG},
  {"alpha_APAP", (PVOID) &alpha_APAP, ID_PARM | ID_alpha_APAP},
  {"alpha_AS", (PVOID) &alpha_AS, ID_PARM | ID_alpha_AS},
  {"alpha_AG", (PVOID) &alpha_AG, ID_PARM | ID_alpha_AG},
  {"BP_APAP", (PVOID) &BP_APAP, ID_PARM | ID_BP_APAP},
  {"lnBP_APAP", (PVOID) &lnBP_APAP, ID_PARM | ID_lnBP_APAP},
  {"PF_APAP", (PVOID) &PF_APAP, ID_PARM | ID_PF_APAP},
  {"lnPF_APAP", (PVOID) &lnPF_APAP, ID_PARM | ID_lnPF_APAP},
  {"PG_APAP", (PVOID) &PG_APAP, ID_PARM | ID_PG_APAP},
  {"lnPG_APAP", (PVOID) &lnPG_APAP, ID_PARM | ID_lnPG_APAP},
  {"PK_APAP", (PVOID) &PK_APAP, ID_PARM | ID_PK_APAP},
  {"lnPK_APAP", (PVOID) &lnPK_APAP, ID_PARM | ID_lnPK_APAP},
  {"PL_APAP", (PVOID) &PL_APAP, ID_PARM | ID_PL_APAP},
  {"lnPL_APAP", (PVOID) &lnPL_APAP, ID_PARM | ID_lnPL_APAP},
  {"PM_APAP", (PVOID) &PM_APAP, ID_PARM | ID_PM_APAP},
  {"lnPM_APAP", (PVOID) &lnPM_APAP, ID_PARM | ID_lnPM_APAP},
  {"PR_APAP", (PVOID) &PR_APAP, ID_PARM | ID_PR_APAP},
  {"lnPR_APAP", (PVOID) &lnPR_APAP, ID_PARM | ID_lnPR_APAP},
  {"PS_APAP", (PVOID) &PS_APAP, ID_PARM | ID_PS_APAP},
  {"lnPS_APAP", (PVOID) &lnPS_APAP, ID_PARM | ID_lnPS_APAP},
  {"PF_AS", (PVOID) &PF_AS, ID_PARM | ID_PF_AS},
  {"lnPF_AS", (PVOID) &lnPF_AS, ID_PARM | ID_lnPF_AS},
  {"PG_AS", (PVOID) &PG_AS, ID_PARM | ID_PG_AS},
  {"lnPG_AS", (PVOID) &lnPG_AS, ID_PARM | ID_lnPG_AS},
  {"PK_AS", (PVOID) &PK_AS, ID_PARM | ID_PK_AS},
  {"lnPK_AS", (PVOID) &lnPK_AS, ID_PARM | ID_lnPK_AS},
  {"PL_AS", (PVOID) &PL_AS, ID_PARM | ID_PL_AS},
  {"lnPL_AS", (PVOID) &lnPL_AS, ID_PARM | ID_lnPL_AS},
  {"PM_AS", (PVOID) &PM_AS, ID_PARM | ID_PM_AS},
  {"lnPM_AS", (PVOID) &lnPM_AS, ID_PARM | ID_lnPM_AS},
  {"PR_AS", (PVOID) &PR_AS, ID_PARM | ID_PR_AS},
  {"lnPR_AS", (PVOID) &lnPR_AS, ID_PARM | ID_lnPR_AS},
  {"PS_AS", (PVOID) &PS_AS, ID_PARM | ID_PS_AS},
  {"lnPS_AS", (PVOID) &lnPS_AS, ID_PARM | ID_lnPS_AS},
  {"PF_AG", (PVOID) &PF_AG, ID_PARM | ID_PF_AG},
  {"lnPF_AG", (PVOID) &lnPF_AG, ID_PARM | ID_lnPF_AG},
  {"PG_AG", (PVOID) &PG_AG, ID_PARM | ID_PG_AG},
  {"lnPG_AG", (PVOID) &lnPG_AG, ID_PARM | ID_lnPG_AG},
  {"PK_AG", (PVOID) &PK_AG, ID_PARM | ID_PK_AG},
  {"lnPK_AG", (PVOID) &lnPK_AG, ID_PARM | ID_lnPK_AG},
  {"PL_AG", (PVOID) &PL_AG, ID_PARM | ID_PL_AG},
  {"lnPL_AG", (PVOID) &lnPL_AG, ID_PARM | ID_lnPL_AG},
  {"PM_AG", (PVOID) &PM_AG, ID_PARM | ID_PM_AG},
  {"lnPM_AG", (PVOID) &lnPM_AG, ID_PARM | ID_lnPM_AG},
  {"PR_AG", (PVOID) &PR_AG, ID_PARM | ID_PR_AG},
  {"lnPR_AG", (PVOID) &lnPR_AG, ID_PARM | ID_lnPR_AG},
  {"PS_AG", (PVOID) &PS_AG, ID_PARM | ID_PS_AG},
  {"lnPS_AG", (PVOID) &lnPS_AG, ID_PARM | ID_lnPS_AG},
  {"kPAPS", (PVOID) &kPAPS, ID_PARM | ID_kPAPS},
  {"lnkPAPS", (PVOID) &lnkPAPS, ID_PARM | ID_lnkPAPS},
  {"kPAPS_syn", (PVOID) &kPAPS_syn, ID_PARM | ID_kPAPS_syn},
  {"lnkPAPS_syn", (PVOID) &lnkPAPS_syn, ID_PARM | ID_lnkPAPS_syn},
  {"kGA", (PVOID) &kGA, ID_PARM | ID_kGA},
  {"lnkGA", (PVOID) &lnkGA, ID_PARM | ID_lnkGA},
  {"kGA_syn", (PVOID) &kGA_syn, ID_PARM | ID_kGA_syn},
  {"lnkGA_syn", (PVOID) &lnkGA_syn, ID_PARM | ID_lnkGA_syn},
  {"CYP_Km", (PVOID) &CYP_Km, ID_PARM | ID_CYP_Km},
  {"lnCYP_Km", (PVOID) &lnCYP_Km, ID_PARM | ID_lnCYP_Km},
  {"CYP_VmaxC", (PVOID) &CYP_VmaxC, ID_PARM | ID_CYP_VmaxC},
  {"lnCYP_VmaxC", (PVOID) &lnCYP_VmaxC, ID_PARM | ID_lnCYP_VmaxC},
  {"UGT_Km", (PVOID) &UGT_Km, ID_PARM | ID_UGT_Km},
  {"lnUGT_Km", (PVOID) &lnUGT_Km, ID_PARM | ID_lnUGT_Km},
  {"UGT_Ki", (PVOID) &UGT_Ki, ID_PARM | ID_UGT_Ki},
  {"lnUGT_Ki", (PVOID) &lnUGT_Ki, ID_PARM | ID_lnUGT_Ki},
  {"UGT_VmaxC", (PVOID) &UGT_VmaxC, ID_PARM | ID_UGT_VmaxC},
  {"lnUGT_VmaxC", (PVOID) &lnUGT_VmaxC, ID_PARM | ID_lnUGT_VmaxC},
  {"UGT_Km_GA", (PVOID) &UGT_Km_GA, ID_PARM | ID_UGT_Km_GA},
  {"lnUGT_Km_GA", (PVOID) &lnUGT_Km_GA, ID_PARM | ID_lnUGT_Km_GA},
  {"Vmax_AG", (PVOID) &Vmax_AG, ID_PARM | ID_Vmax_AG},
  {"lnVmax_AG", (PVOID) &lnVmax_AG, ID_PARM | ID_lnVmax_AG},
  {"Km_AG", (PVOID) &Km_AG, ID_PARM | ID_Km_AG},
  {"lnKm_AG", (PVOID) &lnKm_AG, ID_PARM | ID_lnKm_AG},
  {"SULT_Km_apap", (PVOID) &SULT_Km_apap, ID_PARM | ID_SULT_Km_apap},
  {"lnSULT_Km_apap", (PVOID) &lnSULT_Km_apap, ID_PARM | ID_lnSULT_Km_apap},
  {"SULT_Km_paps", (PVOID) &SULT_Km_paps, ID_PARM | ID_SULT_Km_paps},
  {"lnSULT_Km_paps", (PVOID) &lnSULT_Km_paps, ID_PARM | ID_lnSULT_Km_paps},
  {"SULT_Ki", (PVOID) &SULT_Ki, ID_PARM | ID_SULT_Ki},
  {"lnSULT_Ki", (PVOID) &lnSULT_Ki, ID_PARM | ID_lnSULT_Ki},
  {"SULT_VmaxC", (PVOID) &SULT_VmaxC, ID_PARM | ID_SULT_VmaxC},
  {"lnSULT_VmaxC", (PVOID) &lnSULT_VmaxC, ID_PARM | ID_lnSULT_VmaxC},
  {"Vmax_AS", (PVOID) &Vmax_AS, ID_PARM | ID_Vmax_AS},
  {"lnVmax_AS", (PVOID) &lnVmax_AS, ID_PARM | ID_lnVmax_AS},
  {"Km_AS", (PVOID) &Km_AS, ID_PARM | ID_Km_AS},
  {"lnKm_AS", (PVOID) &lnKm_AS, ID_PARM | ID_lnKm_AS},
  {"mgkg_flag", (PVOID) &mgkg_flag, ID_PARM | ID_mgkg_flag},
  {"OralDose_APAP_mgkg", (PVOID) &OralDose_APAP_mgkg, ID_PARM | ID_OralDose_APAP_mgkg},
  {"OralDose_APAP_mg", (PVOID) &OralDose_APAP_mg, ID_PARM | ID_OralDose_APAP_mg},
  {"OralDur_APAP", (PVOID) &OralDur_APAP, ID_PARM | ID_OralDur_APAP},
  {"ODose_APAP_mg", (PVOID) &ODose_APAP_mg, ID_PARM | ID_ODose_APAP_mg},
  {"fa", (PVOID) &fa, ID_PARM | ID_fa},
  {"ODose_APAP", (PVOID) &ODose_APAP, ID_PARM | ID_ODose_APAP},
  {"true_dose", (PVOID) &true_dose, ID_PARM | ID_true_dose},
  {"IVDose_APAP_mgkg", (PVOID) &IVDose_APAP_mgkg, ID_PARM | ID_IVDose_APAP_mgkg},
  {"lnIVDose_APAP_mgkg", (PVOID) &lnIVDose_APAP_mgkg, ID_PARM | ID_lnIVDose_APAP_mgkg},
  {"IVDose_APAP_mg", (PVOID) &IVDose_APAP_mg, ID_PARM | ID_IVDose_APAP_mg},
  {"lnIVDose_APAP_mg", (PVOID) &lnIVDose_APAP_mg, ID_PARM | ID_lnIVDose_APAP_mg},
  {"IVDur_APAP", (PVOID) &IVDur_APAP, ID_PARM | ID_IVDur_APAP},
  {"IVD_APAP_mg", (PVOID) &IVD_APAP_mg, ID_PARM | ID_IVD_APAP_mg},
  {"IVDR_APAP", (PVOID) &IVDR_APAP, ID_PARM | ID_IVDR_APAP},
  {"CYP_Vmax", (PVOID) &CYP_Vmax, ID_PARM | ID_CYP_Vmax},
  {"UGT_Vmax", (PVOID) &UGT_Vmax, ID_PARM | ID_UGT_Vmax},
  {"SULT_Vmax", (PVOID) &SULT_Vmax, ID_PARM | ID_SULT_Vmax},
  {"VTC", (PVOID) &VTC, ID_PARM | ID_VTC},
  {"VF", (PVOID) &VF, ID_PARM | ID_VF},
  {"VK", (PVOID) &VK, ID_PARM | ID_VK},
  {"VG", (PVOID) &VG, ID_PARM | ID_VG},
  {"VM", (PVOID) &VM, ID_PARM | ID_VM},
  {"VL", (PVOID) &VL, ID_PARM | ID_VL},
  {"VBLA", (PVOID) &VBLA, ID_PARM | ID_VBLA},
  {"VBLV", (PVOID) &VBLV, ID_PARM | ID_VBLV},
  {"VR", (PVOID) &VR, ID_PARM | ID_VR},
  {"VS", (PVOID) &VS, ID_PARM | ID_VS},
  {"QTC", (PVOID) &QTC, ID_PARM | ID_QTC},
  {"QC", (PVOID) &QC, ID_PARM | ID_QC},
  {"QF", (PVOID) &QF, ID_PARM | ID_QF},
  {"QK", (PVOID) &QK, ID_PARM | ID_QK},
  {"QG", (PVOID) &QG, ID_PARM | ID_QG},
  {"QM", (PVOID) &QM, ID_PARM | ID_QM},
  {"QLB", (PVOID) &QLB, ID_PARM | ID_QLB},
  {"QR", (PVOID) &QR, ID_PARM | ID_QR},
  {"QS", (PVOID) &QS, ID_PARM | ID_QS},
  {"QL", (PVOID) &QL, ID_PARM | ID_QL},
  {"CLR_APAP", (PVOID) &CLR_APAP, ID_PARM | ID_CLR_APAP},
  {"CLR_AS", (PVOID) &CLR_AS, ID_PARM | ID_CLR_AS},
  {"CLR_AG", (PVOID) &CLR_AG, ID_PARM | ID_CLR_AG},
  {"M_OralDose_APAP", (PVOID) &M_OralDose_APAP, ID_PARM | ID_M_OralDose_APAP},
  {"Var_OralDose_APAP", (PVOID) &Var_OralDose_APAP, ID_PARM | ID_Var_OralDose_APAP},
  {"M_IVDose_APAP", (PVOID) &M_IVDose_APAP, ID_PARM | ID_M_IVDose_APAP},
  {"Var_IVDose_APAP", (PVOID) &Var_IVDose_APAP, ID_PARM | ID_Var_IVDose_APAP},
  {"M_lnOralDose_APAP", (PVOID) &M_lnOralDose_APAP, ID_PARM | ID_M_lnOralDose_APAP},
  {"Var_lnOralDose_APAP", (PVOID) &Var_lnOralDose_APAP, ID_PARM | ID_Var_lnOralDose_APAP},
  {"M_lnIVDose_APAP", (PVOID) &M_lnIVDose_APAP, ID_PARM | ID_M_lnIVDose_APAP},
  {"M_lnVar_IVDose_APAP", (PVOID) &M_lnVar_IVDose_APAP, ID_PARM | ID_M_lnVar_IVDose_APAP},
  {"M_BW", (PVOID) &M_BW, ID_PARM | ID_M_BW},
  {"M_lnBW", (PVOID) &M_lnBW, ID_PARM | ID_M_lnBW},
  {"M_fa", (PVOID) &M_fa, ID_PARM | ID_M_fa},
  {"M_lnfa", (PVOID) &M_lnfa, ID_PARM | ID_M_lnfa},
  {"M_kSG_Vm", (PVOID) &M_kSG_Vm, ID_PARM | ID_M_kSG_Vm},
  {"M_lnkSG_Vm", (PVOID) &M_lnkSG_Vm, ID_PARM | ID_M_lnkSG_Vm},
  {"M_kSG_Km", (PVOID) &M_kSG_Km, ID_PARM | ID_M_kSG_Km},
  {"M_lnkSG_Km", (PVOID) &M_lnkSG_Km, ID_PARM | ID_M_lnkSG_Km},
  {"M_Tg", (PVOID) &M_Tg, ID_PARM | ID_M_Tg},
  {"M_lnTg", (PVOID) &M_lnTg, ID_PARM | ID_M_lnTg},
  {"M_Tp", (PVOID) &M_Tp, ID_PARM | ID_M_Tp},
  {"M_lnTp", (PVOID) &M_lnTp, ID_PARM | ID_M_lnTp},
  {"M_CLC_APAP", (PVOID) &M_CLC_APAP, ID_PARM | ID_M_CLC_APAP},
  {"M_lnCLC_APAP", (PVOID) &M_lnCLC_APAP, ID_PARM | ID_M_lnCLC_APAP},
  {"M_CLC_AS", (PVOID) &M_CLC_AS, ID_PARM | ID_M_CLC_AS},
  {"M_lnCLC_AS", (PVOID) &M_lnCLC_AS, ID_PARM | ID_M_lnCLC_AS},
  {"M_CLC_AG", (PVOID) &M_CLC_AG, ID_PARM | ID_M_CLC_AG},
  {"M_lnCLC_AG", (PVOID) &M_lnCLC_AG, ID_PARM | ID_M_lnCLC_AG},
  {"M_BP_APAP", (PVOID) &M_BP_APAP, ID_PARM | ID_M_BP_APAP},
  {"M_lnBP_APAP", (PVOID) &M_lnBP_APAP, ID_PARM | ID_M_lnBP_APAP},
  {"M_PF_APAP", (PVOID) &M_PF_APAP, ID_PARM | ID_M_PF_APAP},
  {"M_lnPF_APAP", (PVOID) &M_lnPF_APAP, ID_PARM | ID_M_lnPF_APAP},
  {"M_PG_APAP", (PVOID) &M_PG_APAP, ID_PARM | ID_M_PG_APAP},
  {"M_lnPG_APAP", (PVOID) &M_lnPG_APAP, ID_PARM | ID_M_lnPG_APAP},
  {"M_PK_APAP", (PVOID) &M_PK_APAP, ID_PARM | ID_M_PK_APAP},
  {"M_lnPK_APAP", (PVOID) &M_lnPK_APAP, ID_PARM | ID_M_lnPK_APAP},
  {"M_PL_APAP", (PVOID) &M_PL_APAP, ID_PARM | ID_M_PL_APAP},
  {"M_lnPL_APAP", (PVOID) &M_lnPL_APAP, ID_PARM | ID_M_lnPL_APAP},
  {"M_PM_APAP", (PVOID) &M_PM_APAP, ID_PARM | ID_M_PM_APAP},
  {"M_lnPM_APAP", (PVOID) &M_lnPM_APAP, ID_PARM | ID_M_lnPM_APAP},
  {"M_PR_APAP", (PVOID) &M_PR_APAP, ID_PARM | ID_M_PR_APAP},
  {"M_lnPR_APAP", (PVOID) &M_lnPR_APAP, ID_PARM | ID_M_lnPR_APAP},
  {"M_PS_APAP", (PVOID) &M_PS_APAP, ID_PARM | ID_M_PS_APAP},
  {"M_lnPS_APAP", (PVOID) &M_lnPS_APAP, ID_PARM | ID_M_lnPS_APAP},
  {"M_PK_AS", (PVOID) &M_PK_AS, ID_PARM | ID_M_PK_AS},
  {"M_lnPK_AS", (PVOID) &M_lnPK_AS, ID_PARM | ID_M_lnPK_AS},
  {"M_PF_AS", (PVOID) &M_PF_AS, ID_PARM | ID_M_PF_AS},
  {"M_lnPF_AS", (PVOID) &M_lnPF_AS, ID_PARM | ID_M_lnPF_AS},
  {"M_PL_AS", (PVOID) &M_PL_AS, ID_PARM | ID_M_PL_AS},
  {"M_lnPL_AS", (PVOID) &M_lnPL_AS, ID_PARM | ID_M_lnPL_AS},
  {"M_PG_AS", (PVOID) &M_PG_AS, ID_PARM | ID_M_PG_AS},
  {"M_lnPG_AS", (PVOID) &M_lnPG_AS, ID_PARM | ID_M_lnPG_AS},
  {"M_PM_AS", (PVOID) &M_PM_AS, ID_PARM | ID_M_PM_AS},
  {"M_lnPM_AS", (PVOID) &M_lnPM_AS, ID_PARM | ID_M_lnPM_AS},
  {"M_PR_AS", (PVOID) &M_PR_AS, ID_PARM | ID_M_PR_AS},
  {"M_lnPR_AS", (PVOID) &M_lnPR_AS, ID_PARM | ID_M_lnPR_AS},
  {"M_PS_AS", (PVOID) &M_PS_AS, ID_PARM | ID_M_PS_AS},
  {"M_lnPS_AS", (PVOID) &M_lnPS_AS, ID_PARM | ID_M_lnPS_AS},
  {"M_PK_AG", (PVOID) &M_PK_AG, ID_PARM | ID_M_PK_AG},
  {"M_lnPK_AG", (PVOID) &M_lnPK_AG, ID_PARM | ID_M_lnPK_AG},
  {"M_PF_AG", (PVOID) &M_PF_AG, ID_PARM | ID_M_PF_AG},
  {"M_lnPF_AG", (PVOID) &M_lnPF_AG, ID_PARM | ID_M_lnPF_AG},
  {"M_PL_AG", (PVOID) &M_PL_AG, ID_PARM | ID_M_PL_AG},
  {"M_lnPL_AG", (PVOID) &M_lnPL_AG, ID_PARM | ID_M_lnPL_AG},
  {"M_PG_AG", (PVOID) &M_PG_AG, ID_PARM | ID_M_PG_AG},
  {"M_lnPG_AG", (PVOID) &M_lnPG_AG, ID_PARM | ID_M_lnPG_AG},
  {"M_PM_AG", (PVOID) &M_PM_AG, ID_PARM | ID_M_PM_AG},
  {"M_lnPM_AG", (PVOID) &M_lnPM_AG, ID_PARM | ID_M_lnPM_AG},
  {"M_PR_AG", (PVOID) &M_PR_AG, ID_PARM | ID_M_PR_AG},
  {"M_lnPR_AG", (PVOID) &M_lnPR_AG, ID_PARM | ID_M_lnPR_AG},
  {"M_PS_AG", (PVOID) &M_PS_AG, ID_PARM | ID_M_PS_AG},
  {"M_lnPS_AG", (PVOID) &M_lnPS_AG, ID_PARM | ID_M_lnPS_AG},
  {"M_kPAPS", (PVOID) &M_kPAPS, ID_PARM | ID_M_kPAPS},
  {"M_lnkPAPS", (PVOID) &M_lnkPAPS, ID_PARM | ID_M_lnkPAPS},
  {"M_kPAPS_syn", (PVOID) &M_kPAPS_syn, ID_PARM | ID_M_kPAPS_syn},
  {"M_lnkPAPS_syn", (PVOID) &M_lnkPAPS_syn, ID_PARM | ID_M_lnkPAPS_syn},
  {"M_kGA", (PVOID) &M_kGA, ID_PARM | ID_M_kGA},
  {"M_lnkGA", (PVOID) &M_lnkGA, ID_PARM | ID_M_lnkGA},
  {"M_kGA_syn", (PVOID) &M_kGA_syn, ID_PARM | ID_M_kGA_syn},
  {"M_lnkGA_syn", (PVOID) &M_lnkGA_syn, ID_PARM | ID_M_lnkGA_syn},
  {"M_CYP_Km", (PVOID) &M_CYP_Km, ID_PARM | ID_M_CYP_Km},
  {"M_lnCYP_Km", (PVOID) &M_lnCYP_Km, ID_PARM | ID_M_lnCYP_Km},
  {"M_CYP_VmaxC", (PVOID) &M_CYP_VmaxC, ID_PARM | ID_M_CYP_VmaxC},
  {"M_lnCYP_VmaxC", (PVOID) &M_lnCYP_VmaxC, ID_PARM | ID_M_lnCYP_VmaxC},
  {"M_UGT_Km", (PVOID) &M_UGT_Km, ID_PARM | ID_M_UGT_Km},
  {"M_lnUGT_Km", (PVOID) &M_lnUGT_Km, ID_PARM | ID_M_lnUGT_Km},
  {"M_UGT_VmaxC", (PVOID) &M_UGT_VmaxC, ID_PARM | ID_M_UGT_VmaxC},
  {"M_lnUGT_VmaxC", (PVOID) &M_lnUGT_VmaxC, ID_PARM | ID_M_lnUGT_VmaxC},
  {"M_UGT_Km_GA", (PVOID) &M_UGT_Km_GA, ID_PARM | ID_M_UGT_Km_GA},
  {"M_lnUGT_Km_GA", (PVOID) &M_lnUGT_Km_GA, ID_PARM | ID_M_lnUGT_Km_GA},
  {"M_UGT_Ki", (PVOID) &M_UGT_Ki, ID_PARM | ID_M_UGT_Ki},
  {"M_lnUGT_Ki", (PVOID) &M_lnUGT_Ki, ID_PARM | ID_M_lnUGT_Ki},
  {"M_Vmax_AG", (PVOID) &M_Vmax_AG, ID_PARM | ID_M_Vmax_AG},
  {"M_lnVmax_AG", (PVOID) &M_lnVmax_AG, ID_PARM | ID_M_lnVmax_AG},
  {"M_Km_AG", (PVOID) &M_Km_AG, ID_PARM | ID_M_Km_AG},
  {"M_lnKm_AG", (PVOID) &M_lnKm_AG, ID_PARM | ID_M_lnKm_AG},
  {"M_SULT_Km_apap", (PVOID) &M_SULT_Km_apap, ID_PARM | ID_M_SULT_Km_apap},
  {"M_lnSULT_Km_apap", (PVOID) &M_lnSULT_Km_apap, ID_PARM | ID_M_lnSULT_Km_apap},
  {"M_SULT_Km_paps", (PVOID) &M_SULT_Km_paps, ID_PARM | ID_M_SULT_Km_paps},
  {"M_lnSULT_Km_paps", (PVOID) &M_lnSULT_Km_paps, ID_PARM | ID_M_lnSULT_Km_paps},
  {"M_SULT_Ki", (PVOID) &M_SULT_Ki, ID_PARM | ID_M_SULT_Ki},
  {"M_lnSULT_Ki", (PVOID) &M_lnSULT_Ki, ID_PARM | ID_M_lnSULT_Ki},
  {"M_SULT_VmaxC", (PVOID) &M_SULT_VmaxC, ID_PARM | ID_M_SULT_VmaxC},
  {"M_lnSULT_VmaxC", (PVOID) &M_lnSULT_VmaxC, ID_PARM | ID_M_lnSULT_VmaxC},
  {"M_Vmax_AS", (PVOID) &M_Vmax_AS, ID_PARM | ID_M_Vmax_AS},
  {"M_lnVmax_AS", (PVOID) &M_lnVmax_AS, ID_PARM | ID_M_lnVmax_AS},
  {"M_Km_AS", (PVOID) &M_Km_AS, ID_PARM | ID_M_Km_AS},
  {"M_lnKm_AS", (PVOID) &M_lnKm_AS, ID_PARM | ID_M_lnKm_AS},
  {"Var_BW", (PVOID) &Var_BW, ID_PARM | ID_Var_BW},
  {"Var_lnBW", (PVOID) &Var_lnBW, ID_PARM | ID_Var_lnBW},
  {"Var_fa", (PVOID) &Var_fa, ID_PARM | ID_Var_fa},
  {"Var_lnfa", (PVOID) &Var_lnfa, ID_PARM | ID_Var_lnfa},
  {"Var_kSG_Vm", (PVOID) &Var_kSG_Vm, ID_PARM | ID_Var_kSG_Vm},
  {"Var_lnkSG_Vm", (PVOID) &Var_lnkSG_Vm, ID_PARM | ID_Var_lnkSG_Vm},
  {"Var_kSG_Km", (PVOID) &Var_kSG_Km, ID_PARM | ID_Var_kSG_Km},
  {"Var_lnkSG_Km", (PVOID) &Var_lnkSG_Km, ID_PARM | ID_Var_lnkSG_Km},
  {"Var_Tg", (PVOID) &Var_Tg, ID_PARM | ID_Var_Tg},
  {"Var_lnTg", (PVOID) &Var_lnTg, ID_PARM | ID_Var_lnTg},
  {"Var_Tp", (PVOID) &Var_Tp, ID_PARM | ID_Var_Tp},
  {"Var_lnTp", (PVOID) &Var_lnTp, ID_PARM | ID_Var_lnTp},
  {"Var_CLC_APAP", (PVOID) &Var_CLC_APAP, ID_PARM | ID_Var_CLC_APAP},
  {"Var_lnCLC_APAP", (PVOID) &Var_lnCLC_APAP, ID_PARM | ID_Var_lnCLC_APAP},
  {"Var_CLC_AS", (PVOID) &Var_CLC_AS, ID_PARM | ID_Var_CLC_AS},
  {"Var_lnCLC_AS", (PVOID) &Var_lnCLC_AS, ID_PARM | ID_Var_lnCLC_AS},
  {"Var_CLC_AG", (PVOID) &Var_CLC_AG, ID_PARM | ID_Var_CLC_AG},
  {"Var_lnCLC_AG", (PVOID) &Var_lnCLC_AG, ID_PARM | ID_Var_lnCLC_AG},
  {"Var_BP_APAP", (PVOID) &Var_BP_APAP, ID_PARM | ID_Var_BP_APAP},
  {"Var_lnBP_APAP", (PVOID) &Var_lnBP_APAP, ID_PARM | ID_Var_lnBP_APAP},
  {"Var_PF_APAP", (PVOID) &Var_PF_APAP, ID_PARM | ID_Var_PF_APAP},
  {"Var_lnPF_APAP", (PVOID) &Var_lnPF_APAP, ID_PARM | ID_Var_lnPF_APAP},
  {"Var_PG_APAP", (PVOID) &Var_PG_APAP, ID_PARM | ID_Var_PG_APAP},
  {"Var_lnPG_APAP", (PVOID) &Var_lnPG_APAP, ID_PARM | ID_Var_lnPG_APAP},
  {"Var_PK_APAP", (PVOID) &Var_PK_APAP, ID_PARM | ID_Var_PK_APAP},
  {"Var_lnPK_APAP", (PVOID) &Var_lnPK_APAP, ID_PARM | ID_Var_lnPK_APAP},
  {"Var_PL_APAP", (PVOID) &Var_PL_APAP, ID_PARM | ID_Var_PL_APAP},
  {"Var_lnPL_APAP", (PVOID) &Var_lnPL_APAP, ID_PARM | ID_Var_lnPL_APAP},
  {"Var_PM_APAP", (PVOID) &Var_PM_APAP, ID_PARM | ID_Var_PM_APAP},
  {"Var_lnPM_APAP", (PVOID) &Var_lnPM_APAP, ID_PARM | ID_Var_lnPM_APAP},
  {"Var_PR_APAP", (PVOID) &Var_PR_APAP, ID_PARM | ID_Var_PR_APAP},
  {"Var_lnPR_APAP", (PVOID) &Var_lnPR_APAP, ID_PARM | ID_Var_lnPR_APAP},
  {"Var_PS_APAP", (PVOID) &Var_PS_APAP, ID_PARM | ID_Var_PS_APAP},
  {"Var_lnPS_APAP", (PVOID) &Var_lnPS_APAP, ID_PARM | ID_Var_lnPS_APAP},
  {"Var_PK_AS", (PVOID) &Var_PK_AS, ID_PARM | ID_Var_PK_AS},
  {"Var_lnPK_AS", (PVOID) &Var_lnPK_AS, ID_PARM | ID_Var_lnPK_AS},
  {"Var_PF_AS", (PVOID) &Var_PF_AS, ID_PARM | ID_Var_PF_AS},
  {"Var_lnPF_AS", (PVOID) &Var_lnPF_AS, ID_PARM | ID_Var_lnPF_AS},
  {"Var_PL_AS", (PVOID) &Var_PL_AS, ID_PARM | ID_Var_PL_AS},
  {"Var_lnPL_AS", (PVOID) &Var_lnPL_AS, ID_PARM | ID_Var_lnPL_AS},
  {"Var_PG_AS", (PVOID) &Var_PG_AS, ID_PARM | ID_Var_PG_AS},
  {"Var_lnPG_AS", (PVOID) &Var_lnPG_AS, ID_PARM | ID_Var_lnPG_AS},
  {"Var_PM_AS", (PVOID) &Var_PM_AS, ID_PARM | ID_Var_PM_AS},
  {"Var_lnPM_AS", (PVOID) &Var_lnPM_AS, ID_PARM | ID_Var_lnPM_AS},
  {"Var_PR_AS", (PVOID) &Var_PR_AS, ID_PARM | ID_Var_PR_AS},
  {"Var_lnPR_AS", (PVOID) &Var_lnPR_AS, ID_PARM | ID_Var_lnPR_AS},
  {"Var_PS_AS", (PVOID) &Var_PS_AS, ID_PARM | ID_Var_PS_AS},
  {"Var_lnPS_AS", (PVOID) &Var_lnPS_AS, ID_PARM | ID_Var_lnPS_AS},
  {"Var_PK_AG", (PVOID) &Var_PK_AG, ID_PARM | ID_Var_PK_AG},
  {"Var_lnPK_AG", (PVOID) &Var_lnPK_AG, ID_PARM | ID_Var_lnPK_AG},
  {"Var_PF_AG", (PVOID) &Var_PF_AG, ID_PARM | ID_Var_PF_AG},
  {"Var_lnPF_AG", (PVOID) &Var_lnPF_AG, ID_PARM | ID_Var_lnPF_AG},
  {"Var_PL_AG", (PVOID) &Var_PL_AG, ID_PARM | ID_Var_PL_AG},
  {"Var_lnPL_AG", (PVOID) &Var_lnPL_AG, ID_PARM | ID_Var_lnPL_AG},
  {"Var_PG_AG", (PVOID) &Var_PG_AG, ID_PARM | ID_Var_PG_AG},
  {"Var_lnPG_AG", (PVOID) &Var_lnPG_AG, ID_PARM | ID_Var_lnPG_AG},
  {"Var_PM_AG", (PVOID) &Var_PM_AG, ID_PARM | ID_Var_PM_AG},
  {"Var_lnPM_AG", (PVOID) &Var_lnPM_AG, ID_PARM | ID_Var_lnPM_AG},
  {"Var_PR_AG", (PVOID) &Var_PR_AG, ID_PARM | ID_Var_PR_AG},
  {"Var_lnPR_AG", (PVOID) &Var_lnPR_AG, ID_PARM | ID_Var_lnPR_AG},
  {"Var_PS_AG", (PVOID) &Var_PS_AG, ID_PARM | ID_Var_PS_AG},
  {"Var_lnPS_AG", (PVOID) &Var_lnPS_AG, ID_PARM | ID_Var_lnPS_AG},
  {"Var_kPAPS", (PVOID) &Var_kPAPS, ID_PARM | ID_Var_kPAPS},
  {"Var_lnkPAPS", (PVOID) &Var_lnkPAPS, ID_PARM | ID_Var_lnkPAPS},
  {"Var_kPAPS_syn", (PVOID) &Var_kPAPS_syn, ID_PARM | ID_Var_kPAPS_syn},
  {"Var_lnkPAPS_syn", (PVOID) &Var_lnkPAPS_syn, ID_PARM | ID_Var_lnkPAPS_syn},
  {"Var_kGA", (PVOID) &Var_kGA, ID_PARM | ID_Var_kGA},
  {"Var_lnkGA", (PVOID) &Var_lnkGA, ID_PARM | ID_Var_lnkGA},
  {"Var_kGA_syn", (PVOID) &Var_kGA_syn, ID_PARM | ID_Var_kGA_syn},
  {"Var_lnkGA_syn", (PVOID) &Var_lnkGA_syn, ID_PARM | ID_Var_lnkGA_syn},
  {"Var_CYP_Km", (PVOID) &Var_CYP_Km, ID_PARM | ID_Var_CYP_Km},
  {"Var_lnCYP_Km", (PVOID) &Var_lnCYP_Km, ID_PARM | ID_Var_lnCYP_Km},
  {"Var_CYP_VmaxC", (PVOID) &Var_CYP_VmaxC, ID_PARM | ID_Var_CYP_VmaxC},
  {"Var_lnCYP_VmaxC", (PVOID) &Var_lnCYP_VmaxC, ID_PARM | ID_Var_lnCYP_VmaxC},
  {"Var_UGT_Km", (PVOID) &Var_UGT_Km, ID_PARM | ID_Var_UGT_Km},
  {"Var_lnUGT_Km", (PVOID) &Var_lnUGT_Km, ID_PARM | ID_Var_lnUGT_Km},
  {"Var_UGT_VmaxC", (PVOID) &Var_UGT_VmaxC, ID_PARM | ID_Var_UGT_VmaxC},
  {"Var_lnUGT_VmaxC", (PVOID) &Var_lnUGT_VmaxC, ID_PARM | ID_Var_lnUGT_VmaxC},
  {"Var_UGT_Km_GA", (PVOID) &Var_UGT_Km_GA, ID_PARM | ID_Var_UGT_Km_GA},
  {"Var_lnUGT_Km_GA", (PVOID) &Var_lnUGT_Km_GA, ID_PARM | ID_Var_lnUGT_Km_GA},
  {"Var_UGT_Ki", (PVOID) &Var_UGT_Ki, ID_PARM | ID_Var_UGT_Ki},
  {"Var_lnUGT_Ki", (PVOID) &Var_lnUGT_Ki, ID_PARM | ID_Var_lnUGT_Ki},
  {"Var_Vmax_AG", (PVOID) &Var_Vmax_AG, ID_PARM | ID_Var_Vmax_AG},
  {"Var_lnVmax_AG", (PVOID) &Var_lnVmax_AG, ID_PARM | ID_Var_lnVmax_AG},
  {"Var_Km_AG", (PVOID) &Var_Km_AG, ID_PARM | ID_Var_Km_AG},
  {"Var_lnKm_AG", (PVOID) &Var_lnKm_AG, ID_PARM | ID_Var_lnKm_AG},
  {"Var_SULT_KVar_apap", (PVOID) &Var_SULT_KVar_apap, ID_PARM | ID_Var_SULT_KVar_apap},
  {"Var_lnSULT_Km_apap", (PVOID) &Var_lnSULT_Km_apap, ID_PARM | ID_Var_lnSULT_Km_apap},
  {"Var_SULT_KVar_paps", (PVOID) &Var_SULT_KVar_paps, ID_PARM | ID_Var_SULT_KVar_paps},
  {"Var_lnSULT_Km_paps", (PVOID) &Var_lnSULT_Km_paps, ID_PARM | ID_Var_lnSULT_Km_paps},
  {"Var_SULT_Ki", (PVOID) &Var_SULT_Ki, ID_PARM | ID_Var_SULT_Ki},
  {"Var_lnSULT_Ki", (PVOID) &Var_lnSULT_Ki, ID_PARM | ID_Var_lnSULT_Ki},
  {"Var_SULT_VmaxC", (PVOID) &Var_SULT_VmaxC, ID_PARM | ID_Var_SULT_VmaxC},
  {"Var_lnSULT_VmaxC", (PVOID) &Var_lnSULT_VmaxC, ID_PARM | ID_Var_lnSULT_VmaxC},
  {"Var_Vmax_AS", (PVOID) &Var_Vmax_AS, ID_PARM | ID_Var_Vmax_AS},
  {"Var_lnVmax_AS", (PVOID) &Var_lnVmax_AS, ID_PARM | ID_Var_lnVmax_AS},
  {"Var_Km_AS", (PVOID) &Var_Km_AS, ID_PARM | ID_Var_Km_AS},
  {"Var_lnKm_AS", (PVOID) &Var_lnKm_AS, ID_PARM | ID_Var_lnKm_AS},
  {"Verr_CPL_APAP_mcmolL", (PVOID) &Verr_CPL_APAP_mcmolL, ID_PARM | ID_Verr_CPL_APAP_mcmolL},
  {"Verr_CPL_APAP_mcgL", (PVOID) &Verr_CPL_APAP_mcgL, ID_PARM | ID_Verr_CPL_APAP_mcgL},
  {"Verr_CPL_AG_mcmolL", (PVOID) &Verr_CPL_AG_mcmolL, ID_PARM | ID_Verr_CPL_AG_mcmolL},
  {"Verr_CPL_AG_mcgL", (PVOID) &Verr_CPL_AG_mcgL, ID_PARM | ID_Verr_CPL_AG_mcgL},
  {"Verr_CPL_AS_mcmolL", (PVOID) &Verr_CPL_AS_mcmolL, ID_PARM | ID_Verr_CPL_AS_mcmolL},
  {"Verr_CPL_AS_mcgL", (PVOID) &Verr_CPL_AS_mcgL, ID_PARM | ID_Verr_CPL_AS_mcgL},
  {"Verr_CU_APAP_mcg", (PVOID) &Verr_CU_APAP_mcg, ID_PARM | ID_Verr_CU_APAP_mcg},
  {"Verr_CU_AG_mcg", (PVOID) &Verr_CU_AG_mcg, ID_PARM | ID_Verr_CU_AG_mcg},
  {"Verr_CU_AS_mcg", (PVOID) &Verr_CU_AS_mcg, ID_PARM | ID_Verr_CU_AS_mcg},
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

  MW_APAP = 151.17;
  MW_AG = 327.28;
  MW_AS = 231.22;
  BW = 0;
  lnBW = 4.0;
  QCC = 16.2;
  VFC = 0.214;
  VKC = 0.0044;
  VGC = 0.0144;
  VLC = 0.0257;
  VMC = 0.4;
  VBLAC = 0.0243;
  VBLVC = 0.0557;
  VSC = 0.185;
  VRC = 0.0765;
  QFC = 0.052;
  QKC = 0.175;
  QGC = 0.181;
  QLBC = 0.046;
  QMC = 0.191;
  QSC = 0.14;
  QRC = 0.215;
  kSG_Vm = 0;
  lnkSG_Vm = 7.75;
  kSG_Km = 0;
  lnkSG_Km = 7.47;
  Tg = 0;
  lnTg = -1.0;
  Tp = 0;
  lnTp = -3.0;
  CLC_APAP = 0;
  lnCLC_APAP = -2.0;
  CLC_AS = 0;
  lnCLC_AS = -2.0;
  CLC_AG = 0;
  lnCLC_AG = -2.0;
  alpha_APAP = 1.;
  alpha_AS = 1.;
  alpha_AG = 1.;
  BP_APAP = 0.9;
  lnBP_APAP = log(0.9);
  PF_APAP = 0.447;
  lnPF_APAP = log(0.447);
  PG_APAP = 0.907;
  lnPG_APAP = log(0.907);
  PK_APAP = 0.711;
  lnPK_APAP = log(0.711);
  PL_APAP = 0.687;
  lnPL_APAP = log(0.687);
  PM_APAP = 0.687;
  lnPM_APAP = log(0.687);
  PR_APAP = 0.676;
  lnPR_APAP = log(0.676);
  PS_APAP = 0.606;
  lnPS_APAP = log(0.606);
  PF_AS = 0.088;
  lnPF_AS = log(0.088);
  PG_AS = 0.297;
  lnPG_AS = log(0.297);
  PK_AS = 0.261;
  lnPK_AS = log(0.261);
  PL_AS = 0.203;
  lnPL_AS = log(0.203);
  PM_AS = 0.199;
  lnPM_AS = log(0.199);
  PR_AS = 0.207;
  lnPR_AS = log(0.207);
  PS_AS = 0.254;
  lnPS_AS = log(0.254);
  PF_AG = 0.128;
  lnPF_AG = log(0.128);
  PG_AG = 0.436;
  lnPG_AG = log(0.436);
  PK_AG = 0.392;
  lnPK_AG = log(0.392);
  PL_AG = 0.321;
  lnPL_AG = log(0.321);
  PM_AG = 0.336;
  lnPM_AG = log(0.366);
  PR_AG = 0.364;
  lnPR_AG = log(0.364);
  PS_AG = 0.351;
  lnPS_AG = log(0.351);
  kPAPS = 0.018;
  lnkPAPS = log(0.018);
  kPAPS_syn = 0;
  lnkPAPS_syn = -30;
  kGA = 0.008;
  lnkGA = log(0.008);
  kGA_syn = 0;
  lnkGA_syn = -30;
  CYP_Km = 0;
  lnCYP_Km = 7.6;
  CYP_VmaxC = 0;
  lnCYP_VmaxC = 8.4;
  UGT_Km = 0;
  lnUGT_Km = 9;
  UGT_Ki = 0;
  lnUGT_Ki = 23;
  UGT_VmaxC = 0;
  lnUGT_VmaxC = 7.3;
  UGT_Km_GA = 0;
  lnUGT_Km_GA = 2.3;
  Vmax_AG = 0;
  lnVmax_AG = 30;
  Km_AG = 0;
  lnKm_AG = 9.9;
  SULT_Km_apap = 0;
  lnSULT_Km_apap = 3.0;
  SULT_Km_paps = 0;
  lnSULT_Km_paps = 3.0;
  SULT_Ki = 0;
  lnSULT_Ki = 20;
  SULT_VmaxC = 0;
  lnSULT_VmaxC = 10;
  Vmax_AS = 0;
  lnVmax_AS = 20;
  Km_AS = 0;
  lnKm_AS = 10;
  mgkg_flag = 1.;
  OralDose_APAP_mgkg = 1;
  OralDose_APAP_mg = 1;
  OralDur_APAP = 0.001;
  ODose_APAP_mg = 0;
  fa = 0;
  ODose_APAP = 0;
  true_dose = 0;
  IVDose_APAP_mgkg = 0.;
  lnIVDose_APAP_mgkg = 0;
  IVDose_APAP_mg = 0.;
  lnIVDose_APAP_mg = 0;
  IVDur_APAP = 0.001;
  IVD_APAP_mg = 0;
  IVDR_APAP = 0;
  CYP_Vmax = 0;
  UGT_Vmax = 0;
  SULT_Vmax = 0;
  VTC = 0;
  VF = 0;
  VK = 0;
  VG = 0;
  VM = 0;
  VL = 0;
  VBLA = 0;
  VBLV = 0;
  VR = 0;
  VS = 0;
  QTC = 0;
  QC = 0;
  QF = 0;
  QK = 0;
  QG = 0;
  QM = 0;
  QLB = 0;
  QR = 0;
  QS = 0;
  QL = 0;
  CLR_APAP = 0;
  CLR_AS = 0;
  CLR_AG = 0;
  M_OralDose_APAP = 0;
  Var_OralDose_APAP = 0;
  M_IVDose_APAP = 0;
  Var_IVDose_APAP = 0;
  M_lnOralDose_APAP = 0;
  Var_lnOralDose_APAP = 0;
  M_lnIVDose_APAP = 0;
  M_lnVar_IVDose_APAP = 0;
  M_BW = 0;
  M_lnBW = 0;
  M_fa = 0;
  M_lnfa = 0;
  M_kSG_Vm = 0;
  M_lnkSG_Vm = 0;
  M_kSG_Km = 0;
  M_lnkSG_Km = 0;
  M_Tg = 0;
  M_lnTg = 0;
  M_Tp = 0;
  M_lnTp = 0;
  M_CLC_APAP = 0;
  M_lnCLC_APAP = 0;
  M_CLC_AS = 0;
  M_lnCLC_AS = 0;
  M_CLC_AG = 0;
  M_lnCLC_AG = 0;
  M_BP_APAP = 0;
  M_lnBP_APAP = 0;
  M_PF_APAP = 0;
  M_lnPF_APAP = 0;
  M_PG_APAP = 0;
  M_lnPG_APAP = 0;
  M_PK_APAP = 0;
  M_lnPK_APAP = 0;
  M_PL_APAP = 0;
  M_lnPL_APAP = 0;
  M_PM_APAP = 0;
  M_lnPM_APAP = 0;
  M_PR_APAP = 0;
  M_lnPR_APAP = 0;
  M_PS_APAP = 0;
  M_lnPS_APAP = 0;
  M_PK_AS = 0;
  M_lnPK_AS = 0;
  M_PF_AS = 0;
  M_lnPF_AS = 0;
  M_PL_AS = 0;
  M_lnPL_AS = 0;
  M_PG_AS = 0;
  M_lnPG_AS = 0;
  M_PM_AS = 0;
  M_lnPM_AS = 0;
  M_PR_AS = 0;
  M_lnPR_AS = 0;
  M_PS_AS = 0;
  M_lnPS_AS = 0;
  M_PK_AG = 0;
  M_lnPK_AG = 0;
  M_PF_AG = 0;
  M_lnPF_AG = 0;
  M_PL_AG = 0;
  M_lnPL_AG = 0;
  M_PG_AG = 0;
  M_lnPG_AG = 0;
  M_PM_AG = 0;
  M_lnPM_AG = 0;
  M_PR_AG = 0;
  M_lnPR_AG = 0;
  M_PS_AG = 0;
  M_lnPS_AG = 0;
  M_kPAPS = 0;
  M_lnkPAPS = 0;
  M_kPAPS_syn = 0;
  M_lnkPAPS_syn = 0;
  M_kGA = 0;
  M_lnkGA = 0;
  M_kGA_syn = 0;
  M_lnkGA_syn = 0;
  M_CYP_Km = 0;
  M_lnCYP_Km = 0;
  M_CYP_VmaxC = 0;
  M_lnCYP_VmaxC = 0;
  M_UGT_Km = 0;
  M_lnUGT_Km = 0;
  M_UGT_VmaxC = 0;
  M_lnUGT_VmaxC = 0;
  M_UGT_Km_GA = 0;
  M_lnUGT_Km_GA = 0;
  M_UGT_Ki = 0;
  M_lnUGT_Ki = 0;
  M_Vmax_AG = 0;
  M_lnVmax_AG = 0;
  M_Km_AG = 0;
  M_lnKm_AG = 0;
  M_SULT_Km_apap = 0;
  M_lnSULT_Km_apap = 0;
  M_SULT_Km_paps = 0;
  M_lnSULT_Km_paps = 0;
  M_SULT_Ki = 0;
  M_lnSULT_Ki = 0;
  M_SULT_VmaxC = 0;
  M_lnSULT_VmaxC = 0;
  M_Vmax_AS = 0;
  M_lnVmax_AS = 0;
  M_Km_AS = 0;
  M_lnKm_AS = 0;
  Var_BW = 0;
  Var_lnBW = 0;
  Var_fa = 0;
  Var_lnfa = 0;
  Var_kSG_Vm = 0;
  Var_lnkSG_Vm = 0;
  Var_kSG_Km = 0;
  Var_lnkSG_Km = 0;
  Var_Tg = 0;
  Var_lnTg = 0;
  Var_Tp = 0;
  Var_lnTp = 0;
  Var_CLC_APAP = 0;
  Var_lnCLC_APAP = 0;
  Var_CLC_AS = 0;
  Var_lnCLC_AS = 0;
  Var_CLC_AG = 0;
  Var_lnCLC_AG = 0;
  Var_BP_APAP = 0;
  Var_lnBP_APAP = 0;
  Var_PF_APAP = 0;
  Var_lnPF_APAP = 0;
  Var_PG_APAP = 0;
  Var_lnPG_APAP = 0;
  Var_PK_APAP = 0;
  Var_lnPK_APAP = 0;
  Var_PL_APAP = 0;
  Var_lnPL_APAP = 0;
  Var_PM_APAP = 0;
  Var_lnPM_APAP = 0;
  Var_PR_APAP = 0;
  Var_lnPR_APAP = 0;
  Var_PS_APAP = 0;
  Var_lnPS_APAP = 0;
  Var_PK_AS = 0;
  Var_lnPK_AS = 0;
  Var_PF_AS = 0;
  Var_lnPF_AS = 0;
  Var_PL_AS = 0;
  Var_lnPL_AS = 0;
  Var_PG_AS = 0;
  Var_lnPG_AS = 0;
  Var_PM_AS = 0;
  Var_lnPM_AS = 0;
  Var_PR_AS = 0;
  Var_lnPR_AS = 0;
  Var_PS_AS = 0;
  Var_lnPS_AS = 0;
  Var_PK_AG = 0;
  Var_lnPK_AG = 0;
  Var_PF_AG = 0;
  Var_lnPF_AG = 0;
  Var_PL_AG = 0;
  Var_lnPL_AG = 0;
  Var_PG_AG = 0;
  Var_lnPG_AG = 0;
  Var_PM_AG = 0;
  Var_lnPM_AG = 0;
  Var_PR_AG = 0;
  Var_lnPR_AG = 0;
  Var_PS_AG = 0;
  Var_lnPS_AG = 0;
  Var_kPAPS = 0;
  Var_lnkPAPS = 0;
  Var_kPAPS_syn = 0;
  Var_lnkPAPS_syn = 0;
  Var_kGA = 0;
  Var_lnkGA = 0;
  Var_kGA_syn = 0;
  Var_lnkGA_syn = 0;
  Var_CYP_Km = 0;
  Var_lnCYP_Km = 0;
  Var_CYP_VmaxC = 0;
  Var_lnCYP_VmaxC = 0;
  Var_UGT_Km = 0;
  Var_lnUGT_Km = 0;
  Var_UGT_VmaxC = 0;
  Var_lnUGT_VmaxC = 0;
  Var_UGT_Km_GA = 0;
  Var_lnUGT_Km_GA = 0;
  Var_UGT_Ki = 0;
  Var_lnUGT_Ki = 0;
  Var_Vmax_AG = 0;
  Var_lnVmax_AG = 0;
  Var_Km_AG = 0;
  Var_lnKm_AG = 0;
  Var_SULT_KVar_apap = 0;
  Var_lnSULT_Km_apap = 0;
  Var_SULT_KVar_paps = 0;
  Var_lnSULT_Km_paps = 0;
  Var_SULT_Ki = 0;
  Var_lnSULT_Ki = 0;
  Var_SULT_VmaxC = 0;
  Var_lnSULT_VmaxC = 0;
  Var_Vmax_AS = 0;
  Var_lnVmax_AS = 0;
  Var_Km_AS = 0;
  Var_lnKm_AS = 0;
  Verr_CPL_APAP_mcmolL = 0;
  Verr_CPL_APAP_mcgL = 0;
  Verr_CPL_AG_mcmolL = 0;
  Verr_CPL_AG_mcgL = 0;
  Verr_CPL_AS_mcmolL = 0;
  Verr_CPL_AS_mcgL = 0;
  Verr_CU_APAP_mcg = 0;
  Verr_CU_AG_mcg = 0;
  Verr_CU_AS_mcg = 0;
  vrgModelVars[ID_CL_APAP_to_NAPQI_CYP] = 0.0;
  vrgModelVars[ID_CL_APAP_to_AS_SULT] = 0.0;
  vrgModelVars[ID_CL_APAP_to_AG_UGT] = 0.0;
  vrgModelVars[ID_AST_Oral_APAP] = 0.0;
  vrgModelVars[ID_AST_APAP] = 0.0;
  vrgModelVars[ID_AST_to_Gut_APAP] = 0.0;
  vrgModelVars[ID_AF_APAP] = 0.0;
  vrgModelVars[ID_AR_APAP] = 0.0;
  vrgModelVars[ID_AS_APAP] = 0.0;
  vrgModelVars[ID_AF_AS] = 0.0;
  vrgModelVars[ID_AR_AS] = 0.0;
  vrgModelVars[ID_AS_AS] = 0.0;
  vrgModelVars[ID_AF_AG] = 0.0;
  vrgModelVars[ID_AR_AG] = 0.0;
  vrgModelVars[ID_AS_AG] = 0.0;
  vrgModelVars[ID_AKE_APAP] = 0.0;
  vrgModelVars[ID_AKE_AS] = 0.0;
  vrgModelVars[ID_AKE_AG] = 0.0;
  vrgModelVars[ID_AK_APAP] = 0.0;
  vrgModelVars[ID_AK_AS] = 0.0;
  vrgModelVars[ID_AK_AG] = 0.0;
  vrgModelVars[ID_AL_APAP] = 0.0;
  vrgModelVars[ID_AL_AS] = 0.0;
  vrgModelVars[ID_AL_AG] = 0.0;
  vrgModelVars[ID_AL_PAPS] = 0.0;
  vrgModelVars[ID_AL_GA] = 0.0;
  vrgModelVars[ID_CH_AG] = 0.0;
  vrgModelVars[ID_CH_AG_to_CL_AG] = 0.0;
  vrgModelVars[ID_CH_AS] = 0.0;
  vrgModelVars[ID_CH_AS_to_CL_AS] = 0.0;
  vrgModelVars[ID_AM_APAP] = 0.0;
  vrgModelVars[ID_AM_AS] = 0.0;
  vrgModelVars[ID_AM_AG] = 0.0;
  vrgModelVars[ID_ABLA_APAP] = 0.0;
  vrgModelVars[ID_ABLA_AS] = 0.0;
  vrgModelVars[ID_ABLA_AG] = 0.0;
  vrgModelVars[ID_ABL_IV_APAP] = 0.0;
  vrgModelVars[ID_ABLV_APAP] = 0.0;
  vrgModelVars[ID_ABLV_AS] = 0.0;
  vrgModelVars[ID_ABLV_AG] = 0.0;
  vrgModelVars[ID_AU_APAP] = 0.0;
  vrgModelVars[ID_AU_AS] = 0.0;
  vrgModelVars[ID_AU_AG] = 0.0;
  vrgModelVars[ID_pct_abs] = 0.0;
  vrgInputs[ID_OralExp_APAP].iType = IFN_CONSTANT;
  vrgInputs[ID_OralExp_APAP].dTStartPeriod = 0;
  vrgInputs[ID_OralExp_APAP].bOn = FALSE;
  vrgInputs[ID_OralExp_APAP].dMag = 0.000000;
  vrgInputs[ID_OralExp_APAP].dT0 = 0.000000;
  vrgInputs[ID_OralExp_APAP].dTexp = 0.000000;
  vrgInputs[ID_OralExp_APAP].dDecay = 0.000000;
  vrgInputs[ID_OralExp_APAP].dTper = 0.000000;
  vrgInputs[ID_OralExp_APAP].hMag = 0;
  vrgInputs[ID_OralExp_APAP].hT0 = 0;
  vrgInputs[ID_OralExp_APAP].hTexp = 0;
  vrgInputs[ID_OralExp_APAP].hDecay = 0;
  vrgInputs[ID_OralExp_APAP].hTper = 0;
  vrgInputs[ID_OralExp_APAP].dVal = 0.0;
  vrgInputs[ID_OralExp_APAP].nDoses = 0;
  vrgInputs[ID_IVExp_APAP].iType = IFN_CONSTANT;
  vrgInputs[ID_IVExp_APAP].dTStartPeriod = 0;
  vrgInputs[ID_IVExp_APAP].bOn = FALSE;
  vrgInputs[ID_IVExp_APAP].dMag = 0.000000;
  vrgInputs[ID_IVExp_APAP].dT0 = 0.000000;
  vrgInputs[ID_IVExp_APAP].dTexp = 0.000000;
  vrgInputs[ID_IVExp_APAP].dDecay = 0.000000;
  vrgInputs[ID_IVExp_APAP].dTper = 0.000000;
  vrgInputs[ID_IVExp_APAP].hMag = 0;
  vrgInputs[ID_IVExp_APAP].hT0 = 0;
  vrgInputs[ID_IVExp_APAP].hTexp = 0;
  vrgInputs[ID_IVExp_APAP].hDecay = 0;
  vrgInputs[ID_IVExp_APAP].hTper = 0;
  vrgInputs[ID_IVExp_APAP].dVal = 0.0;
  vrgInputs[ID_IVExp_APAP].nDoses = 0;
  vrgModelVars[ID_CF_APAP] = 0.0;
  vrgModelVars[ID_CK_APAP] = 0.0;
  vrgModelVars[ID_CL_APAP] = 0.0;
  vrgModelVars[ID_CR_APAP] = 0.0;
  vrgModelVars[ID_CS_APAP] = 0.0;
  vrgModelVars[ID_CF_AS] = 0.0;
  vrgModelVars[ID_CK_AS] = 0.0;
  vrgModelVars[ID_CL_AS] = 0.0;
  vrgModelVars[ID_CR_AS] = 0.0;
  vrgModelVars[ID_CS_AS] = 0.0;
  vrgModelVars[ID_CF_AG] = 0.0;
  vrgModelVars[ID_CK_AG] = 0.0;
  vrgModelVars[ID_CL_AG] = 0.0;
  vrgModelVars[ID_CR_AG] = 0.0;
  vrgModelVars[ID_CS_AG] = 0.0;
  vrgModelVars[ID_CA_APAP] = 0.0;
  vrgModelVars[ID_CV_APAP] = 0.0;
  vrgModelVars[ID_CPL_APAP] = 0.0;
  vrgModelVars[ID_CA_AS] = 0.0;
  vrgModelVars[ID_CV_AS] = 0.0;
  vrgModelVars[ID_CPL_AS] = 0.0;
  vrgModelVars[ID_CA_AG] = 0.0;
  vrgModelVars[ID_CV_AG] = 0.0;
  vrgModelVars[ID_CPL_AG] = 0.0;
  vrgModelVars[ID_CPL_APAP_mcmolL] = 0.0;
  vrgModelVars[ID_CPL_APAP_mcgL] = 0.0;
  vrgModelVars[ID_CPL_AG_mcmolL] = 0.0;
  vrgModelVars[ID_CPL_AG_mcgL] = 0.0;
  vrgModelVars[ID_CPL_AS_mcmolL] = 0.0;
  vrgModelVars[ID_CPL_AS_mcgL] = 0.0;
  vrgModelVars[ID_CL_APAP_mcmolL] = 0.0;
  vrgModelVars[ID_CL_APAP_mcgL] = 0.0;
  vrgModelVars[ID_CU_APAP_mcg] = 0.0;
  vrgModelVars[ID_CU_AG_mcg] = 0.0;
  vrgModelVars[ID_CU_AS_mcg] = 0.0;
  vrgModelVars[ID_f_abs] = 0.0;
  vrgModelVars[ID_lntrue_dose] = 0.0;
  vrgModelVars[ID_lnODose_APAP] = 0.0;
  vrgModelVars[ID_lnfa] = 0.0;
  vrgModelVars[ID_lnCPL_APAP_mcgL] = 0.0;
  vrgModelVars[ID_lnCPL_AG_mcgL] = 0.0;
  vrgModelVars[ID_lnCPL_AS_mcgL] = 0.0;
  vrgModelVars[ID_lnCU_APAP_mcg] = 0.0;
  vrgModelVars[ID_lnCU_AG_mcg] = 0.0;
  vrgModelVars[ID_lnCU_AS_mcg] = 0.0;
  vrgModelVars[ID_lnf_abs] = 0.0;
  vrgModelVars[ID_Verr_lnCPL_APAP_mcmolL] = 0.0;
  vrgModelVars[ID_Verr_lnCPL_APAP_mcgL] = 0.0;
  vrgModelVars[ID_Verr_lnCPL_AG_mcmolL] = 0.0;
  vrgModelVars[ID_Verr_lnCPL_AG_mcgL] = 0.0;
  vrgModelVars[ID_Verr_lnCPL_AS_mcmolL] = 0.0;
  vrgModelVars[ID_Verr_lnCPL_AS_mcgL] = 0.0;
  vrgModelVars[ID_Verr_lnCU_APAP_mcg] = 0.0;
  vrgModelVars[ID_Verr_lnCU_AG_mcg] = 0.0;
  vrgModelVars[ID_Verr_lnCU_AS_mcg] = 0.0;

  vbModelReinitd = TRUE;

} /* InitModel */


/*----- Dynamics section */

void CalcDeriv (double  rgModelVars[], double  rgDerivs[], PDOUBLE pdTime)
{
  /* local */ double CVF_APAP;
  /* local */ double CVK_APAP;
  /* local */ double CM_APAP;
  /* local */ double CVM_APAP;
  /* local */ double CVL_APAP;
  /* local */ double CVR_APAP;
  /* local */ double CVS_APAP;
  /* local */ double CVF_AS;
  /* local */ double CVK_AS;
  /* local */ double CVL_AS;
  /* local */ double CM_AS;
  /* local */ double CVM_AS;
  /* local */ double CVR_AS;
  /* local */ double CVS_AS;
  /* local */ double CVF_AG;
  /* local */ double CVK_AG;
  /* local */ double CVL_AG;
  /* local */ double CM_AG;
  /* local */ double CVM_AG;
  /* local */ double CVR_AG;
  /* local */ double CVS_AG;

  CalcInputs (pdTime); /* Get new input vals */


  rgModelVars[ID_CF_APAP] = rgModelVars[ID_AF_APAP] / VF ;

  CVF_APAP = rgModelVars[ID_CF_APAP] / PF_APAP ;

  rgModelVars[ID_CK_APAP] = rgModelVars[ID_AK_APAP] / VK ;

  CVK_APAP = rgModelVars[ID_CK_APAP] / PK_APAP ;

  CM_APAP = rgModelVars[ID_AM_APAP] / VM ;

  CVM_APAP = CM_APAP / PM_APAP ;

  rgModelVars[ID_CL_APAP] = rgModelVars[ID_AL_APAP] / VL ;

  CVL_APAP = rgModelVars[ID_CL_APAP] / PL_APAP ;

  rgModelVars[ID_CR_APAP] = rgModelVars[ID_AR_APAP] / VR ;

  CVR_APAP = rgModelVars[ID_CR_APAP] / PR_APAP ;

  rgModelVars[ID_CS_APAP] = rgModelVars[ID_AS_APAP] / VS ;

  CVS_APAP = rgModelVars[ID_CS_APAP] / PS_APAP ;

  rgModelVars[ID_CF_AS] = rgModelVars[ID_AF_AS] / VF ;

  CVF_AS = rgModelVars[ID_CF_AS] / PF_AS ;

  rgModelVars[ID_CK_AS] = rgModelVars[ID_AK_AS] / VK ;

  CVK_AS = rgModelVars[ID_CK_AS] / PK_AS ;

  rgModelVars[ID_CL_AS] = rgModelVars[ID_AL_AS] / VL ;

  CVL_AS = rgModelVars[ID_CL_AS] / PL_AS ;

  CM_AS = rgModelVars[ID_AM_AS] / VM ;

  CVM_AS = CM_AS / PM_AS ;

  rgModelVars[ID_CR_AS] = rgModelVars[ID_AR_AS] / VR ;

  CVR_AS = rgModelVars[ID_CR_AS] / PR_AS ;

  rgModelVars[ID_CS_AS] = rgModelVars[ID_AS_AS] / VS ;

  CVS_AS = rgModelVars[ID_CS_AS] / PS_AS ;

  rgModelVars[ID_CF_AG] = rgModelVars[ID_AF_AG] / VF ;

  CVF_AG = rgModelVars[ID_CF_AG] / PF_AG ;

  rgModelVars[ID_CK_AG] = rgModelVars[ID_AK_AG] / VK ;

  CVK_AG = rgModelVars[ID_CK_AG] / PK_AG ;

  rgModelVars[ID_CL_AG] = rgModelVars[ID_AL_AG] / VL ;

  CVL_AG = rgModelVars[ID_CL_AG] / PL_AG ;

  CM_AG = rgModelVars[ID_AM_AG] / VM ;

  CVM_AG = CM_AG / PM_AG ;

  rgModelVars[ID_CR_AG] = rgModelVars[ID_AR_AG] / VR ;

  CVR_AG = rgModelVars[ID_CR_AG] / PR_AG ;

  rgModelVars[ID_CS_AG] = rgModelVars[ID_AS_AG] / VS ;

  CVS_AG = rgModelVars[ID_CS_AG] / PS_AG ;

  rgModelVars[ID_CA_APAP] = rgModelVars[ID_ABLA_APAP] / VBLV ;

  rgModelVars[ID_CV_APAP] = rgModelVars[ID_ABLV_APAP] / VBLA ;

  rgModelVars[ID_CPL_APAP] = rgModelVars[ID_CV_APAP] / BP_APAP ;

  rgModelVars[ID_CA_AS] = rgModelVars[ID_ABLA_AS] / VBLA ;

  rgModelVars[ID_CV_AS] = rgModelVars[ID_ABLV_AS] / VBLV ;

  rgModelVars[ID_CPL_AS] = rgModelVars[ID_CV_AS] / BP_APAP ;

  rgModelVars[ID_CA_AG] = rgModelVars[ID_ABLA_AG] / VBLA ;

  rgModelVars[ID_CV_AG] = rgModelVars[ID_ABLV_AG] / VBLV ;

  rgModelVars[ID_CPL_AG] = rgModelVars[ID_CV_AG] / BP_APAP ;

  rgDerivs[ID_CL_APAP_to_NAPQI_CYP] = CYP_Vmax * rgModelVars[ID_CL_APAP] / ( CYP_Km + rgModelVars[ID_CL_APAP] ) ;

  rgDerivs[ID_CL_APAP_to_AS_SULT] = SULT_Vmax * ( rgModelVars[ID_CL_APAP] ) * ( rgModelVars[ID_AL_PAPS] ) / ( ( SULT_Km_apap + rgModelVars[ID_CL_APAP] + pow ( rgModelVars[ID_CL_APAP] , 2 ) / SULT_Ki ) * ( SULT_Km_paps + rgModelVars[ID_AL_PAPS] ) ) ;

  rgDerivs[ID_CL_APAP_to_AG_UGT] = UGT_Vmax * ( rgModelVars[ID_CL_APAP] ) * ( rgModelVars[ID_AL_GA] ) / ( ( UGT_Km + rgModelVars[ID_CL_APAP] + pow ( rgModelVars[ID_CL_APAP] , 2 ) / UGT_Ki ) * ( UGT_Km_GA + rgModelVars[ID_AL_GA] ) ) ;

  rgDerivs[ID_AL_PAPS] = - rgDerivs[ID_CL_APAP_to_AS_SULT] + kPAPS_syn * ( 1 - rgModelVars[ID_AL_PAPS] ) ;

  rgDerivs[ID_AL_GA] = - rgDerivs[ID_CL_APAP_to_AG_UGT] + kGA_syn * ( 1 - rgModelVars[ID_AL_GA] ) ;

  rgDerivs[ID_AST_Oral_APAP] = vrgInputs[ID_OralExp_APAP].dVal * ODose_APAP ;

  rgDerivs[ID_AST_to_Gut_APAP] = true_dose * ( exp ( - (*pdTime) / Tg ) - exp ( - (*pdTime) / Tp ) ) / ( Tg - Tp ) ;

  rgDerivs[ID_AST_APAP] = rgDerivs[ID_AST_Oral_APAP] - rgDerivs[ID_AST_to_Gut_APAP] ;

  rgDerivs[ID_AL_APAP] = QL * rgModelVars[ID_CA_APAP] + rgDerivs[ID_AST_to_Gut_APAP] - QL * CVL_APAP - rgDerivs[ID_CL_APAP_to_NAPQI_CYP] - rgDerivs[ID_CL_APAP_to_AS_SULT] - rgDerivs[ID_CL_APAP_to_AG_UGT] ;

  rgDerivs[ID_pct_abs] = rgDerivs[ID_AST_to_Gut_APAP] / true_dose ;

  rgDerivs[ID_ABL_IV_APAP] = vrgInputs[ID_IVExp_APAP].dVal * IVDR_APAP ;

  rgDerivs[ID_ABLV_APAP] = QF * CVF_APAP + QM * CVM_APAP + QK * CVK_APAP + QL * CVL_APAP + QR * CVR_APAP + QS * CVS_APAP - QC * rgModelVars[ID_CV_APAP] + rgDerivs[ID_ABL_IV_APAP] ;

  rgDerivs[ID_ABLA_APAP] = QC * ( rgModelVars[ID_CV_APAP] - rgModelVars[ID_CA_APAP] ) ;

  rgDerivs[ID_AF_APAP] = QF * ( rgModelVars[ID_CA_APAP] - CVF_APAP ) ;

  rgDerivs[ID_AM_APAP] = QM * ( rgModelVars[ID_CA_APAP] - CVM_APAP ) ;

  rgDerivs[ID_AKE_APAP] = CLR_APAP * rgModelVars[ID_CA_APAP] ;

  rgDerivs[ID_AK_APAP] = QK * ( rgModelVars[ID_CA_APAP] - CVK_APAP ) - rgDerivs[ID_AKE_APAP] ;

  rgDerivs[ID_AR_APAP] = QR * ( rgModelVars[ID_CA_APAP] - CVR_APAP ) ;

  rgDerivs[ID_AS_APAP] = QS * ( rgModelVars[ID_CA_APAP] - CVS_APAP ) ;

  rgDerivs[ID_AU_APAP] = rgDerivs[ID_AKE_APAP] ;

  rgDerivs[ID_CH_AS_to_CL_AS] = Vmax_AS * rgModelVars[ID_CH_AS] / ( Km_AS + rgModelVars[ID_CH_AS] ) ;

  rgDerivs[ID_CH_AS] = rgDerivs[ID_CL_APAP_to_AS_SULT] - rgDerivs[ID_CH_AS_to_CL_AS] ;

  rgDerivs[ID_AL_AS] = QL * ( rgModelVars[ID_CA_AS] - CVL_AS ) + rgDerivs[ID_CH_AS_to_CL_AS] ;

  rgDerivs[ID_AF_AS] = QF * ( rgModelVars[ID_CA_AS] - CVF_AS ) ;

  rgDerivs[ID_AM_AS] = QM * ( rgModelVars[ID_CA_AS] - CVM_AS ) ;

  rgDerivs[ID_AR_AS] = QR * ( rgModelVars[ID_CA_AS] - CVR_AS ) ;

  rgDerivs[ID_AS_AS] = QS * ( rgModelVars[ID_CA_AS] - CVS_AS ) ;

  rgDerivs[ID_ABLV_AS] = QK * CVK_AS + QL * CVL_AS + QF * CVF_AS + QM * CVM_AS + QR * CVR_AS + QS * CVS_AS - QC * rgModelVars[ID_CV_AS] ;

  rgDerivs[ID_ABLA_AS] = QC * ( rgModelVars[ID_CV_AS] - rgModelVars[ID_CA_AS] ) ;

  rgDerivs[ID_AKE_AS] = CLR_AS * rgModelVars[ID_CA_AS] ;

  rgDerivs[ID_AK_AS] = QK * ( rgModelVars[ID_CA_AS] - CVK_AS ) - rgDerivs[ID_AKE_AS] ;

  rgDerivs[ID_AU_AS] = rgDerivs[ID_AKE_AS] ;

  rgDerivs[ID_CH_AG_to_CL_AG] = Vmax_AG * rgModelVars[ID_CH_AG] / ( Km_AG + rgModelVars[ID_CH_AG] ) ;

  rgDerivs[ID_CH_AG] = rgDerivs[ID_CL_APAP_to_AG_UGT] - rgDerivs[ID_CH_AG_to_CL_AG] ;

  rgDerivs[ID_AL_AG] = QL * ( rgModelVars[ID_CA_AG] - CVL_AG ) + rgDerivs[ID_CH_AG_to_CL_AG] ;

  rgDerivs[ID_AF_AG] = QF * ( rgModelVars[ID_CA_AG] - CVF_AG ) ;

  rgDerivs[ID_AM_AG] = QM * ( rgModelVars[ID_CA_AG] - CVM_AG ) ;

  rgDerivs[ID_AR_AG] = QR * ( rgModelVars[ID_CA_AG] - CVR_AG ) ;

  rgDerivs[ID_AS_AG] = QS * ( rgModelVars[ID_CA_AG] - CVS_AG ) ;

  rgDerivs[ID_ABLV_AG] = QK * CVK_AG + QL * CVL_AG + QF * CVF_AG + QM * CVM_AG + QR * CVR_AG + QS * CVS_AG - QC * rgModelVars[ID_CV_AG] ;

  rgDerivs[ID_ABLA_AG] = QC * ( rgModelVars[ID_CV_AG] - rgModelVars[ID_CA_AG] ) ;

  rgDerivs[ID_AKE_AG] = CLR_AG * rgModelVars[ID_CA_AG] ;

  rgDerivs[ID_AK_AG] = QK * ( rgModelVars[ID_CA_AG] - CVK_AG ) - rgDerivs[ID_AKE_AG] ;

  rgDerivs[ID_AU_AG] = rgDerivs[ID_AKE_AG] ;

} /* CalcDeriv */


/*----- Model scaling */

void ScaleModel (PDOUBLE pdTime)
{

  BW = exp ( lnBW ) ;

  kSG_Vm = exp ( lnkSG_Vm ) ;
  kSG_Km = exp ( lnkSG_Km ) ;
  Tg = exp ( lnTg ) ;
  Tp = exp ( lnTp ) ;

  CLC_APAP = exp ( lnCLC_APAP ) ;
  CLC_AS = exp ( lnCLC_AS ) ;
  CLC_AG = exp ( lnCLC_AG ) ;

  BP_APAP = exp ( lnBP_APAP ) ;

  PF_APAP = exp ( lnPF_APAP ) ;
  PG_APAP = exp ( lnPG_APAP ) ;
  PK_APAP = exp ( lnPK_APAP ) ;
  PL_APAP = exp ( lnPL_APAP ) ;
  PM_APAP = exp ( lnPM_APAP ) ;
  PR_APAP = exp ( lnPR_APAP ) ;
  PS_APAP = exp ( lnPS_APAP ) ;

  PK_AS = exp ( lnPK_AS ) ;
  PF_AS = exp ( lnPF_AS ) ;
  PL_AS = exp ( lnPL_AS ) ;
  PG_AS = exp ( lnPG_AS ) ;
  PM_AS = exp ( lnPM_AS ) ;
  PR_AS = exp ( lnPR_AS ) ;
  PS_AS = exp ( lnPS_AS ) ;

  PK_AG = exp ( lnPK_AG ) ;
  PF_AG = exp ( lnPF_AG ) ;
  PL_AG = exp ( lnPL_AG ) ;
  PG_AG = exp ( lnPG_AG ) ;
  PM_AG = exp ( lnPM_AG ) ;
  PR_AG = exp ( lnPR_AG ) ;
  PS_AG = exp ( lnPS_AG ) ;

  kPAPS = exp ( lnkPAPS ) ;
  kPAPS_syn = exp ( lnkPAPS_syn ) ;

  kGA = exp ( lnkGA ) ;
  kGA_syn = exp ( lnkGA_syn ) ;

  CYP_Km = exp ( lnCYP_Km ) ;
  CYP_VmaxC = exp ( lnCYP_VmaxC ) ;

  UGT_Km = exp ( lnUGT_Km ) ;
  UGT_VmaxC = exp ( lnUGT_VmaxC ) ;
  UGT_Km_GA = exp ( lnUGT_Km_GA ) ;
  UGT_Ki = exp ( lnUGT_Ki ) ;
  Vmax_AG = exp ( lnVmax_AG ) ;
  Km_AG = exp ( lnKm_AG ) ;

  SULT_Km_apap = exp ( lnSULT_Km_apap ) ;
  SULT_Km_paps = exp ( lnSULT_Km_paps ) ;
  SULT_Ki = exp ( lnSULT_Ki ) ;
  SULT_VmaxC = exp ( lnSULT_VmaxC ) ;
  Vmax_AS = exp ( lnVmax_AS ) ;
  Km_AS = exp ( lnKm_AS ) ;

  ODose_APAP_mg = ( mgkg_flag > 0.5 ? OralDose_APAP_mgkg * BW : OralDose_APAP_mg ) ;
  fa = ( ODose_APAP_mg < 1000 ? 0.0005 * ODose_APAP_mg + 0.37 : 0.88 ) ;
  ODose_APAP = ( fa * ODose_APAP_mg / OralDur_APAP ) * ( 1000. / MW_APAP ) ;
  true_dose = ( fa * ODose_APAP_mg ) * ( 1000. / MW_APAP ) ;

  IVD_APAP_mg = ( mgkg_flag > 0.5 ? IVDose_APAP_mgkg * BW : IVDose_APAP_mg ) ;
  IVDR_APAP = ( IVD_APAP_mg / IVDur_APAP ) * ( 1000. / MW_APAP ) ;

  VTC = VFC + VKC + VGC + VLC + VMC + VBLAC + VBLVC + VRC + VSC ;
  VF = VFC * BW / VTC ;
  VK = VKC * BW / VTC ;
  VG = VGC * BW / VTC ;
  VL = VLC * BW / VTC ;
  VM = VMC * BW / VTC ;
  VBLA = VBLAC * BW / VTC ;
  VBLV = VBLVC * BW / VTC ;
  VR = VRC * BW / VTC ;
  VS = VSC * BW / VTC ;

  QTC = QFC + QKC + QGC + QLBC + QMC + QRC + QSC ;
  QC = QCC * pow ( BW , 0.75 ) ;

  QF = QFC * QC / QTC ;
  QK = QKC * QC / QTC ;
  QG = QGC * QC / QTC ;
  QM = QMC * QC / QTC ;
  QLB = QLBC * QC / QTC ;
  QR = QRC * QC / QTC ;
  QS = QSC * QC / QTC ;
  QL = QG + QLB ;

  CLR_APAP = ( alpha_APAP ) * CLC_APAP * BW ;
  CLR_AS = ( alpha_AS ) * ( CLC_AS ) * BW ;
  CLR_AG = ( alpha_AG ) * CLC_AG * BW ;

  CYP_Vmax = CYP_VmaxC * pow ( BW , 0.75 ) ;
  UGT_Vmax = UGT_VmaxC * pow ( BW , 0.75 ) ;
  SULT_Vmax = SULT_VmaxC * pow ( BW , 0.75 ) ;

  vrgModelVars[ID_AL_PAPS] = 1. ;
  vrgModelVars[ID_AL_GA] = 1. ;

} /* ScaleModel */


/*----- Jacobian calculations */

void CalcJacob (PDOUBLE pdTime, double rgModelVars[],
                long column, double rgdJac[])
{

} /* CalcJacob */


/*----- Outputs calculations */

void CalcOutputs (double  rgModelVars[], double  rgDerivs[], PDOUBLE pdTime)
{

  rgModelVars[ID_CPL_APAP_mcmolL] = rgModelVars[ID_CPL_APAP] ;

  rgModelVars[ID_CPL_APAP_mcgL] = rgModelVars[ID_CPL_APAP] * MW_APAP ;
  rgModelVars[ID_CPL_AG_mcmolL] = rgModelVars[ID_CPL_AG] ;

  rgModelVars[ID_CPL_AG_mcgL] = rgModelVars[ID_CPL_AG] * MW_AG ;
  rgModelVars[ID_CPL_AS_mcmolL] = rgModelVars[ID_CPL_AS] ;

  rgModelVars[ID_CPL_AS_mcgL] = rgModelVars[ID_CPL_AS] * MW_AS ;
  rgModelVars[ID_CL_APAP_mcmolL] = rgModelVars[ID_CL_APAP] ;

  rgModelVars[ID_CL_APAP_mcgL] = rgModelVars[ID_CL_APAP] * MW_APAP ;

  rgModelVars[ID_CU_APAP_mcg] = rgModelVars[ID_AU_APAP] * MW_APAP ;
  rgModelVars[ID_CU_AG_mcg] = rgModelVars[ID_AU_AG] * MW_AG ;
  rgModelVars[ID_CU_AS_mcg] = rgModelVars[ID_AU_AS] * MW_AS ;
  rgModelVars[ID_f_abs] = rgModelVars[ID_AST_to_Gut_APAP] / true_dose ;
  rgModelVars[ID_lntrue_dose] = log ( true_dose ) ;
  rgModelVars[ID_lnODose_APAP] = log ( ODose_APAP ) ;
  rgModelVars[ID_lnfa] = log ( fa ) ;

  rgModelVars[ID_lnCPL_APAP_mcgL] = ( rgModelVars[ID_CPL_APAP_mcgL] > 0 ? log ( rgModelVars[ID_CPL_APAP_mcgL] ) : -20. ) ;
  rgModelVars[ID_lnCPL_AG_mcgL] = ( rgModelVars[ID_CPL_AG_mcgL] > 0 ? log ( rgModelVars[ID_CPL_AG_mcgL] ) : -20. ) ;
  rgModelVars[ID_lnCPL_AS_mcgL] = ( rgModelVars[ID_CPL_AS_mcgL] > 0 ? log ( rgModelVars[ID_CPL_AS_mcgL] ) : -20. ) ;
  rgModelVars[ID_lnCU_APAP_mcg] = ( rgModelVars[ID_CU_APAP_mcg] > 0 ? log ( rgModelVars[ID_CU_APAP_mcg] ) : -20. ) ;
  rgModelVars[ID_lnCU_AG_mcg] = ( rgModelVars[ID_CU_AG_mcg] > 0 ? log ( rgModelVars[ID_CU_AG_mcg] ) : -20. ) ;
  rgModelVars[ID_lnCU_AS_mcg] = ( rgModelVars[ID_CU_AS_mcg] > 0 ? log ( rgModelVars[ID_CU_AS_mcg] ) : -20. ) ;
  rgModelVars[ID_lnf_abs] = ( rgModelVars[ID_f_abs] > 0 ? log ( rgModelVars[ID_f_abs] ) : -20 ) ;

  rgModelVars[ID_Verr_lnCPL_APAP_mcmolL] = rgModelVars[ID_Verr_lnCPL_APAP_mcmolL] ;
  rgModelVars[ID_Verr_lnCPL_APAP_mcgL] = rgModelVars[ID_Verr_lnCPL_APAP_mcgL] ;
  rgModelVars[ID_Verr_lnCPL_AG_mcmolL] = rgModelVars[ID_Verr_lnCPL_AG_mcmolL] ;
  rgModelVars[ID_Verr_lnCPL_AG_mcgL] = rgModelVars[ID_Verr_lnCPL_AG_mcgL] ;
  rgModelVars[ID_Verr_lnCPL_AS_mcmolL] = rgModelVars[ID_Verr_lnCPL_AS_mcmolL] ;
  rgModelVars[ID_Verr_lnCPL_AS_mcgL] = rgModelVars[ID_Verr_lnCPL_AS_mcgL] ;

  rgModelVars[ID_Verr_lnCU_APAP_mcg] = rgModelVars[ID_Verr_lnCU_APAP_mcg] ;
  rgModelVars[ID_Verr_lnCU_AG_mcg] = rgModelVars[ID_Verr_lnCU_AG_mcg] ;
  rgModelVars[ID_Verr_lnCU_AS_mcg] = rgModelVars[ID_Verr_lnCU_AS_mcg] ;

}  /* CalcOutputs */


