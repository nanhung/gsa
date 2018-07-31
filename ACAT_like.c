/* ACAT_like.c for R deSolve package
   ___________________________________________________

   Model File:  ACAT_like.model

   Date:  Tue Jul 31 13:34:37 2018

   Created by:  "mod v5.6.6"
    -- a model preprocessor by Don Maszle
   ___________________________________________________

   Copyright (c) 1993-2017 Free Software Foundation, Inc.

   Model calculations for compartmental model:

   42 States:
     A_kid = 0.0,
     A_rpt = 0.0,
     A_liver = 0.0,
     A_adip = 0.0,
     A_ppt = 0.0,
     A_blood = 0.0,
     A_stom_lu = 0.0,
     A_duod_lu = 0.0,
     A_jeju_lu = 0.0,
     A_ileon_lu = 0.0,
     A_cecum_lu = 0.0,
     A_colon_lu = 0.0,
     A_stom_ep = 0.0,
     A_duod_ep = 0.0,
     A_jeju_ep = 0.0,
     A_ileon_ep = 0.0,
     A_cecum_ep = 0.0,
     A_colon_ep = 0.0,
     A_stom_w = 0.0,
     A_duod_w = 0.0,
     A_jeju_w = 0.0,
     A_ileon_w = 0.0,
     A_cecum_w = 0.0,
     A_colon_w = 0.0,
     A_absorb_stom = 0.0,
     A_absorb_duod = 0.0,
     A_absorb_jeju = 0.0,
     A_absorb_ileon = 0.0,
     A_absorb_cecum = 0.0,
     A_absorb_colon = 0.0,
     A_absorb_pv = 0.0,
     A_elim_kid = 0.0,
     A_met_liver = 0.0,
     A_met_stom = 0.0,
     A_met_duod = 0.0,
     A_met_jeju = 0.0,
     A_met_ileon = 0.0,
     A_met_cecum = 0.0,
     A_met_colon = 0.0,
     A_feces = 0.0,
     AUC_blood = 0.0,
     AUC_liver = 0.0,

   34 Outputs:
    "C_plasma",
    "C_kid",
    "C_rpt",
    "C_liver",
    "C_adip",
    "C_ppt",
    "C_blood",
    "C_stom_lu",
    "C_duod_lu",
    "C_jeju_lu",
    "C_ileon_lu",
    "C_cecum_lu",
    "C_colon_lu",
    "C_stom_ep",
    "C_duod_ep",
    "C_jeju_ep",
    "C_ileon_ep",
    "C_cecum_ep",
    "C_colon_ep",
    "C_stom_w",
    "C_duod_w",
    "C_jeju_w",
    "C_ileon_w",
    "C_cecum_w",
    "C_colon_w",
    "A_gi_lu",
    "A_gi_ep",
    "A_gi_w",
    "A_absorb",
    "A_elim",
    "A_elim_gi",
    "A_organ",
    "A_total",
    "Instant_Ka_gi",

   1 Input:
     Oral_dose_rate (forcing function)

   167 Parameters:
     InDose = 0.0,
     Tlag = 0.0,
     Period = 0.0,
     Exposure = 0.0,
     BDM = 0,
     sc_F_total = 15,
     f_Flow_adip = 0.06,
     f_Flow_kid = 0.21,
     f_Flow_ppt = 0.20,
     f_Flow_liver_art = 0.077,
     f_Flow_stom = 0.024,
     f_Flow_duod = 0.016,
     f_Flow_jeju = 0.056,
     f_Flow_ileon = 0.033,
     f_Flow_cecum = 0.006,
     f_Flow_colon = 0.038,
     f_BDM_adip = 0.16,
     f_BDM_blood = 0.065,
     f_BDM_kid = 0.0096,
     f_BDM_rpt = 0.1,
     f_BDM_liver = 0.0243,
     f_BDM_stom = 0.0021,
     f_BDM_duod = 0.0003,
     f_BDM_jeju = 0.0009,
     f_BDM_ileon = 0.0006,
     f_BDM_cecum = 0.0005,
     f_BDM_colon = 0.0048,
     f_BDM_stom_lu = 0.0036,
     f_BDM_duod_lu = 0.0003,
     f_BDM_jeju_lu = 0.0023,
     f_BDM_ileon_lu = 0.0032,
     f_BDM_cecum_lu = 0.0001,
     f_BDM_colon_lu = 0.0051,
     Length_stom = 2.5,
     Length_duod = 2.5,
     Length_jeju = 20,
     Length_ileon = 30,
     Length_cecum = 1.7,
     Length_colon = 12.5,
     Radius_stom = 0.85,
     Radius_duod = 0.2,
     Radius_jeju = 0.18,
     Radius_ileon = 0.15,
     Radius_cecum = 0.35,
     Radius_colon = 0.25,
     T12_stom_lu = 0.25,
     T12_duod_lu = 0.25,
     T12_jeju_lu = 1.02,
     T12_ileon_lu = 2.04,
     T12_cecum_lu = 4.55,
     T12_colon_lu = 13.5,
     PH_stom = 1.7,
     PH_duod = 6,
     PH_jeju = 6.5,
     PH_ileon = 7.4,
     PH_cecum = 5.9,
     PH_colon = 7,
     MicroProt_liver = 45,
     MicroProt_stom = 0,
     MicroProt_duod = 9.45,
     MicroProt_jeju = 8.82,
     MicroProt_ileon = 1.62,
     MicroProt_cecum = 0.0,
     MicroProt_colon = 0.0,
     V_ep = 5.25E-4,
     MM = 0,
     f_Abs_stom = 0,
     f_Abs_duod = 0,
     f_Abs_jeju = 0,
     f_Abs_ileon = 0,
     f_Abs_cecum = 0,
     f_Abs_colon = 0,
     Peff = 0,
     Ratio_BP = 0,
     PC_adip = 0,
     PC_rpt = 0,
     PC_ppt = 0,
     PC_kid = 0,
     PC_liver = 0,
     PC_stom = 0,
     PC_duod = 0,
     PC_jeju = 0,
     PC_ileon = 0,
     PC_cecum = 0,
     PC_colon = 0,
     Fu_adip = 1.0,
     Fu_kid = 1.0,
     Fu_ppt = 1.0,
     Fu_rpt = 1.0,
     Fu_blood = 1.0,
     Fu_liver = 1.0,
     Fu_portvein = 1.0,
     Fu_stom = 1.0,
     Fu_duod = 1.0,
     Fu_jeju = 1.0,
     Fu_ileon = 1.0,
     Fu_cecum = 1.0,
     Fu_colon = 1.0,
     Fu_plasma = 1.0,
     Vmax_vitro = 0,
     Km_vitro = 0,
     Kle_kid = 0,
     F_total = 0,
     f_Flow_portvein = 0,
     V_adip = 0,
     V_blood = 0,
     V_kid = 0,
     V_liver = 0,
     V_rpt = 0,
     V_ppt = 0,
     V_stom = 0,
     V_duod = 0,
     V_jeju = 0,
     V_ileon = 0,
     V_cecum = 0,
     V_colon = 0,
     V_stom_w = 0,
     V_duod_w = 0,
     V_jeju_w = 0,
     V_ileon_w = 0,
     V_cecum_w = 0,
     V_colon_w = 0,
     V_stom_lu = 0,
     V_colon_lu = 0,
     V_duod_lu = 0,
     V_jeju_lu = 0,
     V_ileon_lu = 0,
     V_cecum_lu = 0,
     V_stom_ep = 0,
     V_duod_ep = 0,
     V_jeju_ep = 0,
     V_ileon_ep = 0,
     V_cecum_ep = 0,
     V_colon_ep = 0,
     SA_stom = 0,
     SA_duod = 0,
     SA_jeju = 0,
     SA_ileon = 0,
     SA_cecum = 0,
     SA_colon = 0,
     Flow_adip = 0,
     Flow_kid = 0,
     Flow_liver = 0,
     Flow_liver_art = 0,
     Flow_rpt = 0,
     Flow_ppt = 0,
     Flow_portvein = 0,
     Flow_stom = 0,
     Flow_duod = 0,
     Flow_jeju = 0,
     Flow_ileon = 0,
     Flow_cecum = 0,
     Flow_colon = 0,
     Kle_stom = 0,
     Kle_duod = 0,
     Kle_jeju = 0,
     Kle_ileon = 0,
     Kle_cecum = 0,
     Kle_colon = 0,
     Vmax_vivo_liver = 0,
     Vmax_vivo_stom = 0,
     Vmax_vivo_duod = 0,
     Vmax_vivo_jeju = 0,
     Vmax_vivo_ileon = 0,
     Vmax_vivo_cecum = 0,
     Vmax_vivo_colon = 0,
     Km_vivo = 0,
*/

#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>
#include <R_ext/Rdynload.h>

/* Model variables: States */
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

/* Model variables: Outputs */
#define ID_C_plasma 0x00000
#define ID_C_kid 0x00001
#define ID_C_rpt 0x00002
#define ID_C_liver 0x00003
#define ID_C_adip 0x00004
#define ID_C_ppt 0x00005
#define ID_C_blood 0x00006
#define ID_C_stom_lu 0x00007
#define ID_C_duod_lu 0x00008
#define ID_C_jeju_lu 0x00009
#define ID_C_ileon_lu 0x0000a
#define ID_C_cecum_lu 0x0000b
#define ID_C_colon_lu 0x0000c
#define ID_C_stom_ep 0x0000d
#define ID_C_duod_ep 0x0000e
#define ID_C_jeju_ep 0x0000f
#define ID_C_ileon_ep 0x00010
#define ID_C_cecum_ep 0x00011
#define ID_C_colon_ep 0x00012
#define ID_C_stom_w 0x00013
#define ID_C_duod_w 0x00014
#define ID_C_jeju_w 0x00015
#define ID_C_ileon_w 0x00016
#define ID_C_cecum_w 0x00017
#define ID_C_colon_w 0x00018
#define ID_A_gi_lu 0x00019
#define ID_A_gi_ep 0x0001a
#define ID_A_gi_w 0x0001b
#define ID_A_absorb 0x0001c
#define ID_A_elim 0x0001d
#define ID_A_elim_gi 0x0001e
#define ID_A_organ 0x0001f
#define ID_A_total 0x00020
#define ID_Instant_Ka_gi 0x00021

/* Parameters */
static double parms[167];

#define InDose parms[0]
#define Tlag parms[1]
#define Period parms[2]
#define Exposure parms[3]
#define BDM parms[4]
#define sc_F_total parms[5]
#define f_Flow_adip parms[6]
#define f_Flow_kid parms[7]
#define f_Flow_ppt parms[8]
#define f_Flow_liver_art parms[9]
#define f_Flow_stom parms[10]
#define f_Flow_duod parms[11]
#define f_Flow_jeju parms[12]
#define f_Flow_ileon parms[13]
#define f_Flow_cecum parms[14]
#define f_Flow_colon parms[15]
#define f_BDM_adip parms[16]
#define f_BDM_blood parms[17]
#define f_BDM_kid parms[18]
#define f_BDM_rpt parms[19]
#define f_BDM_liver parms[20]
#define f_BDM_stom parms[21]
#define f_BDM_duod parms[22]
#define f_BDM_jeju parms[23]
#define f_BDM_ileon parms[24]
#define f_BDM_cecum parms[25]
#define f_BDM_colon parms[26]
#define f_BDM_stom_lu parms[27]
#define f_BDM_duod_lu parms[28]
#define f_BDM_jeju_lu parms[29]
#define f_BDM_ileon_lu parms[30]
#define f_BDM_cecum_lu parms[31]
#define f_BDM_colon_lu parms[32]
#define Length_stom parms[33]
#define Length_duod parms[34]
#define Length_jeju parms[35]
#define Length_ileon parms[36]
#define Length_cecum parms[37]
#define Length_colon parms[38]
#define Radius_stom parms[39]
#define Radius_duod parms[40]
#define Radius_jeju parms[41]
#define Radius_ileon parms[42]
#define Radius_cecum parms[43]
#define Radius_colon parms[44]
#define T12_stom_lu parms[45]
#define T12_duod_lu parms[46]
#define T12_jeju_lu parms[47]
#define T12_ileon_lu parms[48]
#define T12_cecum_lu parms[49]
#define T12_colon_lu parms[50]
#define PH_stom parms[51]
#define PH_duod parms[52]
#define PH_jeju parms[53]
#define PH_ileon parms[54]
#define PH_cecum parms[55]
#define PH_colon parms[56]
#define MicroProt_liver parms[57]
#define MicroProt_stom parms[58]
#define MicroProt_duod parms[59]
#define MicroProt_jeju parms[60]
#define MicroProt_ileon parms[61]
#define MicroProt_cecum parms[62]
#define MicroProt_colon parms[63]
#define V_ep parms[64]
#define MM parms[65]
#define f_Abs_stom parms[66]
#define f_Abs_duod parms[67]
#define f_Abs_jeju parms[68]
#define f_Abs_ileon parms[69]
#define f_Abs_cecum parms[70]
#define f_Abs_colon parms[71]
#define Peff parms[72]
#define Ratio_BP parms[73]
#define PC_adip parms[74]
#define PC_rpt parms[75]
#define PC_ppt parms[76]
#define PC_kid parms[77]
#define PC_liver parms[78]
#define PC_stom parms[79]
#define PC_duod parms[80]
#define PC_jeju parms[81]
#define PC_ileon parms[82]
#define PC_cecum parms[83]
#define PC_colon parms[84]
#define Fu_adip parms[85]
#define Fu_kid parms[86]
#define Fu_ppt parms[87]
#define Fu_rpt parms[88]
#define Fu_blood parms[89]
#define Fu_liver parms[90]
#define Fu_portvein parms[91]
#define Fu_stom parms[92]
#define Fu_duod parms[93]
#define Fu_jeju parms[94]
#define Fu_ileon parms[95]
#define Fu_cecum parms[96]
#define Fu_colon parms[97]
#define Fu_plasma parms[98]
#define Vmax_vitro parms[99]
#define Km_vitro parms[100]
#define Kle_kid parms[101]
#define F_total parms[102]
#define f_Flow_portvein parms[103]
#define V_adip parms[104]
#define V_blood parms[105]
#define V_kid parms[106]
#define V_liver parms[107]
#define V_rpt parms[108]
#define V_ppt parms[109]
#define V_stom parms[110]
#define V_duod parms[111]
#define V_jeju parms[112]
#define V_ileon parms[113]
#define V_cecum parms[114]
#define V_colon parms[115]
#define V_stom_w parms[116]
#define V_duod_w parms[117]
#define V_jeju_w parms[118]
#define V_ileon_w parms[119]
#define V_cecum_w parms[120]
#define V_colon_w parms[121]
#define V_stom_lu parms[122]
#define V_colon_lu parms[123]
#define V_duod_lu parms[124]
#define V_jeju_lu parms[125]
#define V_ileon_lu parms[126]
#define V_cecum_lu parms[127]
#define V_stom_ep parms[128]
#define V_duod_ep parms[129]
#define V_jeju_ep parms[130]
#define V_ileon_ep parms[131]
#define V_cecum_ep parms[132]
#define V_colon_ep parms[133]
#define SA_stom parms[134]
#define SA_duod parms[135]
#define SA_jeju parms[136]
#define SA_ileon parms[137]
#define SA_cecum parms[138]
#define SA_colon parms[139]
#define Flow_adip parms[140]
#define Flow_kid parms[141]
#define Flow_liver parms[142]
#define Flow_liver_art parms[143]
#define Flow_rpt parms[144]
#define Flow_ppt parms[145]
#define Flow_portvein parms[146]
#define Flow_stom parms[147]
#define Flow_duod parms[148]
#define Flow_jeju parms[149]
#define Flow_ileon parms[150]
#define Flow_cecum parms[151]
#define Flow_colon parms[152]
#define Kle_stom parms[153]
#define Kle_duod parms[154]
#define Kle_jeju parms[155]
#define Kle_ileon parms[156]
#define Kle_cecum parms[157]
#define Kle_colon parms[158]
#define Vmax_vivo_liver parms[159]
#define Vmax_vivo_stom parms[160]
#define Vmax_vivo_duod parms[161]
#define Vmax_vivo_jeju parms[162]
#define Vmax_vivo_ileon parms[163]
#define Vmax_vivo_cecum parms[164]
#define Vmax_vivo_colon parms[165]
#define Km_vivo parms[166]

/* Forcing (Input) functions */
static double forc[1];

#define Oral_dose_rate forc[0]

/* Function definitions for delay differential equations */

int Nout=1;
int nr[1]={0};
double ytau[1] = {0.0};

static double yini[42] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}; /*Array of initial state variables*/

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
  int N=167;
  odeparms(&N, parms);
}

void initforc (void (* odeforcs)(int *, double *))
{
  int N=1;
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

  for (i = 0; i < *nout; i++) {
    out[i] = parms[i];
  }
  }
/*----- Dynamics section */

void derivs (int *neq, double *pdTime, double *y, double *ydot, double *yout, int *ip)
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

  yout[ID_C_adip] = y[ID_A_adip] / V_adip ;

  yout[ID_C_kid] = y[ID_A_kid] / V_kid ;

  yout[ID_C_rpt] = y[ID_A_rpt] / V_rpt ;

  yout[ID_C_ppt] = y[ID_A_ppt] / V_ppt ;

  yout[ID_C_liver] = y[ID_A_liver] / V_liver ;

  yout[ID_C_stom_w] = y[ID_A_stom_w] / V_stom_w ;

  yout[ID_C_duod_w] = y[ID_A_duod_w] / V_duod_w ;

  yout[ID_C_jeju_w] = y[ID_A_jeju_w] / V_jeju_w ;

  yout[ID_C_ileon_w] = y[ID_A_ileon_w] / V_ileon_w ;

  yout[ID_C_cecum_w] = y[ID_A_cecum_w] / V_cecum_w ;

  yout[ID_C_colon_w] = y[ID_A_colon_w] / V_colon_w ;

  yout[ID_C_blood] = y[ID_A_blood] / V_blood ;

  Ctb_kid = yout[ID_C_kid] / PC_kid ;

  Ctb_liver = yout[ID_C_liver] / PC_liver ;

  Ctb_rpt = yout[ID_C_rpt] / PC_rpt ;

  Ctb_ppt = yout[ID_C_ppt] / PC_ppt ;

  Ctb_adip = yout[ID_C_adip] / PC_adip ;

  Ctb_stom_w = yout[ID_C_stom_w] / PC_stom ;

  Ctb_duod_w = yout[ID_C_duod_w] / PC_duod ;

  Ctb_jeju_w = yout[ID_C_jeju_w] / PC_jeju ;

  Ctb_ileon_w = yout[ID_C_ileon_w] / PC_ileon ;

  Ctb_cecum_w = yout[ID_C_cecum_w] / PC_cecum ;

  Ctb_colon_w = yout[ID_C_colon_w] / PC_colon ;

  yout[ID_C_stom_lu] = y[ID_A_stom_lu] / V_stom_lu ;

  yout[ID_C_duod_lu] = y[ID_A_duod_lu] / V_duod_lu ;

  yout[ID_C_jeju_lu] = y[ID_A_jeju_lu] / V_jeju_lu ;

  yout[ID_C_ileon_lu] = y[ID_A_ileon_lu] / V_ileon_lu ;

  yout[ID_C_cecum_lu] = y[ID_A_cecum_lu] / V_cecum_lu ;

  yout[ID_C_colon_lu] = y[ID_A_colon_lu] / V_colon_lu ;

  yout[ID_C_stom_ep] = y[ID_A_stom_ep] / V_stom_ep ;

  yout[ID_C_duod_ep] = y[ID_A_duod_ep] / V_duod_ep ;

  yout[ID_C_jeju_ep] = y[ID_A_jeju_ep] / V_jeju_ep ;

  yout[ID_C_ileon_ep] = y[ID_A_ileon_ep] / V_ileon_ep ;

  yout[ID_C_cecum_ep] = y[ID_A_cecum_ep] / V_cecum_ep ;

  yout[ID_C_colon_ep] = y[ID_A_colon_ep] / V_colon_ep ;

  Rate_stl2dul = ( log ( 2.0 ) * V_stom_lu / T12_stom_lu ) * yout[ID_C_stom_lu] ;

  Rate_dul2jel = ( log ( 2.0 ) * V_duod_lu / T12_duod_lu ) * yout[ID_C_duod_lu] ;

  Rate_jel2ill = ( log ( 2.0 ) * V_jeju_lu / T12_jeju_lu ) * yout[ID_C_jeju_lu] ;

  Rate_ill2cel = ( log ( 2.0 ) * V_ileon_lu / T12_ileon_lu ) * yout[ID_C_ileon_lu] ;

  Rate_cel2col = ( log ( 2.0 ) * V_cecum_lu / T12_cecum_lu ) * yout[ID_C_cecum_lu] ;

  Rate_col2fel = ( log ( 2.0 ) * V_colon_lu / T12_colon_lu ) * yout[ID_C_colon_lu] ;

  Rate_stl2ste = Kle_stom * ( yout[ID_C_stom_lu] - yout[ID_C_stom_ep] ) ;

  Rate_dul2due = Kle_duod * ( yout[ID_C_duod_lu] - yout[ID_C_duod_ep] ) ;

  Rate_jel2jee = Kle_jeju * ( yout[ID_C_jeju_lu] - yout[ID_C_jeju_ep] ) ;

  Rate_ill2ile = Kle_ileon * ( yout[ID_C_ileon_lu] - yout[ID_C_ileon_ep] ) ;

  Rate_cel2cee = Kle_cecum * ( yout[ID_C_cecum_lu] - yout[ID_C_cecum_ep] ) ;

  Rate_col2coe = Kle_colon * ( yout[ID_C_colon_lu] - yout[ID_C_colon_ep] ) ;

  Rate_ste2stw = Kle_stom * ( yout[ID_C_stom_ep] - Ctb_stom_w ) ;

  Rate_due2duw = Kle_duod * ( yout[ID_C_duod_ep] - Ctb_duod_w ) ;

  Rate_jee2jew = Kle_jeju * ( yout[ID_C_jeju_ep] - Ctb_jeju_w ) ;

  Rate_ile2ilw = Kle_ileon * ( yout[ID_C_ileon_ep] - Ctb_ileon_w ) ;

  Rate_cee2cew = Kle_cecum * ( yout[ID_C_cecum_ep] - Ctb_cecum_w ) ;

  Rate_coe2cow = Kle_colon * ( yout[ID_C_colon_ep] - Ctb_colon_w ) ;

  Rate_stw2pv = Flow_stom * Ctb_stom_w ;

  Rate_duw2pv = Flow_duod * Ctb_duod_w ;

  Rate_jew2pv = Flow_jeju * Ctb_jeju_w ;

  Rate_ilw2pv = Flow_ileon * Ctb_ileon_w ;

  Rate_cew2pv = Flow_cecum * Ctb_cecum_w ;

  Rate_cow2pv = Flow_colon * Ctb_colon_w ;

  RateIn_portvein = Rate_stw2pv + Rate_duw2pv + Rate_jew2pv + Rate_ilw2pv + Rate_cew2pv + Rate_cow2pv ;

  Ctb_portvein = RateIn_portvein / Flow_portvein ;

  ydot[ID_A_absorb_stom] = Rate_stl2ste ;

  ydot[ID_A_absorb_duod] = Rate_dul2due ;

  ydot[ID_A_absorb_jeju] = Rate_jel2jee ;

  ydot[ID_A_absorb_ileon] = Rate_ill2ile ;

  ydot[ID_A_absorb_cecum] = Rate_cel2cee ;

  ydot[ID_A_absorb_colon] = Rate_col2coe ;

  ydot[ID_A_absorb_pv] = RateIn_portvein ;

  ydot[ID_A_elim_kid] = Kle_kid * Ctb_kid * Fu_kid ;

  ydot[ID_A_met_liver] = Vmax_vivo_liver * Ctb_liver / ( Km_vivo + Ctb_liver ) ;

  ydot[ID_A_met_stom] = Vmax_vivo_stom * yout[ID_C_stom_ep] / ( Km_vivo + yout[ID_C_stom_ep] ) ;

  ydot[ID_A_met_duod] = Vmax_vivo_duod * yout[ID_C_duod_ep] / ( Km_vivo + yout[ID_C_duod_ep] ) ;

  ydot[ID_A_met_jeju] = Vmax_vivo_jeju * yout[ID_C_jeju_ep] / ( Km_vivo + yout[ID_C_jeju_ep] ) ;

  ydot[ID_A_met_ileon] = Vmax_vivo_ileon * yout[ID_C_ileon_ep] / ( Km_vivo + yout[ID_C_ileon_ep] ) ;

  ydot[ID_A_met_cecum] = Vmax_vivo_cecum * yout[ID_C_cecum_ep] / ( Km_vivo + yout[ID_C_cecum_ep] ) ;

  ydot[ID_A_met_colon] = Vmax_vivo_colon * yout[ID_C_colon_ep] / ( Km_vivo + yout[ID_C_colon_ep] ) ;

  ydot[ID_A_feces] = Rate_col2fel ;

  ydot[ID_A_kid] = Flow_kid * ( yout[ID_C_blood] - Ctb_kid ) - ydot[ID_A_elim_kid] ;

  ydot[ID_A_adip] = Flow_adip * ( yout[ID_C_blood] - Ctb_adip ) ;

  ydot[ID_A_ppt] = Flow_ppt * ( yout[ID_C_blood] - Ctb_ppt ) ;

  ydot[ID_A_rpt] = Flow_rpt * ( yout[ID_C_blood] - Ctb_rpt ) ;

  ydot[ID_A_liver] = Flow_liver_art * yout[ID_C_blood] + Flow_portvein * Ctb_portvein - Flow_liver * Ctb_liver - ydot[ID_A_met_liver] ;

  ydot[ID_A_blood] = Flow_rpt * Ctb_rpt + Flow_ppt * Ctb_ppt + Flow_adip * Ctb_adip + Flow_liver * Ctb_liver + Flow_kid * Ctb_kid - F_total * yout[ID_C_blood] ;

  ydot[ID_A_stom_lu] = Oral_dose_rate - Rate_stl2dul - Rate_stl2ste ;

  ydot[ID_A_stom_ep] = Rate_stl2ste - Rate_ste2stw - ydot[ID_A_met_stom] ;

  ydot[ID_A_stom_w] = Flow_stom * yout[ID_C_blood] + Rate_ste2stw - Rate_stw2pv ;

  ydot[ID_A_duod_lu] = Rate_stl2dul - Rate_dul2jel - Rate_dul2due ;

  ydot[ID_A_duod_ep] = Rate_dul2due - Rate_due2duw - ydot[ID_A_met_duod] ;

  ydot[ID_A_duod_w] = Flow_duod * yout[ID_C_blood] + Rate_due2duw - Rate_duw2pv ;

  ydot[ID_A_jeju_lu] = Rate_dul2jel - Rate_jel2ill - Rate_jel2jee ;

  ydot[ID_A_jeju_ep] = Rate_jel2jee - Rate_jee2jew - ydot[ID_A_met_jeju] ;

  ydot[ID_A_jeju_w] = Flow_jeju * yout[ID_C_blood] + Rate_jee2jew - Rate_jew2pv ;

  ydot[ID_A_ileon_lu] = Rate_jel2ill - Rate_ill2cel - Rate_ill2ile ;

  ydot[ID_A_ileon_ep] = Rate_ill2ile - Rate_ile2ilw - ydot[ID_A_met_ileon] ;

  ydot[ID_A_ileon_w] = Flow_ileon * yout[ID_C_blood] + Rate_ile2ilw - Rate_ilw2pv ;

  ydot[ID_A_cecum_lu] = Rate_ill2cel - Rate_cel2col - Rate_cel2cee ;

  ydot[ID_A_cecum_ep] = Rate_cel2cee - Rate_cee2cew - ydot[ID_A_met_cecum] ;

  ydot[ID_A_cecum_w] = Flow_cecum * yout[ID_C_blood] + Rate_cee2cew - Rate_cew2pv ;

  ydot[ID_A_colon_lu] = Rate_cel2col - Rate_col2coe - ydot[ID_A_feces] ;

  ydot[ID_A_colon_ep] = Rate_col2coe - Rate_coe2cow - ydot[ID_A_met_colon] ;

  ydot[ID_A_colon_w] = Flow_colon * yout[ID_C_blood] + Rate_coe2cow - Rate_cow2pv ;

  ydot[ID_AUC_blood] = yout[ID_C_blood] ;

  ydot[ID_AUC_liver] = yout[ID_C_liver] ;

  yout[ID_C_plasma] = ( yout[ID_C_blood] > 0 ? yout[ID_C_blood] / Ratio_BP : 1E-10 ) ;

  yout[ID_A_gi_lu] = y[ID_A_stom_lu] + y[ID_A_duod_lu] + y[ID_A_jeju_lu] + y[ID_A_ileon_lu] + y[ID_A_cecum_lu] + y[ID_A_colon_lu] ;

  yout[ID_A_gi_ep] = y[ID_A_stom_ep] + y[ID_A_duod_ep] + y[ID_A_jeju_ep] + y[ID_A_ileon_ep] + y[ID_A_cecum_ep] + y[ID_A_colon_ep] ;

  yout[ID_A_gi_w] = y[ID_A_stom_w] + y[ID_A_duod_w] + y[ID_A_jeju_w] + y[ID_A_ileon_w] + y[ID_A_cecum_w] + y[ID_A_colon_w] ;

  yout[ID_A_absorb] = y[ID_A_absorb_stom] + y[ID_A_absorb_duod] + y[ID_A_absorb_jeju] + y[ID_A_absorb_ileon] + y[ID_A_absorb_cecum] + y[ID_A_absorb_colon] ;

  yout[ID_A_elim_gi] = y[ID_A_met_stom] + y[ID_A_met_duod] + y[ID_A_met_jeju] + y[ID_A_met_ileon] + y[ID_A_met_cecum] + y[ID_A_met_colon] + y[ID_A_feces] ;

  yout[ID_A_elim] = y[ID_A_elim_kid] + y[ID_A_met_liver] + yout[ID_A_elim_gi] ;

  yout[ID_A_organ] = y[ID_A_kid] + y[ID_A_rpt] + y[ID_A_liver] + y[ID_A_adip] + y[ID_A_ppt] + y[ID_A_blood] + yout[ID_A_gi_lu] + yout[ID_A_gi_ep] + yout[ID_A_gi_w] ;

  yout[ID_A_total] = yout[ID_A_organ] + yout[ID_A_elim] ;

  yout[ID_Instant_Ka_gi] = y[ID_A_absorb_pv] / yout[ID_A_gi_lu] ;

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

