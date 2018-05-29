/* APAP_PBPK_thera.c for R deSolve package
   ___________________________________________________

   Model File:  APAP_PBPK_thera.model

   Date:  Mon May 28 16:28:54 2018

   Created by:  "mod v6.0.0"
    -- a model preprocessor by Don Maszle
   ___________________________________________________

   Copyright (c) 1993-2018 Free Software Foundation, Inc.

   Model calculations for compartmental model:

   44 States:
     CL_APAP_to_NAPQI_CYP = 0.0,
     CL_APAP_to_AS_SULT = 0.0,
     CL_APAP_to_AG_UGT = 0.0,
     AST_Oral_APAP = 0.0,
     AST_APAP = 0.0,
     AST_to_Gut_APAP = 0.0,
     AF_APAP = 0.0,
     AR_APAP = 0.0,
     AS_APAP = 0.0,
     AF_AS = 0.0,
     AR_AS = 0.0,
     AS_AS = 0.0,
     AF_AG = 0.0,
     AR_AG = 0.0,
     AS_AG = 0.0,
     AKE_APAP = 0.0,
     AKE_AS = 0.0,
     AKE_AG = 0.0,
     AK_APAP = 0.0,
     AK_AS = 0.0,
     AK_AG = 0.0,
     AL_APAP = 0.0,
     AL_AS = 0.0,
     AL_AG = 0.0,
     AL_PAPS = 0.0,
     AL_GA = 0.0,
     CH_AG = 0.0,
     CH_AG_to_CL_AG = 0.0,
     CH_AS = 0.0,
     CH_AS_to_CL_AS = 0.0,
     AM_APAP = 0.0,
     AM_AS = 0.0,
     AM_AG = 0.0,
     ABLA_APAP = 0.0,
     ABLA_AS = 0.0,
     ABLA_AG = 0.0,
     ABL_IV_APAP = 0.0,
     ABLV_APAP = 0.0,
     ABLV_AS = 0.0,
     ABLV_AG = 0.0,
     AU_APAP = 0.0,
     AU_AS = 0.0,
     AU_AG = 0.0,
     pct_abs = 0.0,

   55 Outputs:
    "CF_APAP",
    "CK_APAP",
    "CL_APAP",
    "CR_APAP",
    "CS_APAP",
    "CF_AS",
    "CK_AS",
    "CL_AS",
    "CR_AS",
    "CS_AS",
    "CF_AG",
    "CK_AG",
    "CL_AG",
    "CR_AG",
    "CS_AG",
    "CA_APAP",
    "CV_APAP",
    "CPL_APAP",
    "CA_AS",
    "CV_AS",
    "CPL_AS",
    "CA_AG",
    "CV_AG",
    "CPL_AG",
    "CPL_APAP_mcmolL",
    "CPL_APAP_mcgL",
    "CPL_AG_mcmolL",
    "CPL_AG_mcgL",
    "CPL_AS_mcmolL",
    "CPL_AS_mcgL",
    "CL_APAP_mcmolL",
    "CL_APAP_mcgL",
    "CU_APAP_mcg",
    "CU_AG_mcg",
    "CU_AS_mcg",
    "f_abs",
    "lntrue_dose",
    "lnODose_APAP",
    "lnfa",
    "lnCPL_APAP_mcgL",
    "lnCPL_AG_mcgL",
    "lnCPL_AS_mcgL",
    "lnCU_APAP_mcg",
    "lnCU_AG_mcg",
    "lnCU_AS_mcg",
    "lnf_abs",
    "Verr_lnCPL_APAP_mcmolL",
    "Verr_lnCPL_APAP_mcgL",
    "Verr_lnCPL_AG_mcmolL",
    "Verr_lnCPL_AG_mcgL",
    "Verr_lnCPL_AS_mcmolL",
    "Verr_lnCPL_AS_mcgL",
    "Verr_lnCU_APAP_mcg",
    "Verr_lnCU_AG_mcg",
    "Verr_lnCU_AS_mcg",

   2 Inputs:
     OralExp_APAP (forcing function)
     IVExp_APAP (forcing function)

   375 Parameters:
     MW_APAP = 151.17,
     MW_AG = 327.28,
     MW_AS = 231.22,
     BW = 0,
     lnBW = 4.0,
     QCC = 16.2,
     VFC = 0.214,
     VKC = 0.0044,
     VGC = 0.0144,
     VLC = 0.0257,
     VMC = 0.4,
     VBLAC = 0.0243,
     VBLVC = 0.0557,
     VSC = 0.185,
     VRC = 0.0765,
     QFC = 0.052,
     QKC = 0.175,
     QGC = 0.181,
     QLBC = 0.046,
     QMC = 0.191,
     QSC = 0.14,
     QRC = 0.215,
     kSG_Vm = 0,
     lnkSG_Vm = 7.75,
     kSG_Km = 0,
     lnkSG_Km = 7.47,
     Tg = 0,
     lnTg = -1.0,
     Tp = 0,
     lnTp = -3.0,
     CLC_APAP = 0,
     lnCLC_APAP = -2.0,
     CLC_AS = 0,
     lnCLC_AS = -2.0,
     CLC_AG = 0,
     lnCLC_AG = -2.0,
     alpha_APAP = 1.,
     alpha_AS = 1.,
     alpha_AG = 1.,
     BP_APAP = 0.9,
     lnBP_APAP = log(0.9),
     PF_APAP = 0.447,
     lnPF_APAP = log(0.447),
     PG_APAP = 0.907,
     lnPG_APAP = log(0.907),
     PK_APAP = 0.711,
     lnPK_APAP = log(0.711),
     PL_APAP = 0.687,
     lnPL_APAP = log(0.687),
     PM_APAP = 0.687,
     lnPM_APAP = log(0.687),
     PR_APAP = 0.676,
     lnPR_APAP = log(0.676),
     PS_APAP = 0.606,
     lnPS_APAP = log(0.606),
     PF_AS = 0.088,
     lnPF_AS = log(0.088),
     PG_AS = 0.297,
     lnPG_AS = log(0.297),
     PK_AS = 0.261,
     lnPK_AS = log(0.261),
     PL_AS = 0.203,
     lnPL_AS = log(0.203),
     PM_AS = 0.199,
     lnPM_AS = log(0.199),
     PR_AS = 0.207,
     lnPR_AS = log(0.207),
     PS_AS = 0.254,
     lnPS_AS = log(0.254),
     PF_AG = 0.128,
     lnPF_AG = log(0.128),
     PG_AG = 0.436,
     lnPG_AG = log(0.436),
     PK_AG = 0.392,
     lnPK_AG = log(0.392),
     PL_AG = 0.321,
     lnPL_AG = log(0.321),
     PM_AG = 0.336,
     lnPM_AG = log(0.366),
     PR_AG = 0.364,
     lnPR_AG = log(0.364),
     PS_AG = 0.351,
     lnPS_AG = log(0.351),
     kPAPS = 0.018,
     lnkPAPS = log(0.018),
     kPAPS_syn = 0,
     lnkPAPS_syn = -30,
     kGA = 0.008,
     lnkGA = log(0.008),
     kGA_syn = 0,
     lnkGA_syn = -30,
     CYP_Km = 0,
     lnCYP_Km = 7.6,
     CYP_VmaxC = 0,
     lnCYP_VmaxC = 8.4,
     UGT_Km = 0,
     lnUGT_Km = 9,
     UGT_Ki = 0,
     lnUGT_Ki = 23,
     UGT_VmaxC = 0,
     lnUGT_VmaxC = 7.3,
     UGT_Km_GA = 0,
     lnUGT_Km_GA = 2.3,
     Vmax_AG = 0,
     lnVmax_AG = 30,
     Km_AG = 0,
     lnKm_AG = 9.9,
     SULT_Km_apap = 0,
     lnSULT_Km_apap = 3.0,
     SULT_Km_paps = 0,
     lnSULT_Km_paps = 3.0,
     SULT_Ki = 0,
     lnSULT_Ki = 20,
     SULT_VmaxC = 0,
     lnSULT_VmaxC = 10,
     Vmax_AS = 0,
     lnVmax_AS = 20,
     Km_AS = 0,
     lnKm_AS = 10,
     mgkg_flag = 1.,
     OralDose_APAP_mgkg = 1,
     lnOralDose_APAP_mgkg = 0,
     OralDose_APAP_mg = 1,
     lnOralDose_APAP_mg = 0,
     OralDur_APAP = 0.001,
     ODose_APAP_mg = 0,
     fa = 0,
     ODose_APAP = 0,
     true_dose = 0,
     IVDose_APAP_mgkg = 0.,
     lnIVDose_APAP_mgkg = 0,
     IVDose_APAP_mg = 0.,
     lnIVDose_APAP_mg = 0,
     IVDur_APAP = 0.001,
     IVD_APAP_mg = 0,
     IVDR_APAP = 0,
     CYP_Vmax = 0,
     UGT_Vmax = 0,
     SULT_Vmax = 0,
     VTC = 0,
     VF = 0,
     VK = 0,
     VG = 0,
     VM = 0,
     VL = 0,
     VBLA = 0,
     VBLV = 0,
     VR = 0,
     VS = 0,
     QTC = 0,
     QC = 0,
     QF = 0,
     QK = 0,
     QG = 0,
     QM = 0,
     QLB = 0,
     QR = 0,
     QS = 0,
     QL = 0,
     CLR_APAP = 0,
     CLR_AS = 0,
     CLR_AG = 0,
     M_OralDose_APAP = 0,
     Var_OralDose_APAP = 0,
     M_IVDose_APAP = 0,
     Var_IVDose_APAP = 0,
     M_lnOralDose_APAP = 0,
     Var_lnOralDose_APAP = 0,
     M_lnIVDose_APAP = 0,
     M_lnVar_IVDose_APAP = 0,
     M_BW = 0,
     M_lnBW = 0,
     M_fa = 0,
     M_lnfa = 0,
     M_kSG_Vm = 0,
     M_lnkSG_Vm = 0,
     M_kSG_Km = 0,
     M_lnkSG_Km = 0,
     M_Tg = 0,
     M_lnTg = 0,
     M_Tp = 0,
     M_lnTp = 0,
     M_CLC_APAP = 0,
     M_lnCLC_APAP = 0,
     M_CLC_AS = 0,
     M_lnCLC_AS = 0,
     M_CLC_AG = 0,
     M_lnCLC_AG = 0,
     M_BP_APAP = 0,
     M_lnBP_APAP = 0,
     M_PF_APAP = 0,
     M_lnPF_APAP = 0,
     M_PG_APAP = 0,
     M_lnPG_APAP = 0,
     M_PK_APAP = 0,
     M_lnPK_APAP = 0,
     M_PL_APAP = 0,
     M_lnPL_APAP = 0,
     M_PM_APAP = 0,
     M_lnPM_APAP = 0,
     M_PR_APAP = 0,
     M_lnPR_APAP = 0,
     M_PS_APAP = 0,
     M_lnPS_APAP = 0,
     M_PK_AS = 0,
     M_lnPK_AS = 0,
     M_PF_AS = 0,
     M_lnPF_AS = 0,
     M_PL_AS = 0,
     M_lnPL_AS = 0,
     M_PG_AS = 0,
     M_lnPG_AS = 0,
     M_PM_AS = 0,
     M_lnPM_AS = 0,
     M_PR_AS = 0,
     M_lnPR_AS = 0,
     M_PS_AS = 0,
     M_lnPS_AS = 0,
     M_PK_AG = 0,
     M_lnPK_AG = 0,
     M_PF_AG = 0,
     M_lnPF_AG = 0,
     M_PL_AG = 0,
     M_lnPL_AG = 0,
     M_PG_AG = 0,
     M_lnPG_AG = 0,
     M_PM_AG = 0,
     M_lnPM_AG = 0,
     M_PR_AG = 0,
     M_lnPR_AG = 0,
     M_PS_AG = 0,
     M_lnPS_AG = 0,
     M_kPAPS = 0,
     M_lnkPAPS = 0,
     M_kPAPS_syn = 0,
     M_lnkPAPS_syn = 0,
     M_kGA = 0,
     M_lnkGA = 0,
     M_kGA_syn = 0,
     M_lnkGA_syn = 0,
     M_CYP_Km = 0,
     M_lnCYP_Km = 0,
     M_CYP_VmaxC = 0,
     M_lnCYP_VmaxC = 0,
     M_UGT_Km = 0,
     M_lnUGT_Km = 0,
     M_UGT_VmaxC = 0,
     M_lnUGT_VmaxC = 0,
     M_UGT_Km_GA = 0,
     M_lnUGT_Km_GA = 0,
     M_UGT_Ki = 0,
     M_lnUGT_Ki = 0,
     M_Vmax_AG = 0,
     M_lnVmax_AG = 0,
     M_Km_AG = 0,
     M_lnKm_AG = 0,
     M_SULT_Km_apap = 0,
     M_lnSULT_Km_apap = 0,
     M_SULT_Km_paps = 0,
     M_lnSULT_Km_paps = 0,
     M_SULT_Ki = 0,
     M_lnSULT_Ki = 0,
     M_SULT_VmaxC = 0,
     M_lnSULT_VmaxC = 0,
     M_Vmax_AS = 0,
     M_lnVmax_AS = 0,
     M_Km_AS = 0,
     M_lnKm_AS = 0,
     Var_BW = 0,
     Var_lnBW = 0,
     Var_fa = 0,
     Var_lnfa = 0,
     Var_kSG_Vm = 0,
     Var_lnkSG_Vm = 0,
     Var_kSG_Km = 0,
     Var_lnkSG_Km = 0,
     Var_Tg = 0,
     Var_lnTg = 0,
     Var_Tp = 0,
     Var_lnTp = 0,
     Var_CLC_APAP = 0,
     Var_lnCLC_APAP = 0,
     Var_CLC_AS = 0,
     Var_lnCLC_AS = 0,
     Var_CLC_AG = 0,
     Var_lnCLC_AG = 0,
     Var_BP_APAP = 0,
     Var_lnBP_APAP = 0,
     Var_PF_APAP = 0,
     Var_lnPF_APAP = 0,
     Var_PG_APAP = 0,
     Var_lnPG_APAP = 0,
     Var_PK_APAP = 0,
     Var_lnPK_APAP = 0,
     Var_PL_APAP = 0,
     Var_lnPL_APAP = 0,
     Var_PM_APAP = 0,
     Var_lnPM_APAP = 0,
     Var_PR_APAP = 0,
     Var_lnPR_APAP = 0,
     Var_PS_APAP = 0,
     Var_lnPS_APAP = 0,
     Var_PK_AS = 0,
     Var_lnPK_AS = 0,
     Var_PF_AS = 0,
     Var_lnPF_AS = 0,
     Var_PL_AS = 0,
     Var_lnPL_AS = 0,
     Var_PG_AS = 0,
     Var_lnPG_AS = 0,
     Var_PM_AS = 0,
     Var_lnPM_AS = 0,
     Var_PR_AS = 0,
     Var_lnPR_AS = 0,
     Var_PS_AS = 0,
     Var_lnPS_AS = 0,
     Var_PK_AG = 0,
     Var_lnPK_AG = 0,
     Var_PF_AG = 0,
     Var_lnPF_AG = 0,
     Var_PL_AG = 0,
     Var_lnPL_AG = 0,
     Var_PG_AG = 0,
     Var_lnPG_AG = 0,
     Var_PM_AG = 0,
     Var_lnPM_AG = 0,
     Var_PR_AG = 0,
     Var_lnPR_AG = 0,
     Var_PS_AG = 0,
     Var_lnPS_AG = 0,
     Var_kPAPS = 0,
     Var_lnkPAPS = 0,
     Var_kPAPS_syn = 0,
     Var_lnkPAPS_syn = 0,
     Var_kGA = 0,
     Var_lnkGA = 0,
     Var_kGA_syn = 0,
     Var_lnkGA_syn = 0,
     Var_CYP_Km = 0,
     Var_lnCYP_Km = 0,
     Var_CYP_VmaxC = 0,
     Var_lnCYP_VmaxC = 0,
     Var_UGT_Km = 0,
     Var_lnUGT_Km = 0,
     Var_UGT_VmaxC = 0,
     Var_lnUGT_VmaxC = 0,
     Var_UGT_Km_GA = 0,
     Var_lnUGT_Km_GA = 0,
     Var_UGT_Ki = 0,
     Var_lnUGT_Ki = 0,
     Var_Vmax_AG = 0,
     Var_lnVmax_AG = 0,
     Var_Km_AG = 0,
     Var_lnKm_AG = 0,
     Var_SULT_KVar_apap = 0,
     Var_lnSULT_Km_apap = 0,
     Var_SULT_KVar_paps = 0,
     Var_lnSULT_Km_paps = 0,
     Var_SULT_Ki = 0,
     Var_lnSULT_Ki = 0,
     Var_SULT_VmaxC = 0,
     Var_lnSULT_VmaxC = 0,
     Var_Vmax_AS = 0,
     Var_lnVmax_AS = 0,
     Var_Km_AS = 0,
     Var_lnKm_AS = 0,
     Verr_CPL_APAP_mcmolL = 0,
     Verr_CPL_APAP_mcgL = 0,
     Verr_CPL_AG_mcmolL = 0,
     Verr_CPL_AG_mcgL = 0,
     Verr_CPL_AS_mcmolL = 0,
     Verr_CPL_AS_mcgL = 0,
     Verr_CU_APAP_mcg = 0,
     Verr_CU_AG_mcg = 0,
     Verr_CU_AS_mcg = 0,
*/

#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>
#include <R_ext/Rdynload.h>

/* Model variables: States */
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

/* Model variables: Outputs */
#define ID_CF_APAP 0x00000
#define ID_CK_APAP 0x00001
#define ID_CL_APAP 0x00002
#define ID_CR_APAP 0x00003
#define ID_CS_APAP 0x00004
#define ID_CF_AS 0x00005
#define ID_CK_AS 0x00006
#define ID_CL_AS 0x00007
#define ID_CR_AS 0x00008
#define ID_CS_AS 0x00009
#define ID_CF_AG 0x0000a
#define ID_CK_AG 0x0000b
#define ID_CL_AG 0x0000c
#define ID_CR_AG 0x0000d
#define ID_CS_AG 0x0000e
#define ID_CA_APAP 0x0000f
#define ID_CV_APAP 0x00010
#define ID_CPL_APAP 0x00011
#define ID_CA_AS 0x00012
#define ID_CV_AS 0x00013
#define ID_CPL_AS 0x00014
#define ID_CA_AG 0x00015
#define ID_CV_AG 0x00016
#define ID_CPL_AG 0x00017
#define ID_CPL_APAP_mcmolL 0x00018
#define ID_CPL_APAP_mcgL 0x00019
#define ID_CPL_AG_mcmolL 0x0001a
#define ID_CPL_AG_mcgL 0x0001b
#define ID_CPL_AS_mcmolL 0x0001c
#define ID_CPL_AS_mcgL 0x0001d
#define ID_CL_APAP_mcmolL 0x0001e
#define ID_CL_APAP_mcgL 0x0001f
#define ID_CU_APAP_mcg 0x00020
#define ID_CU_AG_mcg 0x00021
#define ID_CU_AS_mcg 0x00022
#define ID_f_abs 0x00023
#define ID_lntrue_dose 0x00024
#define ID_lnODose_APAP 0x00025
#define ID_lnfa 0x00026
#define ID_lnCPL_APAP_mcgL 0x00027
#define ID_lnCPL_AG_mcgL 0x00028
#define ID_lnCPL_AS_mcgL 0x00029
#define ID_lnCU_APAP_mcg 0x0002a
#define ID_lnCU_AG_mcg 0x0002b
#define ID_lnCU_AS_mcg 0x0002c
#define ID_lnf_abs 0x0002d
#define ID_Verr_lnCPL_APAP_mcmolL 0x0002e
#define ID_Verr_lnCPL_APAP_mcgL 0x0002f
#define ID_Verr_lnCPL_AG_mcmolL 0x00030
#define ID_Verr_lnCPL_AG_mcgL 0x00031
#define ID_Verr_lnCPL_AS_mcmolL 0x00032
#define ID_Verr_lnCPL_AS_mcgL 0x00033
#define ID_Verr_lnCU_APAP_mcg 0x00034
#define ID_Verr_lnCU_AG_mcg 0x00035
#define ID_Verr_lnCU_AS_mcg 0x00036

/* Parameters */
static double parms[375];

#define MW_APAP parms[0]
#define MW_AG parms[1]
#define MW_AS parms[2]
#define BW parms[3]
#define lnBW parms[4]
#define QCC parms[5]
#define VFC parms[6]
#define VKC parms[7]
#define VGC parms[8]
#define VLC parms[9]
#define VMC parms[10]
#define VBLAC parms[11]
#define VBLVC parms[12]
#define VSC parms[13]
#define VRC parms[14]
#define QFC parms[15]
#define QKC parms[16]
#define QGC parms[17]
#define QLBC parms[18]
#define QMC parms[19]
#define QSC parms[20]
#define QRC parms[21]
#define kSG_Vm parms[22]
#define lnkSG_Vm parms[23]
#define kSG_Km parms[24]
#define lnkSG_Km parms[25]
#define Tg parms[26]
#define lnTg parms[27]
#define Tp parms[28]
#define lnTp parms[29]
#define CLC_APAP parms[30]
#define lnCLC_APAP parms[31]
#define CLC_AS parms[32]
#define lnCLC_AS parms[33]
#define CLC_AG parms[34]
#define lnCLC_AG parms[35]
#define alpha_APAP parms[36]
#define alpha_AS parms[37]
#define alpha_AG parms[38]
#define BP_APAP parms[39]
#define lnBP_APAP parms[40]
#define PF_APAP parms[41]
#define lnPF_APAP parms[42]
#define PG_APAP parms[43]
#define lnPG_APAP parms[44]
#define PK_APAP parms[45]
#define lnPK_APAP parms[46]
#define PL_APAP parms[47]
#define lnPL_APAP parms[48]
#define PM_APAP parms[49]
#define lnPM_APAP parms[50]
#define PR_APAP parms[51]
#define lnPR_APAP parms[52]
#define PS_APAP parms[53]
#define lnPS_APAP parms[54]
#define PF_AS parms[55]
#define lnPF_AS parms[56]
#define PG_AS parms[57]
#define lnPG_AS parms[58]
#define PK_AS parms[59]
#define lnPK_AS parms[60]
#define PL_AS parms[61]
#define lnPL_AS parms[62]
#define PM_AS parms[63]
#define lnPM_AS parms[64]
#define PR_AS parms[65]
#define lnPR_AS parms[66]
#define PS_AS parms[67]
#define lnPS_AS parms[68]
#define PF_AG parms[69]
#define lnPF_AG parms[70]
#define PG_AG parms[71]
#define lnPG_AG parms[72]
#define PK_AG parms[73]
#define lnPK_AG parms[74]
#define PL_AG parms[75]
#define lnPL_AG parms[76]
#define PM_AG parms[77]
#define lnPM_AG parms[78]
#define PR_AG parms[79]
#define lnPR_AG parms[80]
#define PS_AG parms[81]
#define lnPS_AG parms[82]
#define kPAPS parms[83]
#define lnkPAPS parms[84]
#define kPAPS_syn parms[85]
#define lnkPAPS_syn parms[86]
#define kGA parms[87]
#define lnkGA parms[88]
#define kGA_syn parms[89]
#define lnkGA_syn parms[90]
#define CYP_Km parms[91]
#define lnCYP_Km parms[92]
#define CYP_VmaxC parms[93]
#define lnCYP_VmaxC parms[94]
#define UGT_Km parms[95]
#define lnUGT_Km parms[96]
#define UGT_Ki parms[97]
#define lnUGT_Ki parms[98]
#define UGT_VmaxC parms[99]
#define lnUGT_VmaxC parms[100]
#define UGT_Km_GA parms[101]
#define lnUGT_Km_GA parms[102]
#define Vmax_AG parms[103]
#define lnVmax_AG parms[104]
#define Km_AG parms[105]
#define lnKm_AG parms[106]
#define SULT_Km_apap parms[107]
#define lnSULT_Km_apap parms[108]
#define SULT_Km_paps parms[109]
#define lnSULT_Km_paps parms[110]
#define SULT_Ki parms[111]
#define lnSULT_Ki parms[112]
#define SULT_VmaxC parms[113]
#define lnSULT_VmaxC parms[114]
#define Vmax_AS parms[115]
#define lnVmax_AS parms[116]
#define Km_AS parms[117]
#define lnKm_AS parms[118]
#define mgkg_flag parms[119]
#define OralDose_APAP_mgkg parms[120]
#define lnOralDose_APAP_mgkg parms[121]
#define OralDose_APAP_mg parms[122]
#define lnOralDose_APAP_mg parms[123]
#define OralDur_APAP parms[124]
#define ODose_APAP_mg parms[125]
#define fa parms[126]
#define ODose_APAP parms[127]
#define true_dose parms[128]
#define IVDose_APAP_mgkg parms[129]
#define lnIVDose_APAP_mgkg parms[130]
#define IVDose_APAP_mg parms[131]
#define lnIVDose_APAP_mg parms[132]
#define IVDur_APAP parms[133]
#define IVD_APAP_mg parms[134]
#define IVDR_APAP parms[135]
#define CYP_Vmax parms[136]
#define UGT_Vmax parms[137]
#define SULT_Vmax parms[138]
#define VTC parms[139]
#define VF parms[140]
#define VK parms[141]
#define VG parms[142]
#define VM parms[143]
#define VL parms[144]
#define VBLA parms[145]
#define VBLV parms[146]
#define VR parms[147]
#define VS parms[148]
#define QTC parms[149]
#define QC parms[150]
#define QF parms[151]
#define QK parms[152]
#define QG parms[153]
#define QM parms[154]
#define QLB parms[155]
#define QR parms[156]
#define QS parms[157]
#define QL parms[158]
#define CLR_APAP parms[159]
#define CLR_AS parms[160]
#define CLR_AG parms[161]
#define M_OralDose_APAP parms[162]
#define Var_OralDose_APAP parms[163]
#define M_IVDose_APAP parms[164]
#define Var_IVDose_APAP parms[165]
#define M_lnOralDose_APAP parms[166]
#define Var_lnOralDose_APAP parms[167]
#define M_lnIVDose_APAP parms[168]
#define M_lnVar_IVDose_APAP parms[169]
#define M_BW parms[170]
#define M_lnBW parms[171]
#define M_fa parms[172]
#define M_lnfa parms[173]
#define M_kSG_Vm parms[174]
#define M_lnkSG_Vm parms[175]
#define M_kSG_Km parms[176]
#define M_lnkSG_Km parms[177]
#define M_Tg parms[178]
#define M_lnTg parms[179]
#define M_Tp parms[180]
#define M_lnTp parms[181]
#define M_CLC_APAP parms[182]
#define M_lnCLC_APAP parms[183]
#define M_CLC_AS parms[184]
#define M_lnCLC_AS parms[185]
#define M_CLC_AG parms[186]
#define M_lnCLC_AG parms[187]
#define M_BP_APAP parms[188]
#define M_lnBP_APAP parms[189]
#define M_PF_APAP parms[190]
#define M_lnPF_APAP parms[191]
#define M_PG_APAP parms[192]
#define M_lnPG_APAP parms[193]
#define M_PK_APAP parms[194]
#define M_lnPK_APAP parms[195]
#define M_PL_APAP parms[196]
#define M_lnPL_APAP parms[197]
#define M_PM_APAP parms[198]
#define M_lnPM_APAP parms[199]
#define M_PR_APAP parms[200]
#define M_lnPR_APAP parms[201]
#define M_PS_APAP parms[202]
#define M_lnPS_APAP parms[203]
#define M_PK_AS parms[204]
#define M_lnPK_AS parms[205]
#define M_PF_AS parms[206]
#define M_lnPF_AS parms[207]
#define M_PL_AS parms[208]
#define M_lnPL_AS parms[209]
#define M_PG_AS parms[210]
#define M_lnPG_AS parms[211]
#define M_PM_AS parms[212]
#define M_lnPM_AS parms[213]
#define M_PR_AS parms[214]
#define M_lnPR_AS parms[215]
#define M_PS_AS parms[216]
#define M_lnPS_AS parms[217]
#define M_PK_AG parms[218]
#define M_lnPK_AG parms[219]
#define M_PF_AG parms[220]
#define M_lnPF_AG parms[221]
#define M_PL_AG parms[222]
#define M_lnPL_AG parms[223]
#define M_PG_AG parms[224]
#define M_lnPG_AG parms[225]
#define M_PM_AG parms[226]
#define M_lnPM_AG parms[227]
#define M_PR_AG parms[228]
#define M_lnPR_AG parms[229]
#define M_PS_AG parms[230]
#define M_lnPS_AG parms[231]
#define M_kPAPS parms[232]
#define M_lnkPAPS parms[233]
#define M_kPAPS_syn parms[234]
#define M_lnkPAPS_syn parms[235]
#define M_kGA parms[236]
#define M_lnkGA parms[237]
#define M_kGA_syn parms[238]
#define M_lnkGA_syn parms[239]
#define M_CYP_Km parms[240]
#define M_lnCYP_Km parms[241]
#define M_CYP_VmaxC parms[242]
#define M_lnCYP_VmaxC parms[243]
#define M_UGT_Km parms[244]
#define M_lnUGT_Km parms[245]
#define M_UGT_VmaxC parms[246]
#define M_lnUGT_VmaxC parms[247]
#define M_UGT_Km_GA parms[248]
#define M_lnUGT_Km_GA parms[249]
#define M_UGT_Ki parms[250]
#define M_lnUGT_Ki parms[251]
#define M_Vmax_AG parms[252]
#define M_lnVmax_AG parms[253]
#define M_Km_AG parms[254]
#define M_lnKm_AG parms[255]
#define M_SULT_Km_apap parms[256]
#define M_lnSULT_Km_apap parms[257]
#define M_SULT_Km_paps parms[258]
#define M_lnSULT_Km_paps parms[259]
#define M_SULT_Ki parms[260]
#define M_lnSULT_Ki parms[261]
#define M_SULT_VmaxC parms[262]
#define M_lnSULT_VmaxC parms[263]
#define M_Vmax_AS parms[264]
#define M_lnVmax_AS parms[265]
#define M_Km_AS parms[266]
#define M_lnKm_AS parms[267]
#define Var_BW parms[268]
#define Var_lnBW parms[269]
#define Var_fa parms[270]
#define Var_lnfa parms[271]
#define Var_kSG_Vm parms[272]
#define Var_lnkSG_Vm parms[273]
#define Var_kSG_Km parms[274]
#define Var_lnkSG_Km parms[275]
#define Var_Tg parms[276]
#define Var_lnTg parms[277]
#define Var_Tp parms[278]
#define Var_lnTp parms[279]
#define Var_CLC_APAP parms[280]
#define Var_lnCLC_APAP parms[281]
#define Var_CLC_AS parms[282]
#define Var_lnCLC_AS parms[283]
#define Var_CLC_AG parms[284]
#define Var_lnCLC_AG parms[285]
#define Var_BP_APAP parms[286]
#define Var_lnBP_APAP parms[287]
#define Var_PF_APAP parms[288]
#define Var_lnPF_APAP parms[289]
#define Var_PG_APAP parms[290]
#define Var_lnPG_APAP parms[291]
#define Var_PK_APAP parms[292]
#define Var_lnPK_APAP parms[293]
#define Var_PL_APAP parms[294]
#define Var_lnPL_APAP parms[295]
#define Var_PM_APAP parms[296]
#define Var_lnPM_APAP parms[297]
#define Var_PR_APAP parms[298]
#define Var_lnPR_APAP parms[299]
#define Var_PS_APAP parms[300]
#define Var_lnPS_APAP parms[301]
#define Var_PK_AS parms[302]
#define Var_lnPK_AS parms[303]
#define Var_PF_AS parms[304]
#define Var_lnPF_AS parms[305]
#define Var_PL_AS parms[306]
#define Var_lnPL_AS parms[307]
#define Var_PG_AS parms[308]
#define Var_lnPG_AS parms[309]
#define Var_PM_AS parms[310]
#define Var_lnPM_AS parms[311]
#define Var_PR_AS parms[312]
#define Var_lnPR_AS parms[313]
#define Var_PS_AS parms[314]
#define Var_lnPS_AS parms[315]
#define Var_PK_AG parms[316]
#define Var_lnPK_AG parms[317]
#define Var_PF_AG parms[318]
#define Var_lnPF_AG parms[319]
#define Var_PL_AG parms[320]
#define Var_lnPL_AG parms[321]
#define Var_PG_AG parms[322]
#define Var_lnPG_AG parms[323]
#define Var_PM_AG parms[324]
#define Var_lnPM_AG parms[325]
#define Var_PR_AG parms[326]
#define Var_lnPR_AG parms[327]
#define Var_PS_AG parms[328]
#define Var_lnPS_AG parms[329]
#define Var_kPAPS parms[330]
#define Var_lnkPAPS parms[331]
#define Var_kPAPS_syn parms[332]
#define Var_lnkPAPS_syn parms[333]
#define Var_kGA parms[334]
#define Var_lnkGA parms[335]
#define Var_kGA_syn parms[336]
#define Var_lnkGA_syn parms[337]
#define Var_CYP_Km parms[338]
#define Var_lnCYP_Km parms[339]
#define Var_CYP_VmaxC parms[340]
#define Var_lnCYP_VmaxC parms[341]
#define Var_UGT_Km parms[342]
#define Var_lnUGT_Km parms[343]
#define Var_UGT_VmaxC parms[344]
#define Var_lnUGT_VmaxC parms[345]
#define Var_UGT_Km_GA parms[346]
#define Var_lnUGT_Km_GA parms[347]
#define Var_UGT_Ki parms[348]
#define Var_lnUGT_Ki parms[349]
#define Var_Vmax_AG parms[350]
#define Var_lnVmax_AG parms[351]
#define Var_Km_AG parms[352]
#define Var_lnKm_AG parms[353]
#define Var_SULT_KVar_apap parms[354]
#define Var_lnSULT_Km_apap parms[355]
#define Var_SULT_KVar_paps parms[356]
#define Var_lnSULT_Km_paps parms[357]
#define Var_SULT_Ki parms[358]
#define Var_lnSULT_Ki parms[359]
#define Var_SULT_VmaxC parms[360]
#define Var_lnSULT_VmaxC parms[361]
#define Var_Vmax_AS parms[362]
#define Var_lnVmax_AS parms[363]
#define Var_Km_AS parms[364]
#define Var_lnKm_AS parms[365]
#define Verr_CPL_APAP_mcmolL parms[366]
#define Verr_CPL_APAP_mcgL parms[367]
#define Verr_CPL_AG_mcmolL parms[368]
#define Verr_CPL_AG_mcgL parms[369]
#define Verr_CPL_AS_mcmolL parms[370]
#define Verr_CPL_AS_mcgL parms[371]
#define Verr_CU_APAP_mcg parms[372]
#define Verr_CU_AG_mcg parms[373]
#define Verr_CU_AS_mcg parms[374]

/* Forcing (Input) functions */
static double forc[2];

#define OralExp_APAP forc[0]
#define IVExp_APAP forc[1]

/* Function definitions for delay differential equations */

int Nout=1;
int nr[1]={0};
double ytau[1] = {0.0};

static double yini[44] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}; /*Array of initial state variables*/

void lagvalue(double T, int *nr, int N, double *ytau) {
  static void(*fun)(double, int*, int, double*) = NULL;
  if (fun == NULL)
    fun = (void(*)(double, int*, int, double*))R_GetCCallable("deSolve", "lagvalue");
  return fun(T, nr, N, ytau);
}

double CalcDelay(int hvar, double dTime, double delay) {
  double T = dTime-delay;
  if (dTime > delay){
    nr[0] = hvar;
    lagvalue( T, nr, Nout, ytau );
}
  else{
    ytau[0] = yini[hvar];
}
  return(ytau[0]);
}

/*----- Initializers */
void initmod (void (* odeparms)(int *, double *))
{
  int N=375;
  odeparms(&N, parms);
}

void initforc (void (* odeforcs)(int *, double *))
{
  int N=2;
  odeforcs(&N, forc);
}


/* Calling R code will ensure that input y has same
   dimension as yini */
void initState (double *y)
{
  int i;

  for (i = 0; i < sizeof(yini) / sizeof(yini[0]); i++)
  {
    yini[i] = y[i];
  }
}

void getParms (double *inParms, double *out, int *nout) {
/*----- Model scaling */

  int i;

  for (i = 0; i < *nout; i++) {
    parms[i] = inParms[i];
  }


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

  for (i = 0; i < *nout; i++) {
    out[i] = parms[i];
  }
  }
/*----- Dynamics section */

void derivs (int *neq, double *pdTime, double *y, double *ydot, double *yout, int *ip)
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

  yout[ID_CF_APAP] = y[ID_AF_APAP] / VF ;

  CVF_APAP = yout[ID_CF_APAP] / PF_APAP ;

  yout[ID_CK_APAP] = y[ID_AK_APAP] / VK ;

  CVK_APAP = yout[ID_CK_APAP] / PK_APAP ;

  CM_APAP = y[ID_AM_APAP] / VM ;

  CVM_APAP = CM_APAP / PM_APAP ;

  yout[ID_CL_APAP] = y[ID_AL_APAP] / VL ;

  CVL_APAP = yout[ID_CL_APAP] / PL_APAP ;

  yout[ID_CR_APAP] = y[ID_AR_APAP] / VR ;

  CVR_APAP = yout[ID_CR_APAP] / PR_APAP ;

  yout[ID_CS_APAP] = y[ID_AS_APAP] / VS ;

  CVS_APAP = yout[ID_CS_APAP] / PS_APAP ;

  yout[ID_CF_AS] = y[ID_AF_AS] / VF ;

  CVF_AS = yout[ID_CF_AS] / PF_AS ;

  yout[ID_CK_AS] = y[ID_AK_AS] / VK ;

  CVK_AS = yout[ID_CK_AS] / PK_AS ;

  yout[ID_CL_AS] = y[ID_AL_AS] / VL ;

  CVL_AS = yout[ID_CL_AS] / PL_AS ;

  CM_AS = y[ID_AM_AS] / VM ;

  CVM_AS = CM_AS / PM_AS ;

  yout[ID_CR_AS] = y[ID_AR_AS] / VR ;

  CVR_AS = yout[ID_CR_AS] / PR_AS ;

  yout[ID_CS_AS] = y[ID_AS_AS] / VS ;

  CVS_AS = yout[ID_CS_AS] / PS_AS ;

  yout[ID_CF_AG] = y[ID_AF_AG] / VF ;

  CVF_AG = yout[ID_CF_AG] / PF_AG ;

  yout[ID_CK_AG] = y[ID_AK_AG] / VK ;

  CVK_AG = yout[ID_CK_AG] / PK_AG ;

  yout[ID_CL_AG] = y[ID_AL_AG] / VL ;

  CVL_AG = yout[ID_CL_AG] / PL_AG ;

  CM_AG = y[ID_AM_AG] / VM ;

  CVM_AG = CM_AG / PM_AG ;

  yout[ID_CR_AG] = y[ID_AR_AG] / VR ;

  CVR_AG = yout[ID_CR_AG] / PR_AG ;

  yout[ID_CS_AG] = y[ID_AS_AG] / VS ;

  CVS_AG = yout[ID_CS_AG] / PS_AG ;

  yout[ID_CA_APAP] = y[ID_ABLA_APAP] / VBLV ;

  yout[ID_CV_APAP] = y[ID_ABLV_APAP] / VBLA ;

  yout[ID_CPL_APAP] = yout[ID_CV_APAP] / BP_APAP ;

  yout[ID_CA_AS] = y[ID_ABLA_AS] / VBLA ;

  yout[ID_CV_AS] = y[ID_ABLV_AS] / VBLV ;

  yout[ID_CPL_AS] = yout[ID_CV_AS] / BP_APAP ;

  yout[ID_CA_AG] = y[ID_ABLA_AG] / VBLA ;

  yout[ID_CV_AG] = y[ID_ABLV_AG] / VBLV ;

  yout[ID_CPL_AG] = yout[ID_CV_AG] / BP_APAP ;

  ydot[ID_CL_APAP_to_NAPQI_CYP] = CYP_Vmax * yout[ID_CL_APAP] / ( CYP_Km + yout[ID_CL_APAP] ) ;

  ydot[ID_CL_APAP_to_AS_SULT] = SULT_Vmax * ( yout[ID_CL_APAP] ) * ( y[ID_AL_PAPS] ) / ( ( SULT_Km_apap + yout[ID_CL_APAP] + pow ( yout[ID_CL_APAP] , 2 ) / SULT_Ki ) * ( SULT_Km_paps + y[ID_AL_PAPS] ) ) ;

  ydot[ID_CL_APAP_to_AG_UGT] = UGT_Vmax * ( yout[ID_CL_APAP] ) * ( y[ID_AL_GA] ) / ( ( UGT_Km + yout[ID_CL_APAP] + pow ( yout[ID_CL_APAP] , 2 ) / UGT_Ki ) * ( UGT_Km_GA + y[ID_AL_GA] ) ) ;

  ydot[ID_AL_PAPS] = - ydot[ID_CL_APAP_to_AS_SULT] + kPAPS_syn * ( 1 - y[ID_AL_PAPS] ) ;

  ydot[ID_AL_GA] = - ydot[ID_CL_APAP_to_AG_UGT] + kGA_syn * ( 1 - y[ID_AL_GA] ) ;

  ydot[ID_AST_Oral_APAP] = OralExp_APAP * ODose_APAP ;

  ydot[ID_AST_to_Gut_APAP] = true_dose * ( exp ( - (*pdTime) / Tg ) - exp ( - (*pdTime) / Tp ) ) / ( Tg - Tp ) ;

  ydot[ID_AST_APAP] = ydot[ID_AST_Oral_APAP] - ydot[ID_AST_to_Gut_APAP] ;

  ydot[ID_AL_APAP] = QL * yout[ID_CA_APAP] + ydot[ID_AST_to_Gut_APAP] - QL * CVL_APAP - ydot[ID_CL_APAP_to_NAPQI_CYP] - ydot[ID_CL_APAP_to_AS_SULT] - ydot[ID_CL_APAP_to_AG_UGT] ;

  ydot[ID_pct_abs] = ydot[ID_AST_to_Gut_APAP] / true_dose ;

  ydot[ID_ABL_IV_APAP] = IVExp_APAP * IVDR_APAP ;

  ydot[ID_ABLV_APAP] = QF * CVF_APAP + QM * CVM_APAP + QK * CVK_APAP + QL * CVL_APAP + QR * CVR_APAP + QS * CVS_APAP - QC * yout[ID_CV_APAP] + ydot[ID_ABL_IV_APAP] ;

  ydot[ID_ABLA_APAP] = QC * ( yout[ID_CV_APAP] - yout[ID_CA_APAP] ) ;

  ydot[ID_AF_APAP] = QF * ( yout[ID_CA_APAP] - CVF_APAP ) ;

  ydot[ID_AM_APAP] = QM * ( yout[ID_CA_APAP] - CVM_APAP ) ;

  ydot[ID_AKE_APAP] = CLR_APAP * yout[ID_CA_APAP] ;

  ydot[ID_AK_APAP] = QK * ( yout[ID_CA_APAP] - CVK_APAP ) - ydot[ID_AKE_APAP] ;

  ydot[ID_AR_APAP] = QR * ( yout[ID_CA_APAP] - CVR_APAP ) ;

  ydot[ID_AS_APAP] = QS * ( yout[ID_CA_APAP] - CVS_APAP ) ;

  ydot[ID_AU_APAP] = ydot[ID_AKE_APAP] ;

  ydot[ID_CH_AS_to_CL_AS] = Vmax_AS * y[ID_CH_AS] / ( Km_AS + y[ID_CH_AS] ) ;

  ydot[ID_CH_AS] = ydot[ID_CL_APAP_to_AS_SULT] - ydot[ID_CH_AS_to_CL_AS] ;

  ydot[ID_AL_AS] = QL * ( yout[ID_CA_AS] - CVL_AS ) + ydot[ID_CH_AS_to_CL_AS] ;

  ydot[ID_AF_AS] = QF * ( yout[ID_CA_AS] - CVF_AS ) ;

  ydot[ID_AM_AS] = QM * ( yout[ID_CA_AS] - CVM_AS ) ;

  ydot[ID_AR_AS] = QR * ( yout[ID_CA_AS] - CVR_AS ) ;

  ydot[ID_AS_AS] = QS * ( yout[ID_CA_AS] - CVS_AS ) ;

  ydot[ID_ABLV_AS] = QK * CVK_AS + QL * CVL_AS + QF * CVF_AS + QM * CVM_AS + QR * CVR_AS + QS * CVS_AS - QC * yout[ID_CV_AS] ;

  ydot[ID_ABLA_AS] = QC * ( yout[ID_CV_AS] - yout[ID_CA_AS] ) ;

  ydot[ID_AKE_AS] = CLR_AS * yout[ID_CA_AS] ;

  ydot[ID_AK_AS] = QK * ( yout[ID_CA_AS] - CVK_AS ) - ydot[ID_AKE_AS] ;

  ydot[ID_AU_AS] = ydot[ID_AKE_AS] ;

  ydot[ID_CH_AG_to_CL_AG] = Vmax_AG * y[ID_CH_AG] / ( Km_AG + y[ID_CH_AG] ) ;

  ydot[ID_CH_AG] = ydot[ID_CL_APAP_to_AG_UGT] - ydot[ID_CH_AG_to_CL_AG] ;

  ydot[ID_AL_AG] = QL * ( yout[ID_CA_AG] - CVL_AG ) + ydot[ID_CH_AG_to_CL_AG] ;

  ydot[ID_AF_AG] = QF * ( yout[ID_CA_AG] - CVF_AG ) ;

  ydot[ID_AM_AG] = QM * ( yout[ID_CA_AG] - CVM_AG ) ;

  ydot[ID_AR_AG] = QR * ( yout[ID_CA_AG] - CVR_AG ) ;

  ydot[ID_AS_AG] = QS * ( yout[ID_CA_AG] - CVS_AG ) ;

  ydot[ID_ABLV_AG] = QK * CVK_AG + QL * CVL_AG + QF * CVF_AG + QM * CVM_AG + QR * CVR_AG + QS * CVS_AG - QC * yout[ID_CV_AG] ;

  ydot[ID_ABLA_AG] = QC * ( yout[ID_CV_AG] - yout[ID_CA_AG] ) ;

  ydot[ID_AKE_AG] = CLR_AG * yout[ID_CA_AG] ;

  ydot[ID_AK_AG] = QK * ( yout[ID_CA_AG] - CVK_AG ) - ydot[ID_AKE_AG] ;

  ydot[ID_AU_AG] = ydot[ID_AKE_AG] ;

  yout[ID_CPL_APAP_mcmolL] = yout[ID_CPL_APAP] ;

  yout[ID_CPL_APAP_mcgL] = yout[ID_CPL_APAP] * MW_APAP ;
  yout[ID_CPL_AG_mcmolL] = yout[ID_CPL_AG] ;

  yout[ID_CPL_AG_mcgL] = yout[ID_CPL_AG] * MW_AG ;
  yout[ID_CPL_AS_mcmolL] = yout[ID_CPL_AS] ;

  yout[ID_CPL_AS_mcgL] = yout[ID_CPL_AS] * MW_AS ;
  yout[ID_CL_APAP_mcmolL] = yout[ID_CL_APAP] ;

  yout[ID_CL_APAP_mcgL] = yout[ID_CL_APAP] * MW_APAP ;

  yout[ID_CU_APAP_mcg] = y[ID_AU_APAP] * MW_APAP ;
  yout[ID_CU_AG_mcg] = y[ID_AU_AG] * MW_AG ;
  yout[ID_CU_AS_mcg] = y[ID_AU_AS] * MW_AS ;
  yout[ID_f_abs] = y[ID_AST_to_Gut_APAP] / true_dose ;
  yout[ID_lntrue_dose] = log ( true_dose ) ;
  yout[ID_lnODose_APAP] = log ( ODose_APAP ) ;
  yout[ID_lnfa] = log ( fa ) ;

  yout[ID_lnCPL_APAP_mcgL] = ( yout[ID_CPL_APAP_mcgL] > 0 ? log ( yout[ID_CPL_APAP_mcgL] ) : -20. ) ;
  yout[ID_lnCPL_AG_mcgL] = ( yout[ID_CPL_AG_mcgL] > 0 ? log ( yout[ID_CPL_AG_mcgL] ) : -20. ) ;
  yout[ID_lnCPL_AS_mcgL] = ( yout[ID_CPL_AS_mcgL] > 0 ? log ( yout[ID_CPL_AS_mcgL] ) : -20. ) ;
  yout[ID_lnCU_APAP_mcg] = ( yout[ID_CU_APAP_mcg] > 0 ? log ( yout[ID_CU_APAP_mcg] ) : -20. ) ;
  yout[ID_lnCU_AG_mcg] = ( yout[ID_CU_AG_mcg] > 0 ? log ( yout[ID_CU_AG_mcg] ) : -20. ) ;
  yout[ID_lnCU_AS_mcg] = ( yout[ID_CU_AS_mcg] > 0 ? log ( yout[ID_CU_AS_mcg] ) : -20. ) ;
  yout[ID_lnf_abs] = ( yout[ID_f_abs] > 0 ? log ( yout[ID_f_abs] ) : -20 ) ;

  yout[ID_Verr_lnCPL_APAP_mcmolL] = yout[ID_Verr_lnCPL_APAP_mcmolL] ;
  yout[ID_Verr_lnCPL_APAP_mcgL] = yout[ID_Verr_lnCPL_APAP_mcgL] ;
  yout[ID_Verr_lnCPL_AG_mcmolL] = yout[ID_Verr_lnCPL_AG_mcmolL] ;
  yout[ID_Verr_lnCPL_AG_mcgL] = yout[ID_Verr_lnCPL_AG_mcgL] ;
  yout[ID_Verr_lnCPL_AS_mcmolL] = yout[ID_Verr_lnCPL_AS_mcmolL] ;
  yout[ID_Verr_lnCPL_AS_mcgL] = yout[ID_Verr_lnCPL_AS_mcgL] ;

  yout[ID_Verr_lnCU_APAP_mcg] = yout[ID_Verr_lnCU_APAP_mcg] ;
  yout[ID_Verr_lnCU_AG_mcg] = yout[ID_Verr_lnCU_AG_mcg] ;
  yout[ID_Verr_lnCU_AS_mcg] = yout[ID_Verr_lnCU_AS_mcg] ;

} /* derivs */


/*----- Jacobian calculations: */
void jac (int *neq, double *t, double *y, int *ml, int *mu, double *pd, int *nrowpd, double *yout, int *ip)
{

} /* jac */


/*----- Events calculations: */
void event (int *n, double *t, double *y)
{

} /* event */

/*----- Roots calculations: */
void root (int *neq, double *t, double *y, int *ng, double *gout, double *out, int *ip)
{

} /* root */

