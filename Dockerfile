FROM ubuntu:25.04
LABEL name="sql-dev-tools"
LABEL maintainer="Daniel Bronshtein"
LABEL version="0.1.1"
LABEL description="SQL development tools for various scenarios"
LABEL homepage="https://github.com/DaniBr/sql-dev-tools"
LABEL repository="https://github.com/DaniBr/sql-dev-tools"
LABEL license="MIT"

# packages: air(go\curl), task(go\snap\brew), sqlc(go\snap\brew?), atlas(curl\brew), SQLFluff (pip)
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip \
    mysql-client \
    postgresql-client \
    curl

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN rm /usr/lib/python3.*/EXTERNALLY-MANAGED

# Install SQLFluff
RUN pip3 install --no-cache-dir --root-user-action \
    sqlfluff

# Install Task
RUN curl -sL https://taskfile.dev/install.sh | sh

# Install sqlc
RUN curl -sL https://github.com/sqlc-dev/sqlc/releases/download/v1.29.0/sqlc_1.29.0_linux_amd64.tar.gz | \
    tar -xz -C /usr/local/bin sqlc

# Install Atlas
RUN curl -sSf https://atlasgo.sh | sh

# Install Air
RUN curl -sSfL https://raw.githubusercontent.com/cosmtrek/air/master/install.sh | sh

#COPY ./default-config /default-config
WORKDIR /sql
CMD ["air", "-c", "/sql/.air.toml"]
