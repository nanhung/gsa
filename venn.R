if(!require(eulerr)) {
  install.packages("eulerr"); require(eulerr)}

set.seed(10)
fit <- euler(c(A = 31, B = 0, C = 0, D = 0, 
               E = 0,
               "A&B" = 7, "A&C" = 5, "A&D" = 0, 
               "B&C" = 0, "B&D" = 0, "C&D" = 0, 
               "A&E" = 0, "B&E" = 0, "C&E" = 0, "D&E" = 0,
               "A&B&C" = 3, "A&B&D" = 0, "A&C&D" = 1, "B&C&D" = 0,
               "A&B&E" = 0, "A&C&E" = 0, "A&D&E" = 0, "B&C&E" = 0, "B&D&E" = 0, "C&D&E" = 0,
               "A&B&C&E" = 2, "A&B&D&E" = 0, "A&C&D&E" = 0, "B&C&D&E" = 0,
               "A&B&C&D&E" = 8,
               "A&B&C&D" = 1))

jpeg(file="ven.jpg",width=4000,height=3200,res=300)
plot(fit, quantities = F,
     labels =c (" ", " ", " ", " ", ""),
     fill = c("transparent","grey120","grey80","grey60","grey40"),
     lty = 1,
     legend = T)
dev.off()



set.seed(30)
fit <- euler(c(FMP = 31, OMP = 0, FIP = 0, OIP = 0,
               "FMP&OMP" = 7, "FMP&FIP" = 6, "FMP&OIP" = 0, "OMP&FIP" = 0, "OMP&OIP" = 0, "FIP&OIP" = 0, 
               "FMP&OMP&FIP" = 3, "FMP&OMP&FIP&OIP" = 11))
jpeg(file="ven.jpg",width=4000,height=3200,res=300)
plot(fit, quantities = F,
     fill = c("transparent","grey100","grey90","grey80"),
     lty = c(5,4,3,2))
dev.off()