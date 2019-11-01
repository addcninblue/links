defmodule LinksWeb.Router do
  use LinksWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LinksWeb do
    pipe_through :browser

    get "/", PageController, :get_default
    get "/_refresh", PageController, :refresh
    get "/:path", PageController, :get_page
  end

  # Other scopes may use custom stacks.
  # scope "/api", LinksWeb do
  #   pipe_through :api
  # end
end
