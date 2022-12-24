FROM lolhens/baseimage-openjre
ADD target/springbootApp.jar springbootApp.jar
EXPOSE 80
CMD ["java", "-jar", "springbootApp.jar"]