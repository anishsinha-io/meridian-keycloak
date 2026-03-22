ARG KC_VERSION="26.5.6"

FROM quay.io/keycloak/keycloak:${KC_VERSION} AS builder

ARG KC_BCRYPT_VERSION="1.7.0"

ADD --chown=keycloak:keycloak \
  https://github.com/leroyguillaume/keycloak-bcrypt/releases/download/v${KC_BCRYPT_VERSION}/keycloak-bcrypt-${KC_BCRYPT_VERSION}.jar \
  /opt/keycloak/providers/keycloak-bcrypt.jar

RUN /opt/keycloak/bin/kc.sh build

ARG KC_VERSION
FROM quay.io/keycloak/keycloak:${KC_VERSION}

COPY --from=builder /opt/keycloak /opt/keycloak

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

