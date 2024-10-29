# Use the official Maven image for building the application with JDK 17
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory
WORKDIR /usr/src/app

# Copy the pom.xml and src directory to the container
COPY pom.xml .
COPY src ./src

# Build the JAR file
RUN mvn clean package

# Use OpenJDK to run the application
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /usr/src/app

# Copy the built JAR file from the build stage
COPY --from=build /usr/src/app/target/helloprint-0.0.1-SNAPSHOT.jar .

# Run the application
CMD ["java", "-jar", "helloprint-0.0.1-SNAPSHOT.jar"]
