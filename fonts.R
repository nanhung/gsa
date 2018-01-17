# http://blog.revolutionanalytics.com/2012/09/how-to-use-your-favorite-fonts-in-r-charts.html

if(!require(extrafont)) {
  install.packages("extrafont"); require(extrafont)}
# font_install('fontcm') # install fontcm

# font_import() # used to import new installed font 
loadfonts()
# If you want to output to .ps files instead of .pdf, use:
# loadfonts(device="postscript")

fonts() # check current fonts

pdf("plot_cm.pdf", family="CM Roman", width=5.5, height=5)

curve(dnorm, from=-3, to=3, main="Normal Distribution")
text(x=0, y=0.1, cex=1.5, expression(italic(y == frac(1, sqrt(2 * pi)) *
                                              e ^ {-frac(x^2, 2)} )))

dev.off()


