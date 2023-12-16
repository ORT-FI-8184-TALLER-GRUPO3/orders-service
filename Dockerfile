#1era etapa
FROM maven:3.6-jdk-8 AS builder
COPY . /app
WORKDIR /app
RUN mvn -e -B package -DskipTests


# 2da etapa

FROM openjdk:8-jre
WORKDIR /app
COPY --from=builder app/target/*.jar /app/
CMD java -jar orders-service-0.0.1-SNAPSHOT.jar $APP_ARGS
