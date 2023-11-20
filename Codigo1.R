library(readr)
library(dplyr)
library(tidyr)
library(stringr)
epa_http <- read_table("D:/Drive(LeninValles)/2. Basicos Capacitaciones/21. Maestria en Ciberseguridad/1. Cursos/12. Ciencia de Datos/Trabajos/ciencia_datos_lab1/epa-http/epa-http.csv", col_names = FALSE)
View(epa_http)
setwd("D:/Drive(LeninValles)/2. Basicos Capacitaciones/21. Maestria en Ciberseguridad/1. Cursos/12. Ciencia de Datos/Trabajos/ciencia_datos_lab1")

############################################################################################################

# Pregunta 1.1: dimensiones data frame
epa_http <- read_table("epa-http/epa-http.csv", col_names = FALSE)
#Otorgamos nombres de cabecera a las columnas
colnames(epa_http) <- c("IP", "Tiempo", "Tipo", "URL", "Protocolo", "Codigo", "Bytes")
View(epa_http)
dim(epa_http)


# Pregunta 1.2: Valor medio de la columna Bytes
colnames(epa_http) <- c("IP", "Tiempo", "Tipo", "URL", "Protocolo", "Codigo", "Bytes")
#Convertimos a tipo de datos numéricos el Campo Bytes
epa_http$Bytes <- as.numeric(epa_http$Bytes)
#Calculamos el valor medio de la columna Bytes
mean(epa_http$Bytes, na.rm = TRUE)

############################################################################################################

#Pregunta 2: Ips educativos(que contengan ".edu")
colnames(epa_http) <- c("IP", "Tiempo", "Tipo", "URL", "Protocolo", "Codigo", "Bytes")
#De las peticiones recibidas utilizaremos nrow que es la cantidad de registros (Filas)
#El filter nos permite realizar el filtfo según una condició, buscando las coincidencias de patrones con grepl.
FiltroGet <- nrow(filter(epa_http, grepl("edu", IP)==TRUE))

############################################################################################################

#Pregunta 3: Mayor volumen de peticiones HTTP de tipo “GET”
#De todas las peticiones recibidas por el servidor cual es 
#la hora en la que hay mayor volumen de peticiones HTTP de tipo "GET"?
# Para realizar filtro usar el "GET"
epa_http.filtrado <- filter(epa_http,grepl("GET",Tipo,ignore.case = TRUE))
View(epa_http.filtrado)
#Extraemos la cadena de tiempo (Horas)
unique(str_sub(epa_http.filtrado$Tiempo,start = 5, end = 6))
# Separar la fecha 29 y 30
epa_http.filtradoGET <- data.frame(x=str_sub(epa_http.filtrado$Tiempo,start = 2, end = 3),y=str_sub(epa_http.filtrado$Tiempo,start = 5, end = 6))
View(epa_http.filtradoGET)
dia29 <- filter(epa_http.filtradoGET,grepl("29",x,ignore.case = TRUE))
dia30 <- filter(epa_http.filtradoGET,grepl("30",x,ignore.case = TRUE))
dia29$y <- as.numeric(dia29$y)
dia30$y <- as.numeric(dia30$y)
View(dia29)
View(dia30)
#Suma de GET en cada hora el día 29
CantGet29 <- dia29 %>% group_by(y) %>% summarize(total_dia29 = n())
View(CantGet29)
hora_pico29 <- CantGet29 %>% filter(total_dia29 == max(total_dia29))
View(hora_pico29)
#Suma de GET en cada hora el día 30
CantGet30 <- dia30 %>% group_by(y) %>% summarize(total_dia30 = n())
View(CantGet30)
hora_pico30 <- CantGet30 %>% filter(total_dia30 == max(total_dia30))
View(hora_pico30)
#Respuesta: La mayor cantidad de peticiones HTTP de tipo GET es a las 14H

##########################################################################################################

#Pregunta 4: De las peticiones hechas por instituciones educativas (.edu), 
#¿Cuantos bytes en total se han transmitido, en peticiones de descarga 
#de ficheros de texto ".txt"?

#Filtramos todas las instituciones educativas .edu
epa_http.edu <- filter(epa_http,grepl(".edu",IP,ignore.case = TRUE))
View(epa_http.edu)

#Filtramos todas las peticiones txt
epa_http.edu.txt <- filter(epa_http.edu,grepl(".txt",URL,ignore.case = TRUE))
View(epa_http.edu.txt)

epa_http.edu.txt$Bytes <- as.numeric(epa_http.edu.txt$Bytes)

#Realizamos la suma de bytes
suma.bytes <- sum(epa_http.edu.txt$Bytes,na.rm = TRUE)
View(suma.bytes)

#La suma es 3017871


##########################################################################################################

#Pregunta 5: Usando str_split y el separador " " (espacio), ¿cuantas peticiones buscan directamente la URL = "/"?

#La primera línea de código filtra el conjunto de datos epa_http para que solo incluya filas donde el valor de la columna 
#de peticiones sea igual a /. 
#El conjunto de datos filtrado resultante se almacena en el objeto "separador"
#El código filtra el conjunto de datos epa_http para que solo incluya filas donde el valor de la columna URLsea igual a / 
#y luego cuenta el número de filas en el conjunto de datos filtrado.
separador <- filter(epa_http, URL=="/")
#La función nrow() se utiliza para contar el número de filas en un data frame.
peticiones<- nrow(separador)


##########################################################################################################

#Pregunta 6: Cantidad de peticiones que NO tienen como protocolo HTTP/0.2
colnames(epa_http) <- c("IP", "Tiempo", "Tipo", "URL", "Protocolo", "Codigo", "Bytes")
View(epa_http)
#Filtramos todas las consultas HTTP/0.2
epa_http.protocolof <- filter(epa_http,substr(epa_http$Protocolo,1,8)!="HTTP/0.2")
Pregunta6<- NROW(epa_http.protocolof$Protocolo)
View(epa_http.protocolof)
View(Pregunta6)
#Respuesta 6: La cantidad de peticiones que no es HTTP/0.2 es 47747



