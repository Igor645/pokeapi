# Use Python base image
FROM python:3.10

# Install required system dependencies (Git, curl, etc.)
RUN apt-get update && apt-get install -y git curl

# Set the working directory inside the container
WORKDIR /app

# Copy the project files
COPY . .
 
# Ensure submodules are initialized
RUN rm -rf data/v2 && git clone --depth 1 --recurse-submodules https://github.com/PokeAPI/pokeapi.git /app/temp_pokeapi \
    && cp -r /app/temp_pokeapi/data/v2 /app/data/v2 \
    && rm -rf /app/temp_pokeapi

# Install Hasura CLI
RUN curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash

# Ensure Hasura CLI is in PATH
ENV PATH="/root/.hasura:$PATH"

# Install dependencies
RUN make install

# Run database migrations
RUN make setup && make migrate --noinput

# Build the database
RUN make build-db

# Apply Hasura metadata
RUN make hasura-apply

# Expose port 8000 (default for PokeAPI)
EXPOSE 8000

# Start the API
CMD ["make", "serve"]
