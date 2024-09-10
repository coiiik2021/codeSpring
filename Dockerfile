# Build stage
FROM ubuntu:latest AS build

# Cài đặt Java và các công cụ cần thiết
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk git

# Sao chép mã nguồn vào thư mục làm việc
WORKDIR /app
COPY . .

# Kiểm tra sự tồn tại của gradlew
RUN ls -la

# Cấp quyền thực thi cho gradlew và chạy Gradle để xây dựng ứng dụng
RUN chmod +x gradlew
RUN ./gradlew bootJar --no-daemon

# Run stage
FROM openjdk:17-jdk-slim

# Cài đặt thư mục làm việc
WORKDIR /app

# Sao chép tệp JAR từ stage build
COPY --from=build /app/build/libs/demoTest-1.jar app.jar

# Mở cổng 8080
EXPOSE 8080

# Chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
