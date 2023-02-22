# Use the official Elixir image as the base image
FROM elixir:1.14.3-alpine AS build

# Install build dependencies
RUN apk add --update --no-cache build-base

# Set the working directory for the container
WORKDIR /app

# Install Hex package manager
RUN mix local.hex --force && \
    mix local.rebar --force

# Install Phoenix framework
RUN mix archive.install --force hex phx_new

# Copy over the project files
COPY . .

# Install dependencies
RUN mix deps.get

# Compile the application
RUN mix compile

# Create a release build
RUN MIX_ENV=prod mix release

# App Directory
ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# App Port
EXPOSE 4000

# Default Command
CMD ["mix", "phx.server"]
