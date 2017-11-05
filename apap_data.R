# Volak 325 mg 
Time<-c(0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 6.0, 8.0, 10.0)
CPL_APAP_mcgL <- c(7.5756, 7.8973, 8.0359, 7.9409, 7.7536, 7.5909, 7.3395, 6.6758, 6.1654, NA)
CPL_AG_mcgL <- c(5.7038, 7.6639, 8.149, 8.3687, 8.468, 8.5192, 8.4338, 8.052, 7.5549, 7.1624)
CPL_AS_mcgL <- c(6.5539, 7.3524, 7.7098, 7.7579, 7.7007, 7.5909, 7.4384, 6.9177, 6.4489, 6.1841)
#CPL_APAP_mcgL <- (exp(CPL_APAP_mcgL))/1000; CPL_AG_mcgL <- (exp(CPL_AG_mcgL))/1000; CPL_AS_mcgL <- (exp(CPL_AS_mcgL))/1000
APAP.1 <- data.frame(Time, CPL_APAP_mcgL, CPL_AG_mcgL, CPL_AS_mcgL)

# Jensen (2004)5 1000 mg 
Time<-c(0.5, 1.0, 1.5, 2.0, 3.0, 4.0, 5.0, 6.0, 8.0, 10.0, 12.0)
CPL_APAP_mcgL <- c(9.2797, 9.4681, 9.2923, 9.0719, 8.7246, 8.3994, 8.1881, 7.892, 7.3309, NA, NA)
CPL_AG_mcgL <- c(8.3935, 9.3632, 9.8072, 9.982, 10.0493, 9.926, 9.7817, 9.552, 9.1014, 8.6473, NA)
CPL_AS_mcgL <- c(8.317, 8.7968, 8.9727, 8.887, 8.7968, 8.539, 8.4138, 8.1712, 7.6798, 7.2098, NA)
#CPL_APAP_mcgL <- (exp(CPL_APAP_mcgL))/1000; CPL_AG_mcgL <- (exp(CPL_AG_mcgL))/1000; CPL_AS_mcgL <- (exp(CPL_AS_mcgL))/1000
APAP.2 <- data.frame(Time, CPL_APAP_mcgL, CPL_AG_mcgL, CPL_AS_mcgL)

# Shinoda (2007) 1000 mg
Time<-c(2.50E-01, 5.00E-01, 7.50E-01, 1.00E+00, 2.00E+00, 3.00E+00, 4.00E+00, 6.00E+00)
CPL_APAP_mcgL <- c(9.6989, 9.7585, 9.6486, 9.5324, 9.2686, 9.0372, 8.8291, 8.4617)
CPL_AG_mcgL <- c(7.2842, 9.1686, 9.4551, 9.6247, 9.9808, 9.9091, 9.7584, 9.3016)
CPL_AS_mcgL <- c(7.5479, 8.4928, 8.5595, 8.5595, 8.5884, 8.4446, 8.261, 7.7043)
#CPL_APAP_mcgL <- (exp(CPL_APAP_mcgL))/1000; CPL_AG_mcgL <- (exp(CPL_AG_mcgL))/1000; CPL_AS_mcgL <- (exp(CPL_AS_mcgL))/1000
APAP.3 <- data.frame(Time, CPL_APAP_mcgL, CPL_AG_mcgL, CPL_AS_mcgL)

#  Kim (2011)  20mg/kg
Time<-c(0.25, 0.5, 1, 1.5, 2, 3, 4, 6, 8, 10)
CPL_APAP_mcgL <- c(8.3405, 8.0456, 8.5271, 9.0607, 9.0927, 9.0466, 8.8393, 8.2188, 7.5704, NA)
CPL_AG_mcgL <- c(6.2383, 6.9276, 8.1831, 8.7749, 9.1485, 9.5819, 9.705, 9.5956, 9.1788, 8.6945)
CPL_AS_mcgL <- c(6.2383, 6.5482, 7.6917, 8.1577, 8.3939, 8.5773, 8.5679, 8.2242, 7.7187, 7.2226)
#CPL_APAP_mcgL <- (exp(CPL_APAP_mcgL))/1000; CPL_AG_mcgL <- (exp(CPL_AG_mcgL))/1000; CPL_AS_mcgL <- (exp(CPL_AS_mcgL))/1000
APAP.4 <- data.frame(Time, CPL_APAP_mcgL, CPL_AG_mcgL, CPL_AS_mcgL)

# Prescott (1980) 20 mg/kg #1.1.2
Time<-c(0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0)
CPL_APAP_mcgL <- c(9.6486, 9.8363, 9.8416, 9.7981, 9.655, 9.5178, 9.2203, 8.9187, 8.294, 7.836)
CPL_AG_mcgL <- c(8.0722, 8.9804, 9.5047, 9.806, 10.1138, 10.2139, 10.1567, 10.0871, 9.6304, 9.2425)
CPL_AS_mcgL <- c(8.1743, 8.8166, 9.0136, 9.1653, 9.1427, 9.0802, 8.9097, 8.8052, 8.394, 7.9587)
#CPL_APAP_mcgL <- (exp(CPL_APAP_mcgL))/1000; CPL_AG_mcgL <- (exp(CPL_AG_mcgL))/1000; CPL_AS_mcgL <- (exp(CPL_AS_mcgL))/1000
APAP.5 <- data.frame(Time, CPL_APAP_mcgL, CPL_AG_mcgL, CPL_AS_mcgL)

# Chan (1997) 20 mg/kg
Time<-c(0.5, 1.0, 1.5, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0)
CPL_APAP_mcgL <- c(9.9184, 9.8934, 9.8092, 9.6486, 9.3147, 9.0131, 8.7323, 8.4949, 8.1719, 8.0678)
CPL_AG_mcgL <- c(8.8496, 9.6346, 9.9605, 10.0689, 10.0689, 9.9585, 9.8012, 9.6501, 9.4602, 9.3075)
CPL_AS_mcgL <- c(8.5855, 8.9833, 9.1311, 9.1195, 8.9737, 8.8098, 8.6137, 8.4609, 8.253, 8.0158)
#CPL_APAP_mcgL <- (exp(CPL_APAP_mcgL))/1000; CPL_AG_mcgL <- (exp(CPL_AG_mcgL))/1000; CPL_AS_mcgL <- (exp(CPL_AS_mcgL))/1000
APAP.6 <- data.frame(Time, CPL_APAP_mcgL, CPL_AG_mcgL, CPL_AS_mcgL)

# Critchley et al. (2005)  20mg/kg
Time<-c(0.5, 1.0, 1.5, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0)
CPL_APAP_mcgL <- c(9.9942, 9.8147, 9.6291, 9.488, 9.2496, 8.9708, 8.6604, 8.3825, 8.197, 7.9374, NA, NA)
CPL_AG_mcgL <- c(8.3168, 9.4047, 9.6884, 9.8343, 9.8896, 9.8319, 9.6924, 9.5144, 9.2735, 9.0257, 8.8558, 8.7345)
CPL_AS_mcgL <- c(8.4314, 8.9362, 9.0191, 8.9872, 8.9158, 8.7388, 8.5682, 8.3765, 8.204, 7.964, 7.7515, 7.5234)
#CPL_APAP_mcgL <- (exp(CPL_APAP_mcgL))/1000; CPL_AG_mcgL <- (exp(CPL_AG_mcgL))/1000; CPL_AS_mcgL <- (exp(CPL_AS_mcgL))/1000
APAP.7 <- data.frame(Time, CPL_APAP_mcgL, CPL_AG_mcgL, CPL_AS_mcgL)

# Chiew1 (2010) 79 mg/kg 
Time<-c(0.5, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0, 10,12)
CPL_APAP_mcgL <- c(11.1496, 11.357, 11.1583, 10.9794, 10.9794, 10.8735, 10.6532, 10.1775, 9.6145, 9.0993, 8.5536)
CPL_AG_mcgL <- c(9.3288, 10.1109, 10.5093, 11.0057, 11.2879, 11.5434, 11.5929, 11.4362, 11.0941, 10.7324, 10.3191)
CPL_AS_mcgL <- c(8.6702, 9.1882, 9.3634, 9.577, 9.7297, 9.8477, 9.9619, 9.8872, 9.689, 9.4287, 9.0757)
#CPL_APAP_mcgL <- (exp(CPL_APAP_mcgL))/1000; CPL_AG_mcgL <- (exp(CPL_AG_mcgL))/1000; CPL_AS_mcgL <- (exp(CPL_AS_mcgL))/1000
APAP.8 <- data.frame(Time, CPL_APAP_mcgL, CPL_AG_mcgL, CPL_AS_mcgL)
