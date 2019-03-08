FROM openjdk:9-jdk-slim as certs

USER root
ENV PATH_TO_CACERTS /usr/lib/jvm/java-9-openjdk-amd64/lib/security/cacerts
ARG CERT_PASSWORD

# Importing the provided cert
RUN mkdir -p /opt/certificates
COPY self_signed.crt /opt/certificates/
RUN keytool -noprompt -import -alias self_signed_cert -keystore $PATH_TO_CACERTS -file /opt/certificates/self_signed.crt -storepass ${CERT_PASSWORD}

#Copy trustore to final image
FROM openjdk:9-jdk-slim as final
WORKDIR /home/java
ENV PATH_TO_CACERTS /usr/lib/jvm/java-9-openjdk-amd64/lib/security/cacerts
COPY --from=certs $PATH_TO_CACERTS $PATH_TO_CACERTS
RUN groupadd --gid 1000 java &&\
    useradd --uid 1000 --gid java --shell /bin/bash --create-home java && \
    chmod -R a+w /home/java
