#este Dockerfile realiza la compilación de una aplicación Java utilizando Maven en una etapa 
# luego crea una imagen más liviana para ejecutar la aplicación utilizando el JRE de OpenJDK en otra etapa. 
#Esto permite que la imagen resultante sea más pequeña, 
#ya que solo incluye los archivos necesarios para ejecutar la aplicación.


#1era etapa
FROM maven:3.6-jdk-8-alpine AS builder
COPY . /app
WORKDIR /app
RUN mvn -e -B package -DskipTests


# 2da etapa

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=builder app/target/orders-service-example-0.0.1-SNAPSHOT.jar /app/
#CMD ["java", "-jar", "/app/target/orders-service-example-0.0.1-SNAPSHOT.jar", $APP_ARGS]
CMD java -jar orders-service-example-0.0.1-SNAPSHOT.jar $APP_ARGS
#este es un poco distinto, si llega a haber algun problema intenta usar este otro jar orders-service-example-0.0.1-SNAPSHOT-spring-boot.jar
