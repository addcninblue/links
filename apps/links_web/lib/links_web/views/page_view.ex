defmodule LinksWeb.PageView do
  use LinksWeb, :view

  def render("index.json", %{page: page}) do
    page
  end
end
