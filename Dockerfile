FROM maven:3.6.3-openjdk-14 AS builder

COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/

RUN mvn package

FROM openjdk:14-alpine

MAINTAINER chkmk

WORKDIR /var/app

COPY --from=builder /tmp/target/zkui-*-jar-with-dependencies.jar /var/app/zkui.jar
COPY config.cfg /var/app/config.cfg
COPY bootstrap.sh /var/app/bootstrap.sh

ENTRYPOINT ["/var/app/bootstrap.sh"]

EXPOSE 9090