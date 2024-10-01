#Esse código em R é utilizado para manipulação e visualização de imagens, com o foco em trabalhar com canais de cores (RGB) de uma imagem.


library(grade)
library(gridExtra)
library(raster)
library(BiocManager)
library(OpenImageR)
library(EBImage)
library(base)


#library()


setwd("/Users/Alcilene Santos/Desktop/Rstudio")

Im = readImage("garrafa.jpg")

#display(Im, method = "browser")
imageShow(Im)
dim(Im)




### EX 1: mostra a imagem RGB completa

grid.raster (Im)
### EX 2: mostra o canal B em escala de cinza representando a intensidade do pixel
grid.raster (Im[,,3])
### EX 3: mostra os 3 canais em imagens separadas
# copie a imagem três vezes
Im.R = Im
Im.G = Im
Im.B = Im

# zera os canais que não contribuem para cada cópia da imagem
Im.R[,,2:3] = 0
Im.G[,,1]=0
Im.G[,,3]=0
Im.B[,,1:2]=0
# construir a grade de imagens
img1 = rasterGrob (Im.R)
img2 = rasterGrob(Im.G)
img3 = rasterGrob(Im.B)
grid.arrange(img1, img2,img3, nrow=1)
