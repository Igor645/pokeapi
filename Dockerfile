# Use Python base image
FROM python:3.10

# Set the working directory inside the container
WORKDIR /app

# Copy the project files
COPY . .

# Ensure submodules are initialized
RUN rm -rf data/v2 && git clone --depth 1 --recurse-submodules https://github.com/PokeAPI/pokeapi.git /app/temp_pokeapi \
    && cp -r /app/temp_pokeapi/data/v2 /app/data/v2 \
    && rm -rf /app/temp_pokeapi

# Install dependencies
RUN make install && make setup && make migrate && make build-db && make hasura-apply

# Expose port 8000 (default for PokeAPI)
EXPOSE 8000

# Start the API
CMD ["make", "serve"]
