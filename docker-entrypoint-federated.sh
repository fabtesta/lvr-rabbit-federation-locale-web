#!/bin/bash
echo "BEGIN EXTENDED ENTRYPOINT FOR FEDERATION CONFIGURATION"

echo "RABBITMQ_FEDERATED_HOST --> ${RABBITMQ_FEDERATED_HOST}"
echo "RABBITMQ_FEDERATION_UPSTREAM_NAME --> ${RABBITMQ_FEDERATION_UPSTREAM_NAME}"
echo "RABBITMQ_FEDERATION_POLICY_PATTERN --> ${RABBITMQ_FEDERATION_POLICY_PATTERN}"

echo "STARTING RABBITMQ FOR A MOMENT..."
nohup bash -c "source /usr/local/bin/docker-entrypoint.sh rabbitmq-server &" \
    && sleep 10 \
    && rabbitmqctl set_parameter federation-upstream ${RABBITMQ_FEDERATION_UPSTREAM_NAME} '{"uri":"amqp://'${RABBITMQ_FEDERATED_HOST}'","expires":3600000}' \
    && rabbitmqctl set_policy --apply-to exchanges ${RABBITMQ_FEDERATION_UPSTREAM_NAME} "${RABBITMQ_FEDERATION_POLICY_PATTERN}" '{"federation-upstream":"'${RABBITMQ_FEDERATION_UPSTREAM_NAME}'"}'

pkill -KILL -u rabbitmq
echo "RABBITMQ KILLED"
echo "DONE EXTENDED ENTRYPOINT FOR FEDERATION CONFIGURATION"

# Run the original entrypoint located at
source /usr/local/bin/docker-entrypoint.sh rabbitmq-server
