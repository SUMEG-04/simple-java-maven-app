# Stage 1: Build the app using Maven
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package -DskipTests

# Stage 2: Run the app using a lightweight JDK image
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy the built jar from the builder stage
COPY --from=builder /app/target/my-app-1.0-SNAPSHOT.jar app.jar

# Set the entrypoint
ENTRYPOINT ["java", "-jar", "app.jar"]
