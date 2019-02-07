FROM rabbitmq:3.6-management-alpine

RUN rabbitmq-plugins enable --offline rabbitmq_federation rabbitmq_federation_management rabbitmq_management_visualiser

COPY docker-entrypoint-federated.sh /usr/local/bin/
ENTRYPOINT [ "docker-entrypoint-federated.sh" ]