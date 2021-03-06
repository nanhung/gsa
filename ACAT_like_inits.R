initParms <- function(newParms = NULL) {
  parms <- c(
    InDose = 0.0,
    Tlag = 0.0,
    Period = 0.0,
    Exposure = 0.0,
    BDM = 0.0,
    sc_F_total = 0.0,
    f_Flow_adip = 0.0,
    f_Flow_kid = 0.0,
    f_Flow_ppt = 0.0,
    f_Flow_liver_art = 0.0,
    f_Flow_stom = 0.0,
    f_Flow_duod = 0.0,
    f_Flow_jeju = 0.0,
    f_Flow_ileon = 0.0,
    f_Flow_cecum = 0.0,
    f_Flow_colon = 0.0,
    f_BDM_adip = 0.0,
    f_BDM_blood = 0.0,
    f_BDM_kid = 0.0,
    f_BDM_rpt = 0.0,
    f_BDM_liver = 0.0,
    f_BDM_stom = 0.0,
    f_BDM_duod = 0.0,
    f_BDM_jeju = 0.0,
    f_BDM_ileon = 0.0,
    f_BDM_cecum = 0.0,
    f_BDM_colon = 0.0,
    f_BDM_stom_lu = 0.0,
    f_BDM_duod_lu = 0.0,
    f_BDM_jeju_lu = 0.0,
    f_BDM_ileon_lu = 0.0,
    f_BDM_cecum_lu = 0.0,
    f_BDM_colon_lu = 0.0,
    Length_stom = 0.0,
    Length_duod = 0.0,
    Length_jeju = 0.0,
    Length_ileon = 0.0,
    Length_cecum = 0.0,
    Length_colon = 0.0,
    Radius_stom = 0.0,
    Radius_duod = 0.0,
    Radius_jeju = 0.0,
    Radius_ileon = 0.0,
    Radius_cecum = 0.0,
    Radius_colon = 0.0,
    T12_stom_lu = 0.0,
    T12_duod_lu = 0.0,
    T12_jeju_lu = 0.0,
    T12_ileon_lu = 0.0,
    T12_cecum_lu = 0.0,
    T12_colon_lu = 0.0,
    PH_stom = 0.0,
    PH_duod = 0.0,
    PH_jeju = 0.0,
    PH_ileon = 0.0,
    PH_cecum = 0.0,
    PH_colon = 0.0,
    MicroProt_liver = 0.0,
    MicroProt_stom = 0.0,
    MicroProt_duod = 0.0,
    MicroProt_jeju = 0.0,
    MicroProt_ileon = 0.0,
    MicroProt_cecum = 0.0,
    MicroProt_colon = 0.0,
    V_ep = 0.0,
    MM = 0.0,
    f_Abs_stom = 0.0,
    f_Abs_duod = 0.0,
    f_Abs_jeju = 0.0,
    f_Abs_ileon = 0.0,
    f_Abs_cecum = 0.0,
    f_Abs_colon = 0.0,
    Peff = 0.0,
    Ratio_BP = 0.0,
    PC_adip = 0.0,
    PC_rpt = 0.0,
    PC_ppt = 0.0,
    PC_kid = 0.0,
    PC_liver = 0.0,
    PC_stom = 0.0,
    PC_duod = 0.0,
    PC_jeju = 0.0,
    PC_ileon = 0.0,
    PC_cecum = 0.0,
    PC_colon = 0.0,
    Fu_adip = 0.0,
    Fu_kid = 0.0,
    Fu_ppt = 0.0,
    Fu_rpt = 0.0,
    Fu_blood = 0.0,
    Fu_liver = 0.0,
    Fu_portvein = 0.0,
    Fu_stom = 0.0,
    Fu_duod = 0.0,
    Fu_jeju = 0.0,
    Fu_ileon = 0.0,
    Fu_cecum = 0.0,
    Fu_colon = 0.0,
    Fu_plasma = 0.0,
    Vmax_vitro = 0.0,
    Km_vitro = 0.0,
    Kle_kid = 0.0,
    F_total = 0.0,
    f_Flow_portvein = 0.0,
    V_adip = 0.0,
    V_blood = 0.0,
    V_kid = 0.0,
    V_liver = 0.0,
    V_rpt = 0.0,
    V_ppt = 0.0,
    V_stom = 0.0,
    V_duod = 0.0,
    V_jeju = 0.0,
    V_ileon = 0.0,
    V_cecum = 0.0,
    V_colon = 0.0,
    V_stom_w = 0.0,
    V_duod_w = 0.0,
    V_jeju_w = 0.0,
    V_ileon_w = 0.0,
    V_cecum_w = 0.0,
    V_colon_w = 0.0,
    V_stom_lu = 0.0,
    V_colon_lu = 0.0,
    V_duod_lu = 0.0,
    V_jeju_lu = 0.0,
    V_ileon_lu = 0.0,
    V_cecum_lu = 0.0,
    V_stom_ep = 0.0,
    V_duod_ep = 0.0,
    V_jeju_ep = 0.0,
    V_ileon_ep = 0.0,
    V_cecum_ep = 0.0,
    V_colon_ep = 0.0,
    SA_stom = 0.0,
    SA_duod = 0.0,
    SA_jeju = 0.0,
    SA_ileon = 0.0,
    SA_cecum = 0.0,
    SA_colon = 0.0,
    Flow_adip = 0.0,
    Flow_kid = 0.0,
    Flow_liver = 0.0,
    Flow_liver_art = 0.0,
    Flow_rpt = 0.0,
    Flow_ppt = 0.0,
    Flow_portvein = 0.0,
    Flow_stom = 0.0,
    Flow_duod = 0.0,
    Flow_jeju = 0.0,
    Flow_ileon = 0.0,
    Flow_cecum = 0.0,
    Flow_colon = 0.0,
    Kle_stom = 0.0,
    Kle_duod = 0.0,
    Kle_jeju = 0.0,
    Kle_ileon = 0.0,
    Kle_cecum = 0.0,
    Kle_colon = 0.0,
    Vmax_vivo_liver = 0.0,
    Vmax_vivo_stom = 0.0,
    Vmax_vivo_duod = 0.0,
    Vmax_vivo_jeju = 0.0,
    Vmax_vivo_ileon = 0.0,
    Vmax_vivo_cecum = 0.0,
    Vmax_vivo_colon = 0.0,
    Km_vivo = 0.0
  )
  parms <- within(as.list(parms), {
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
  })
  if (!is.null(newParms)) {
    if (!all(names(newParms) %in% c(names(parms)))) {
      stop("illegal parameter name")
    }
  }
  if (!is.null(newParms))
    parms[names(newParms)] <- newParms
  out <- .C("getParms",  as.double(parms),
            out=double(length(parms)),
            as.integer(length(parms)))$out
  names(out) <- names(parms)
  out
}

Outputs <- c(
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
    "Instant_Ka_gi"
)

initStates <- function(parms, newStates = NULL) {
  Y <- c(
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
    AUC_liver = 0.0
  )
  if (!is.null(newStates)) {
    if (!all(names(newStates) %in% c(names(Y)))) {
      stop("illegal state variable name in newStates")
    }
    Y[names(newStates)] <- newStates
  }
  Y
}
