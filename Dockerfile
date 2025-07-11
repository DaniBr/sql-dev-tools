FROM ubuntu:25.04
LABEL name="sql-dev-tools"
LABEL maintainer="Daniel Bronshtein"
LABEL version="0.1.3"
LABEL description="SQL development tools for various scenarios"
LABEL homepage="https://github.com/DaniBr/sql-dev-tools"
LABEL repository="https://github.com/DaniBr/sql-dev-tools"
LABEL license="MIT"

ARG TARGETARCH=amd64
RUN if [ "$TARGETARCH" = "amd64" ] || [ "$TARGETARCH" = "arm64" ]; then \
      echo "Building for architecture: $TARGETARCH"; \
    else \
      echo "Unsupported architecture: $TARGETARCH" && exit 1; \
    fi

# Install MySQL (cli), PostgreSQL (cli), and Python (for SQLFluff)
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    mysql-client \
    postgresql-client \
    curl

# Install SQLFluff
RUN rm /usr/lib/python3.*/EXTERNALLY-MANAGED
RUN pip3 install --no-cache-dir --root-user-action=ignore sqlfluff

# Install Task
RUN curl -sL https://taskfile.dev/install.sh | sh

# Install Atlas
RUN curl -sSf https://atlasgo.sh | sh

# Install Sqlc
RUN curl -sL https://github.com/sqlc-dev/sqlc/releases/download/v1.29.0/sqlc_1.29.0_linux_${TARGETARCH}.tar.gz | tar -xz -C /usr/local/bin sqlc

# Install Reflex
RUN curl -L -o reflex.tar.gz https://github.com/cespare/reflex/releases/download/v0.3.1/reflex_linux_${TARGETARCH}.tar.gz && \
    tar -xzf reflex.tar.gz && \
    mv reflex_linux_${TARGETARCH}/reflex /usr/bin/reflex && \
    chmod +x /usr/bin/reflex && \
    rm -r reflex*

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /sql
CMD ["reflex", "-s", "-g", "reflex.conf", "--", "reflex", "-c", "reflex.conf"]