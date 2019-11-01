# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

config :links_web, LinksWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE") # secret_key_base

# Defines default endpoint when nothing matches
config :gdrive, GDrive.Worker,
  default_site: System.fetch_env!("DEFAULT_SITE"),
  spreadsheet_key: System.fetch_env!("SPREADSHEET_KEY"),
  sheet_names: System.fetch_env!("SHEET_NAMES")

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
config :links_web, LinksWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
