# Carregar a biblioteca necessária para manipulação de imagens
library(OpenImageR)

# Definir o caminho da imagem chamada 'arvore.jpg' no diretório atual de trabalho
# getwd() obtém o diretório atual de trabalho, e file.path constrói o caminho completo da imagem
path = file.path(getwd(), 'arvore.jpg')

# Quantização de cores da imagem em tons de cinza com um número máximo de 10 cores
# colorspace = 'cinza' converte a imagem para escala de cinza
image_quantize(path, max = 10, colorspace = 'gray')

# Ler a imagem usando a função readImage
# A função readImage lê a imagem do caminho especificado e carrega como uma matriz
im = readImage(path)

# Exibir as dimensões da imagem (número de linhas, colunas e canais de cores)
# Isso é útil para saber a resolução da imagem e o número de canais (ex: RGB tem 3 canais)
dim(im)

# Exibir a imagem usando a função imageShow
# Esta função exibe a imagem no formato original diretamente na interface do R
imageShow(im)

# Gravar a imagem lida no formato TIFF com o nome 'my_arvore.tiff'
# A função writeImage salva a imagem em um formato especificado (neste caso, TIFF)
writeImage(im, file_name = "my_arvore.tiff")

# 1. Converter uma imagem RGB para tons de cinza usando rgb_2gray
# Definir um novo caminho para outra imagem chamada 'cidade.jpeg'
path = file.path(getwd(), 'cidade.jpeg')

# Ler a imagem da cidade no formato JPEG
im = readImage(path)

# Exibir a imagem da cidade original
imageShow(im)

# Abaixo, há um exemplo de como você pode calcular um histograma de gradientes orientados (HOG)
# O HOG é usado para detecção de objetos em imagens, computando as direções predominantes de gradiente.

# Descomente as linhas abaixo se quiser usar HOG para detecção de objetos
# Imagem precisa ser multiplicada por 255, pois HOG espera uma escala de 0 a 255 para imagens de 8 bits
# im = im * 255

# Calcular o HOG (Histogram of Oriented Gradients)
# cells define o tamanho das células da imagem para o cálculo de gradientes
# orientations define o número de direções de gradiente para análise
# hog = HOG(im, cells = 7, orientations = 9)

# Exibir o histograma de gradientes orientados
# print(hog)

