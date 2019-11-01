# Links

A simple shortlink server inspired by [CS 61A Link Server](https://github.com/Cal-CS-61A-Staff/links). It's written in [Elixir](https://elixir-lang.org) with [Phoenix](https://phoenixframework.org).

Tests are in progress.

## Usage
1. Create a spreadsheet on Google Drive.
  - Use the first column as shortlink and second as link. The first row in the spreadsheet will not be used (title row).
  - Use public sharing for the spreadsheet.
  - Copy the spreadsheet key as well as the sheet names. The relevant url is `https://docs.google.com/spreadsheets/d/1kA8o_QyoVeXkhu9PZZoZSJUy1xRczvNDPAeYMS_Cfy8/export?format=csv&id=#{spreadsheet_key}&gid=#{sheet_name}`
2. Clone and build the elixir app.
  - Get dependencies: `mix deps.get`
  - Build: `DEFAULT_SITE=__YOUR_SITE__ SPREADSHEET_KEY=__YOUR_SPREADSHEET__ SHEET_NAMES=__COMMA_SEPARATED_SHEET_NAMES__ MIX_ENV=prod mix distillery.release --env=prod`
  - Run: `sudo _build/prod/rel/links/bin/links foreground`
