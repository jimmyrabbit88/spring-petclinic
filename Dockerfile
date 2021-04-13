FROM openjdk:8
EXPOSE 8088
ADD target/spring-petclinic.jar spring-petclinic.jar
ENTRYPOINT ["java", "-jar", "/spring-petclinic.jar"]
