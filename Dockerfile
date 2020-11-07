ARG SA_PASSWORD

ARG VERSION=2017-GDR-ubuntu
FROM mcr.microsoft.com/mssql/server:${VERSION} AS gdrUbuntu
ENV ACCEPT_EULA=Y
ADD ./migrations /migrations
ARG SA_PASSWORD
ARG WITH_EXAMPLE_DATA=false
ARG FROM_BACKUP=false
WORKDIR /migrations
RUN ( /opt/mssql/bin/sqlservr --accept-eula & ) | grep -q "Service Broker manager has started" \
    && /migrations/applyBackup.sh ${SA_PASSWORD} ${WITH_EXAMPLE_DATA} ${FROM_BACKUP} \
    && pkill sqlservr 
EXPOSE 1433/tcp