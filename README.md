# SQL Development Tools

A Docker image containing a suite of SQL development tools for working with various databases. This image includes tools for SQL linting, formatting, schema migration, and code generation, along with database clients for MySQL and PostgreSQL.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

- **Name**: sql-dev-tools
- **Version**: 0.1.2
- **Maintainer**: Daniel Bronshtein
- **Homepage**: [https://github.com/DaniBr/sql-dev-tools](https://github.com/DaniBr/sql-dev-tools)
- **License**: MIT

This Docker image is built on `ubuntu:25.04` and provides a development environment with the following tools:
- **SQLFluff**: SQL linter and auto-formatter.
- **atlas**: Database schema migration and inspection tool.
- **sqlc**: Generates type-safe code ([Go](https://github.com/sqlc-dev/sqlc), [Python](https://github.com/sqlc-dev/sqlc-gen-python), [TypeScript](https://github.com/sqlc-dev/sqlc-gen-typescript)) from SQL queries.
- **task**: Task runner for automating workflows.
- **reflex**: Live-reloading.
- **mysql-client**: CLI for MySQL databases.
- **postgresql-client**: CLI for PostgreSQL databases.

## Prerequisites

- [Docker](https://www.docker.com/get-started) or [Podman](https://podman.io/get-started) installed on your system.
- A working knowledge of SQL and database development.

## Installation

1. **Pull the Image** (if published to a registry, e.g., Docker Hub):
   ```bash
   docker pull danibron/sql-dev-tools:0.1.2
   ```

2. **Or Build the Image Locally**:
   Clone the repository and build the Docker image:
   ```bash
   git clone https://github.com/DaniBr/sql-dev-tools.git
   cd sql-dev-tools
   docker build -t sql-dev-tools:0.1.2 .
   ```

## Usage

### Running the Container

Start the container with the default command,
which is `reflex -s -g reflex.conf -- reflex -c reflex.conf` ([see here](https://github.com/cespare/reflex?tab=readme-ov-file#configuration-file)):
```bash
docker run -it -v $(pwd)/sql:/sql sql-dev-tools:0.1.2
```

- `-v $(pwd)/sql:/sql`: Mounts a local `sql` directory to `/sql` in the container for your SQL files and `reflex.conf` configuration.

### Configuration

- The image includes a `/default-config` directory with default settings.
- To use a custom `reflex` configuration, ensure a `reflex.conf` file is present in your mounted `/sql` directory.
- Example `reflex.conf`:
  ```bash
  -r 'schema\.sql$' --start-service -- task update_schema
  ```

### Example Workflow

1. **Lint SQL Files** with SQLFluff:
   ```bash
   docker run -v $(pwd)/sql:/sql sql-dev-tools:0.1.2 sqlfluff lint /sql/queries.sql
   ```

2. **Manage Schema Migrations** with atlas:
   ```bash
   docker run -v $(pwd)/sql:/sql sql-dev-tools:0.1.2 atlas schema apply --url "mysql://user:pass@host:3306/database_name" --file /sql/schema.sql
   ```

3. **Generate Go Code** with sqlc:
   ```bash
   docker run -v $(pwd)/sql:/sql sql-dev-tools:0.1.2 sqlc generate
   ```

4. **Update procedures, functions, triggers** with database client:
    ```bash
    psql -d $DATABASE_URL -f my-functions.sql
    mysql $DATABASE_NAME --user=$DATABASE_USER < my-functions.sql
    ```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on the [GitHub repository](https://github.com/DaniBr/sql-dev-tools).

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m 'Add your feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For questions or support, please open an issue on the [GitHub repository](https://github.com/DaniBr/sql-dev-tools) or contact the maintainer.

_ReadMe created using Grok_