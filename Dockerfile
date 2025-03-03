# Use Python base image
FROM python:3.10

# Install required system dependencies
RUN apt-get update && apt-get install -y git curl

# Set the working directory inside the container
WORKDIR /app

# Copy project files
COPY . /app

# Install Hasura CLI
RUN curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash

# Ensure Hasura CLI is in PATH
ENV PATH="/root/.hasura:$PATH"

# Install dependencies
RUN make install

# Run database migrations
RUN make setup && make migrate

# Build the database
RUN make build-db

# Start Hasura in the background
RUN docker compose up -d graphql-engine

# Apply Hasura metadata using make (which now waits for Hasura)
RUN make hasura-apply

# Expose port 8000 (default for PokeAPI)
EXPOSE 8000

# Start the API
CMD ["make", "serve"]
