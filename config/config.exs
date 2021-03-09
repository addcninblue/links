# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :links_web,
  generators: [context_app: :links]

# Configures the endpoint
config :links_web, LinksWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aGsjtolQE/pqveD8O/v7hMN16M7tDjzu7z2KkpNCKmvmTHMmkr8S3uVvqk7fFVqA",
  render_errors: [view: LinksWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Links.PubSub,
  live_view: [signing_salt: "n8cmO+LY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :elixir_google_spreadsheets, :client,
  request_workers: 50,
  max_demand: 100,
  max_interval: :timer.minutes(1),
  interval: 100

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
import_config "secrets.exs"

config :goth, json: "google-credentials.json" |> File.read!()
