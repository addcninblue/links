# Links

A simple shortlink server inspired by [CS 61A Link Server](https://github.com/Cal-CS-61A-Staff/links). It's written in [Elixir](https://elixir-lang.org) with [Phoenix](https://phoenixframework.org).

Tests are in progress.

## Usage
1. Create a spreadsheet on Google Drive.
  - Use the first column as shortlink and second as link. The first row in the spreadsheet will not be used (title row).
  - Use public sharing for the spreadsheet.
  - Copy the spreadsheet key as well as the sheet names. The relevant url is `https://docs.google.com/spreadsheets/d/__LINK_ID__/export?format=csv&id=#{spreadsheet_key}&gid=#{sheet_name}`
2. Create a `config/secrets.exs` with the following contents:
```
config :links,
  default_site: "YOUR_DEFAULT_SITE",
  spreadsheet_key: "YOUR_GOOGLE_SHEET_KEY",
  sheet_names: ["sheet", "names", "you", "need"]
```
3. Clone and build the elixir app.
  - Get dependencies: `mix deps.get`
  - Build: `MIX_ENV=prod mix release --overwrite`
  - Run: `PORT=80 -e SECRET_KEY_BASE="$(mix phx.gen.secret)" _build/prod/rel/links_web/bin/links_web start`
