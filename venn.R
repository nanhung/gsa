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
plot(fit, legend = TRUE, edges = F,
     labels =c (" ", " ", " ", " ", ""),
     fills = c("white", "grey", "deepskyblue", "lightgreen", "red"))
dev.off()
