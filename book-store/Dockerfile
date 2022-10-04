FROM registry.access.redhat.com/ubi8/openjdk-11:1.11
# Here you can specify the maintainer for the image that you're building
LABEL maintainer="Julian Rivera-Pineda <jurivera@promerica.com.sv>"  description="Payara5 Micro S2I for OpenShift"

# Set the labels that are used for OpenShift to describe the builder image.
#LABEL io.k8s.description="Payara Micro S2I for OpenShif" \
#    io.k8s.display-name="Payara Micro 5.2022.x  S2I for OpenShif" \
#    io.openshift.expose-services="8181:https,9876:http" \
#    io.openshift.tags="builder,airhackspromerica,payara,payara micro,jakartaee,javaee,microprofile" \
    # this label tells s2i where to find its mandatory scripts
    # (run, assemble, save-artifacts)
#    io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"



ENV VERSION 5.2022.2
#ARG VERSION

#ENV PROXY_HOST 10.5.3.200
#ENV PROXY_PORT 3128
#ENV HTTP_PROXY http://${PROXY_HOST}:${PROXY_PORT}
#ENV HTTPS_PROXY http://${PROXY_HOST}:${PROXY_PORT}
#ENV NO_PROXY localhost,127.0.0.1

ENV JVM_ARGS -Djavax.net.ssl.keyStore=/opt/payara/config/keystore.jks -Djavax.net.ssl.keyStorePassword=changeit 
ENV JVM_ARGS ${JVM_ARGS} -Djavax.net.ssl.trustStore=/opt/payara/config/cacerts.jks -Djavax.net.ssl.trustStorePassword=changeit 
#ENV JVM_ARGS ${JVM_ARGS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttps.proxyHost=${PROXY_HOST} -Dhttps.proxyPort=${PROXY_PORT} 
#ENV JVM_ARGS ${JVM_ARGS} -Dhttp.nonProxyHosts=localhost,127.0.0.1
ENV HTTP_PORT 9876
ENV HTTPS_PORT 8181

ENV PAYARA_JAR payara-micro-${VERSION}.jar
ENV INSTALL_DIR /opt/payara
ENV LIB_DIR ${INSTALL_DIR}/lib
ENV SOURCE_DIR ${INSTALL_DIR}/src
ENV DEPLOYMENT_DIR ${INSTALL_DIR}/deployments
ENV LOG_DIR ${INSTALL_DIR}/logs
ENV CONFIG_DIR ${INSTALL_DIR}/config
ENV ROOT_DIR ${INSTALL_DIR}/root
RUN 
    mkdir -p ${SOURCE_DIR} \
    mkdir -p ${DEPLOYMENT_DIR} \
    mkdir -p ${LIB_DIR} \
    mkdir -p ${LOG_DIR} \
    mkdir -p ${CONFIG_DIR} \
    mkdir -p ${ROOT_DIR} \
    && chown -R 1001:0 ${INSTALL_DIR} \
    && chmod -R a+rw ${INSTALL_DIR}

COPY files/logger.properties ${CONFIG_DIR}
COPY files/keystore.jks  ${CONFIG_DIR}
COPY files/cacerts.jks  ${CONFIG_DIR}
COPY files/prebootcommandfile.txt ${CONFIG_DIR}
COPY files/postbootcommandfile.txt ${CONFIG_DIR}
RUN curl -o ${INSTALL_DIR}/${PAYARA_JAR} -L https://s3-eu-west-1.amazonaws.com/payara.fish/Payara+Downloads/${VERSION}/${PAYARA_JAR}
RUN echo ${JVM_ARGS}
COPY pom.xml ${SOURCE_DIR}
COPY src ${SOURCE_DIR}
RUN  
USER 1001


EXPOSE ${HTTP_PORT} ${HTTPS_PORT}
