FROM maven:3.8.5-openjdk-11-slim AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests \
    -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn

FROM openjdk:11-jre-slim
WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

RUN addgroup --system --gid 1001 appgroup && \
    adduser --system --uid 1001 --gid 1001 appuser
USER appuser

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]