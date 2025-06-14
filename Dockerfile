FROM openjdk:17-alpine
ARG JAR_FILE=target/*.jar
WORKDIR /job-hunting-platform

COPY ${JAR_FILE} app.jar

EXPOSE 8080
CMD java -jar /job-hunting-platform/app.jar