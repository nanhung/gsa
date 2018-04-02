if(!require(eulerr)) {
  install.packages("eulerr"); require(eulerr)}

set.seed(10)
fit <- euler(c(A = 58, B = 0, C = 0, D = 0,
               "A&B" = 7, "A&C" = 5, "A&D" = 0,
               "B&C" = 0, "B&D" = 0, "C&D" = 0,
               "A&B&C" = 5,"A&B&D" = 0,
               "A&C&D" = 1, "B&C&D" = 0,
               "A&B&C&D" = 9))

jpeg(file="ven.jpg",width=4000,height=3200,res=300)
plot(fit, legend = TRUE, edges = F,
     labels =c (" ", " ",
                     " ", " "),
     fills = c("white", "grey", "deepskyblue", "lightgreen"))
dev.off()
