# Carregar bibliotecas necessárias
library(rvest)
library(jpeg)
library(EBImage)
library(imager)
library(magick)
library(magrittr)
library(raster)
library(rgdal)
library(sp)
library(Rgb)
library(RGBM)
library(OpenImageR)
library(grade)
library(base64)
library(base)

# Definir o diretório de trabalho onde as imagens estão armazenadas
setwd("/Users/Alcilene Santos/Desktop/Rstudio")

# Carregar imagem da pasta local
Im = readImage("xxxxx.jpg")
imageShow(Im)
dim(Im)

# Converter a imagem para escalas de cinza
r2g = rgb_2gray(Im)
imageShow(r2g)
View(r2g)

# Escrever os dados em arquivo de texto e formato dta
write.table(matrix(r2g), file = "esse.txt", sep = ",")
write_dta(matrix(Im), path = "C:/Users/Alcilene Santos/Desktop/R_studio", version = 13)

# -----------------------------------------------------------------------------

# Carregar uma imagem de exemplo
file <- system.file('extdata/parrots.png', package='imager')
parrots <- load.image(file)

# Fazer scraping de imagens da web
search <- read_html("https://www.google.com/search?site=&tbm=isch&q=parrot")
urls <- search %>% html_nodes("img") %>% html_attr("src")

# Carregar e mostrar as primeiras imagens do scraping
map_il(urls[1:4], load.image) %>% plot

# -----------------------------------------------------------------------------

# Carregar imagem via URL
Imi = load.image("https://ak.picdn.net/shutterstock/videos/1029561197/thumb/4.jpg")
plot(Imi)

# Converter a imagem carregada para escalas de cinza
grayscale(Imi) %>% plot
grayscale(Imi, method = "XYZ") %>% plot

# -----------------------------------------------------------------------------

# Aplicar filtro de borda Scharr em uma imagem local
Imb = readImage("Cid.jpg")
edsc = edge_detection(Imb, method = 'Scharr', conv_mode = 'same')
imageShow(edsc)

# Aplicar filtro uniforme
kernel_size = c(4, 4)
unf = uniform_filter(Im, size = kernel_size, conv_mode = 'same')

# Correção gamma
gcor = gamma_correction(Im, gamma = 3)
imageShow(gcor)

# Aplicar ZCA whitening
res = ZCAwhiten(Im, k = 20, epsilon = 0.1)
imageShow(res)

# Delation e Erosion
res_delate = delationErosion(Im, Filter = c(8, 8), method = 'delation')
imageShow(res_delate)

res_erosion = delationErosion(Im, Filter = c(8, 8), method = 'erosion')
imageShow(res_erosion)

# -----------------------------------------------------------------------------

# Aplicação de aumentação em uma imagem (flip, crop, resize, rotate)
Imume = readImage("Cid.jpg")
augm = Augmentation(Im, flip_mode = 'horizontal', crop_width = 20:460, crop_height = 30:450, 
                    resiz_width = 180, resiz_height = 180, resiz_method = 'bilinear', 
                    shift_rows = 0, shift_cols = 0, rotate_angle = 350, 
                    rotate_method = 'bilinear', zca_comps = 100, 
                    zca_epsilon = 0.1, image_thresh = 0.0, verbose = TRUE)
imageShow(augm)

# -----------------------------------------------------------------------------

# Aplicar rotações e shifts aleatórios
samp_rot = sample(c(seq(5, 90, 30), seq(270, 350, 30)), 3, replace = FALSE)
samp_shif_rows = sample(seq(-50, 50, 10), 3, replace = FALSE)
samp_shif_cols = sample(seq(-50, 50, 10), 3, replace = FALSE)

res = lapply(1:length(samp_rot), function(x) 
  Augmentation(Im, flip_mode = 'horizontal', crop_width = 20:460, crop_height = 30:450, 
               resiz_width = 180, resiz_height = 180, resiz_method = 'bilinear', 
               shift_rows = samp_shif_rows[x], shift_cols = samp_shif_cols[x], 
               rotate_angle = samp_rot[x], rotate_method = 'bilinear', 
               zca_comps = 100, zca_epsilon = 0.1, image_thresh = 0.0, verbose = FALSE))

# Mostrar imagens resultantes
imageShow(res[[1]])
imageShow(res[[2]])
imageShow(res[[3]])
