FROM openjdk:21-jdk-slim AS builder
WORKDIR /workspace/app

# Copy gradle files first (cache optimization)
COPY gradlew .
COPY gradle/wrapper gradle/wrapper
COPY build.gradle .
COPY settings.gradle .
COPY src src

# Make gradlew executable and build
RUN chmod +x gradlew
RUN ./gradlew clean build -x test

# Runtime stage - IMAGEM FINAL QUE VAI PRO AZURE
FROM openjdk:21-jdk-slim
WORKDIR /app

# Copy the built jar from builder stage
COPY --from=builder /workspace/app/build/libs/*.jar app.jar

# Create a non-root user for security (IMPORTANTE para Azure)
RUN groupadd -r spring && useradd -r -g spring spring
USER spring

# Expose port 8080 (EXIGIDO pela sua aplicação)
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]