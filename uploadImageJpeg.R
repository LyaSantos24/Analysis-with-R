
#Este código em R tem como objetivo carregar uma imagem no formato JPEG,
# transformá-la em um data frame, e organizar suas informações de cores (RGB) para cada pixel, junto com as suas posições (x, y). 


library(EBImage)
library(tidyverse)
library(jpeg)
# carrega uma imagem jpeg no R
download.file("https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion.jpg", 
              destfile = "minion.jpg")

img <- readJPEG("minion.jpeg")

# transforma o array da imagem em data.frame com infos de posicao (x,y)
# e cor (r,g,b) dimensões da imagem
img_dim <- dim(img)

# RGB para data.frame
img_df <- data.frame(
  x = rep(1:img_dim[2], each = img_dim[1]),
  y = rep(img_dim[1]:1, img_dim[2]),
  r = as.vector(img[,,1]),
  g = as.vector(img[,,2]),
  b = as.vector(img[,,3])
) %>%
  mutate(cor = rgb(r, g, b),
         id = 1:n())
