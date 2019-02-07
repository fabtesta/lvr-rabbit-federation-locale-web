# RabbitMQ LVR RabbitMQ Locale-Web Federation
## Maintained by: [Fabio Testa](https://hub.docker.com/r/fabtesta/)

This is the Git repo of the [RabbitMQ LVR RabbitMQ "Locale-Web" Federation](https://hub.docker.com/r/fabtesta/lvr-rabbit-federation-locale-web) for [rabbitmq](https://hub.docker.com/_/rabbitmq/) (not to be confused with any official rabbitmq image provided by rabbitmq upstream).

### Running the image
#### 1st RabbitMQ "Locale"
~~~~
docker run -d --hostname my-federated-rabbit-locale \
--name my-federated-rabbit-locale \
-e RABBITMQ_FEDERATED_HOST=my-federated-rabbit-web \
-e RABBITMQ_FEDERATION_UPSTREAM_NAME=from-locale-to-web \
-e RABBITMQ_FEDERATION_POLICY_PATTERN=from-locale-to-web-policy-pattern \
-p 15671:15672 -p 15672:15672 -p 5671:5671 -p 5672:5672 \
fabtesta/lvr-rabbit-federation-locale-web:latest
~~~~

#### 2nd RabbitMQ "Web"
~~~~
docker run -d --hostname my-federated-rabbit-web \
--name my-federated-rabbit-web \
-e RABBITMQ_FEDERATED_HOST=my-federated-rabbit-locale \
-e RABBITMQ_FEDERATION_UPSTREAM_NAME=from-web-to-locale \
-e RABBITMQ_FEDERATION_POLICY_PATTERN=from-web-to-locale-policy-pattern \
-p 15673:15672 -p 15674:15672 -p 5673:5671 -p 5674:5672 \
fabtesta/lvr-rabbit-federation-locale-web:latest
~~~~

### Docker-Compose
Start from the docker-compose yaml sample file committed in this repo or clone it.
If you'd like to keep persistent volumes, uncomment volumes lines.
~~~~
#volumes:
   #- rabbitweb_data:/var/lib/rabbitmq
....
#volumes:
   #- rabbitlocal_data:/var/lib/rabbitmq
....
~~~~

and then run
~~~~
docker-compose up -d --build
~~~~
