import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :links_web, LinksWeb.Endpoint,
  http: [port: 4002],
  server: false

config :links,
  google_application_credentials: "./google-credentials.json"

# Print only warnings and errors during test
config :logger, level: :warn
