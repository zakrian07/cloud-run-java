# Use Maven to build the application
FROM maven:3.6-jdk-11 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

# Use OpenJDK to run the application
FROM openjdk:11-jre-slim
COPY --from=build /usr/src/app/target/my-java-app-1.0-SNAPSHOT.jar /usr/app/my-java-app.jar
EXPOSE 8080
CMD ["java", "-jar", "/usr/app/my-java-app.jar"]
