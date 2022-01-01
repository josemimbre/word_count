FROM elixir:1.13.0-alpine AS builder
RUN apk add --update git && addgroup -S app --gid 2000 && adduser -S app -G app --uid 2000 --home /app

USER app
WORKDIR /app
RUN mix local.hex --force; mix local.rebar --force
ENV MIX_ENV=prod

# For development purposes those can be used to reduce steps in the build
# COPY mix.exs mix.lock ./
# COPY deps ./
# COPY lib ./

COPY --chown=2000:2000 . .
RUN mix deps.get; mix escript.build


FROM elixir:1.13.0-alpine
RUN apk --no-cache add ca-certificates && addgroup -S app --gid 2000 && adduser -S app -G app --uid 2000 --home /app
USER app
WORKDIR /app
COPY --chown=2000:2000 --from=builder /app/bin/word_count ./
ENTRYPOINT ["./word_count"]