FROM maven:3-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
COPY --from=build /app/target/demoTest-0.0.1-SNAPSHOT.war demotest.war
EXPOSE 8080 

ENTRYPOINT ["java","-jar","demotest.war"]
