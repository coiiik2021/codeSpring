FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y openjdk-17-jdk git
COPY . /app
WORKDIR /app

RUN ./gradlew bootJar --no-daemon

FROM openjdk:17-jdk-slim
EXPOSE 8080

COPY --from=build /app/build/libs/demo-1.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
