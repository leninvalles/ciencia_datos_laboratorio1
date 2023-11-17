# Pregunta 1: dimensiones data frame
library(readr)
epa_http <- read_table("epa-http/epa-http.csv", col_names = FALSE)
View(epa_http)
dim(epa_http)



# Pregunta 2: Valor medio de la columna Bytes
colnames(epa_http) <- c("IP", "Tiempo", "Tipo", "URL", "Protocolo", "Codigo", "Bytes")
epa_http$Bytes <- as.numeric(epa_http$Bytes)
mean(epa_http$Bytes, na.rm = TRUE)

#Pregunta 3: Mayor volumen de peticiones HTTP de tipo “GET”













