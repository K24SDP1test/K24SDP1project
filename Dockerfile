FROM maven:3.8.7-openjdk-18-slim AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:21-jdk-slim
RUN touch blaah.txt
RUN mkdir app
RUN chmod +w app
COPY --from=build /target/quizzer-0.0.1-SNAPSHOT.jar app/quizzer.jar
EXPOSE 8080

ENTRYPOINT ["java","-jar","app/quizzer.jar"]
