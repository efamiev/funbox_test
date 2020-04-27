FROM elixir:latest

COPY ./ /home/app/funbox

WORKDIR /home/app/funbox

RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get