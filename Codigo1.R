library(readr)
epa_http <- read_table("D:/Drive(LeninValles)/2. Basicos Capacitaciones/21. Maestria en Ciberseguridad/1. Cursos/12. Ciencia de Datos/Trabajos/ciencia_datos_lab1/epa-http/epa-http.csv", col_names = FALSE)
View(epa_http)



# Pregunta 1.1: dimensiones data frame
library(readr)
epa_http <- read_table("epa-http/epa-http.csv", col_names = FALSE)
View(epa_http)
dim(epa_http)



# Pregunta 1.2: Valor medio de la columna Bytes
colnames(epa_http) <- c("IP", "Tiempo", "Tipo", "URL", "Protocolo", "Codigo", "Bytes")
epa_http$Bytes <- as.numeric(epa_http$Bytes)
mean(epa_http$Bytes, na.rm = TRUE)

#Pregunta 3: Mayor volumen de peticiones HTTP de tipo “GET”


#Pregunta 6: Cantidad de peticiones que NO tienen como protocolo HTTP/0.2
library(readr)
epa_http <- read_table("Drive(LeninValles)/2. Basicos Capacitaciones/21. Maestria en Ciberseguridad/1. Cursos/12. Ciencia de Datos/Trabajos/ciencia_datos_lab1/epa-http/epa-http.csv", col_names = FALSE)
colnames(epa_http) <- c("IP", "Tiempo", "Tipo", "URL", "Protocolo", "Codigo", "Bytes")
View(epa_http)
Protocolo <- filter(epa_http, URL != "", Protocolo != "HTTP/0.2")
mutate(Protocolo, id = row_number())
summarise (Protocolo, id = row_number())
View(Protocolo)









