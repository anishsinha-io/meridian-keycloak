ARG KC_VERSION="26.5.6"

FROM quay.io/keycloak/keycloak:${KC_VERSION}

ARG KC_BCRYPT_VERSION="1.7.0"

ADD --chown=keycloak:keycloak \
  https://github.com/leroyguillaume/keycloak-bcrypt/releases/download/v${KC_BCRYPT_VERSION}/keycloak-bcrypt-${KC_BCRYPT_VERSION}.jar \
  /opt/keycloak/providers/keycloak-bcrypt.jar

RUN /opt/keycloak/bin/kc.sh build --db=postgres

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
