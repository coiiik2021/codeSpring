# Build stage
FROM maven:3-openjdk-17 AS build
WORKDIR /app

# Sao chép mã nguồn vào thư mục làm việc
COPY . .

# Chạy Maven để xây dựng ứng dụng
RUN mvn clean package -DskipTests

# Kiểm tra sự tồn tại của tệp WAR trong thư mục target
RUN ls -la /app/target

# Run stage
FROM openjdk:17-jdk-slim
WORKDIR /app

# Sao chép tệp WAR từ stage build
COPY --from=build /app/target/demoTest-0.0.1-SNAPSHOT.war demotest.war

# Mở cổng 8080
EXPOSE 8080

# Chạy ứng dụng
ENTRYPOINT ["java", "-jar", "demotest.war"]
