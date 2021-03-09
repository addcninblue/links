defmodule LinksWeb.Router do
  use LinksWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LinksWeb do
    get "/", PageController, :get_default
    get "/_refresh", PageController, :refresh
    get "/:path", PageController, :get_page
    get "/:path/download", PageController, :get_page_download
  end
end
