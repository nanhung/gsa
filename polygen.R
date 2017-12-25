set.seed(1234)
x <- rnorm(20)
df <- data.frame(x = x,
                 y = x + rnorm(20))

plot(y ~ x, data = df)

# model
mod <- lm(y ~ x, data = df)

# predicts + interval
newx <- seq(min(df$x), max(df$x), length.out=100)
preds <- predict(mod, newdata = data.frame(x=newx), 
                 interval = 'confidence')

# plot
plot(y ~ x, data = df, type = 'n')
# add fill
polygon(c(rev(newx), newx), c(rev(preds[ ,3]), preds[ ,2]), col = 'grey80', border = NA)
# model
abline(mod)
# intervals
lines(newx, preds[ ,3], lty = 'dashed', col = 'red')
lines(newx, preds[ ,2], lty = 'dashed', col = 'red')

polygon(c(0, 1), c(-2,2), col = 'grey80', border = NA)

# Rechteck einzeichnen
polygon(
  x = c(0, 0, 1, 1)
  , y = c(-1, 2, 2, -1)
  , col = "#0000cc33", 
  border = NA
)


######################################################

x = 1:100
y = x + runif(n=length(x), min=-5, max=+5)
# Simulierte Standardabweichung:
sd = 10 + runif(n=length(x), min=-1, max=+1)
plot(x,y, las=1)

# Bereiche der simulierten Standardabweichung einzeichnen
polygon(
  x = c(x, rev(x))
  , y = c(y+sd, rev(y-sd))
  , col = "#cc000033"
)

# Rechteck einzeichnen
polygon(
  x = c(40, 40, 60, 60)
  , y = c(-10, 200, 200, -10)
  , col = "#0000cc33"
)

#
x <- c(1:9, 8:1)
y <- c(1, 2*(5:3), 2, -1, 17, 9, 8, 2:9)
op <- par(mfcol = c(3, 1))
for(xpd in c(FALSE, TRUE, NA)) {
  plot(1:10, main = paste("xpd =", xpd))
  box("figure", col = "pink", lwd = 3)
  polygon(x, y, xpd = xpd, col = "orange", lty = 2, lwd = 2, border = "red")
}
par(op)

#
n <- 100
xx <- c(0:n, n:0)
yy <- c(c(0, cumsum(stats::rnorm(n))), rev(c(0, cumsum(stats::rnorm(n)))))
plot   (xx, yy, type = "n", xlab = "Time", ylab = "Distance")
polygon(xx, yy, col = "gray", border = "red")
title("Distance Between Brownian Motions")

# Multiple polygons from NA values
# and recycling of col, border, and lty
op <- par(mfrow = c(2, 1))
plot(c(1, 9), 1:2, type = "n")
polygon(1:9, c(2,1,2,1,1,2,1,2,1),
        col = c("red", "blue"),
        border = c("green", "yellow"),
        lwd = 3, lty = c("dashed", "solid"))
  plot(c(1, 9), 1:2, type = "n")
  polygon(1:9, c(2,1,2,1,NA,2,1,2,1),
          col = c("red", "blue"),
          border = c("green", "yellow"),
          lwd = 3, lty = c("dashed", "solid"))
  par(op)

# Line-shaded polygons
plot(c(1, 9), 1:2, type = "n")
polygon(1:9, c(2,1,2,1,NA,2,1,2,1),
        density = c(10, 20), angle = c(-45, 45))