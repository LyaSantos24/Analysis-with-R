library(imager)
library(OpenImageR)


#Imagem = system.file("/Users/Alcilene Santos/Desktop/Rstudio", package = "imager.CannyEdges")
setwd("/Users/Alcilene Santos/Desktop/Rstudio")

Im = readImage("garrafa.jpg")
#Imi =  load.image("https://designermaodevaca.com/manager/upload/f2e475-pixabay-secao-png-designer-mao-de-vaca1.png")

plot(Im)

cannyEdges(Im) %>% plot


#Make thresholds less strict
cannyEdges(Im,alpha=.4) %>% plot
#Make thresholds more strict
cannyEdges(Im,alpha=1.4) %>% plot

#r2g = rgb_2gray(Imi)
#imageShow(r2g)
