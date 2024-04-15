FROM maven:3.8.7-openjdk-18-slim AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:21-jdk-slim
COPY --from=build /target/quizzer-0.0.1-SNAPSHOT.jar app/quizzer.jar

RUN useradd -ms /bin/bash myuser
RUN chown myuser app
RUN chmod -R gu+w app

EXPOSE 8080

USER myuser
ENTRYPOINT ["java","-jar","app/quizzer.jar"]
