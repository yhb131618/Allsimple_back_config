FROM openjdk:17-jdk-alpine as builder

WORKDIR /app

COPY . .

RUN chmod +x ./gradlew
RUN ./gradlew build -x test  # 테스트를 건너뛰고 빌드

FROM openjdk:17-jdk-alpine

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8888
ENTRYPOINT ["java", "-jar", "app.jar"]
