# Use Python base image
FROM python:3.10

# Set the working directory inside the container
WORKDIR /app

# Copy the project files
COPY . .

# Ensure submodules are initialized
RUN git submodule update --init --recursive

# Install dependencies
RUN make install && make setup && make migrate && make build-db && make hasura-apply

# Expose port 8000 (default for PokeAPI)
EXPOSE 8000

# Start the API
CMD ["make", "serve"]
