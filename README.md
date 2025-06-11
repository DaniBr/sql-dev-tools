# SQL Development Tools

A Docker image containing a suite of SQL development tools for working with various databases. This image includes tools for SQL linting, formatting, schema migration, and code generation, along with database clients for MySQL and PostgreSQL.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Version: 0.1](https://img.shields.io/badge/Version-0.1-blue)

## Overview

- **Name**: sql-dev-tools
- **Version**: 0.1
- **Maintainer**: Daniel Bronshtein
- **Homepage**: [https://github.com/DaniBr/sql-dev-tools](https://github.com/DaniBr/sql-dev-tools)
- **License**: MIT

This Docker image is built on `ubuntu:25.04` and provides a development environment with the following tools:
- **air**: Live-reloading for Go applications.
- **task**: Task runner for automating workflows.
- **sqlc**: Generates type-safe code from SQL queries.
- **atlas**: Database schema migration and inspection tool.
- **SQLFluff**: SQL linter and auto-formatter.
- **sql-formatter**: JavaScript-based SQL formatter.
- **mysql-client**: CLI for MySQL databases.
- **postgresql-client**: CLI for PostgreSQL databases.

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your system.
- A working knowledge of SQL and database development.

## Installation

1. **Pull the Image** (if published to a registry, e.g., Docker Hub):
   ```bash
   docker pull danibron/sql-dev-tools:0.1
   ```

2. **Or Build the Image Locally**:
   Clone the repository and build the Docker image:
   ```bash
   git clone https://github.com/DaniBr/sql-dev-tools.git
   cd sql-dev-tools
   docker build -t sql-dev-tools:0.1 .
   ```

## Usage

### Running the Container

Start the container with the default command (`air` for live-reloading):
```bash
docker run -it -p 8888:8888 -v $(pwd)/sql:/sql sql-dev-tools:0.1
```

- `-p 8888:8888`: Maps port 8888 for `air` or other web-based tools.
- `-v $(pwd)/sql:/sql`: Mounts a local `sql` directory to `/sql` in the container for your SQL files and `.air.toml` configuration.

### Example Workflow

1. **Format SQL Queries** with sql-formatter:
   ```bash
   docker run -v $(pwd)/sql:/sql sql-dev-tools:0.1 sql-formatter /sql/queries.sql
   ```

2. **Lint SQL Files** with SQLFluff:
   ```bash
   docker run -v $(pwd)/sql:/sql sql-dev-tools:0.1 sqlfluff lint /sql/queries.sql
   ```

3. **Manage Schema Migrations** with atlas:
   ```bash
   docker run -v $(pwd)/sql:/sql sql-dev-tools:0.1 atlas schema apply --url "mysql://user:pass@host:3306/database_name" --file /sql/schema.sql
   ```

4. **Generate Go Code** with sqlc:
   ```bash
   docker run -v $(pwd)/sql:/sql sql-dev-tools:0.1 sqlc generate
   ```

5. **Run Tasks** with task:
   ```bash
   docker run -v $(pwd)/sql:/sql sql-dev-tools:0.1 task build
   ```

6. **Update procedures, functions, triggers** with database client:
    ```bash
    psql -d $DATABASE_URL -f my-functions.sql
    mysql $DATABASE_NAME --user=$DATABASE_USER < my-functions.sql
    ```

### Configuration

- The image includes a `/default-config` directory with default settings.
- To use a custom `air` configuration, ensure a `.air.toml` file is present in your mounted `/sql` directory.
- Example `.air.toml`:
  ```toml
  root = "."
  tmp_dir = "tmp"
  [build]
  cmd = "go build -o ./tmp/main ."
  bin = "tmp/main"
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

Created using Grok