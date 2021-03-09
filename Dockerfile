FROM elixir:1.11-alpine

COPY . /app

WORKDIR /app

ENV MIX_ENV=prod

RUN mix local.hex --force && \
    mix local.rebar --force

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

RUN mix release --overwrite

CMD ["_build/prod/rel/links_umbrella/bin/links_umbrella", "start"]
