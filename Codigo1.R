library(readr)
epa_http <- read_table("D:/Drive(LeninValles)/2. Basicos Capacitaciones/21. Maestria en Ciberseguridad/1. Cursos/12. Ciencia de Datos/Trabajos/ciencia_datos_lab1/epa-http/epa-http.csv", col_names = FALSE)
View(epa_http)
setwd("D:/Drive(LeninValles)/2. Basicos Capacitaciones/21. Maestria en Ciberseguridad/1. Cursos/12. Ciencia de Datos/Trabajos/ciencia_datos_lab1")

############################################################################################################

# Pregunta 1.1: dimensiones data frame
library(readr)
epa_http <- read_table("epa-http/epa-http.csv", col_names = FALSE)
View(epa_http)
dim(epa_http)


# Pregunta 1.2: Valor medio de la columna Bytes
colnames(epa_http) <- c("IP", "Tiempo", "Tipo", "URL", "Protocolo", "Codigo", "Bytes")
epa_http$Bytes <- as.numeric(epa_http$Bytes)
mean(epa_http$Bytes, na.rm = TRUE)

############################################################################################################

#Pregunta 3: Mayor volumen de peticiones HTTP de tipo “GET”
#De todas las peticiones recibidas por el servidor cual es 
#la hora en la que hay mayor volumen de peticiones HTTP de tipo "GET"?

unique(str_sub(epa_http.filtrado$Tiempo,start = 5, end = 6))

# Para realizar filtro usar el "GET"

epa_http.filtrado <- filter(epa_http,grepl("GET",Tipo,ignore.case = TRUE))
View(epa_http.filtrado)

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

#Pregunta 6: Cantidad de peticiones que NO tienen como protocolo HTTP/0.2
library(readr)
epa_http <- read_table("D:/Drive(LeninValles)/2. Basicos Capacitaciones/21. Maestria en Ciberseguridad/1. Cursos/12. Ciencia de Datos/Trabajos/ciencia_datos_lab1/epa-http/epa-http.csv", col_names = FALSE)
colnames(epa_http) <- c("IP", "Tiempo", "Tipo", "URL", "Protocolo", "Codigo", "Bytes")
View(epa_http)
dim(epa_http)
#Realizar filtro por protocolo diferente a HTTP/0.2
library(dplyr)
tblProtocolo <- filter(epa_http, URL != "", Protocolo != "HTTP/0.2")
a <- substr(tblProtocolo,1,8)
View(a)
view(tblProtocolo)
correlativo <- mutate(Protocolo, id = row_number())
summary(correlativo$id)








