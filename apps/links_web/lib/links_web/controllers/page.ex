defmodule LinksWeb.PageController do
  use LinksWeb, :controller

  def get_page(conn, %{"path" => path}) do
    redirect(conn, external: Links.Worker.get_path(path))
  end

  def get_page_download(conn, %{"path" => path}) do
    "https://drive.google.com/file/d/" <> <<id::binary-size(33)>> <> "/view" <> rest =
      Links.Worker.get_path(path)

    redirect(conn,
      external: "https://drive.google.com/uc?export=download&id=#{id}"
    )
  end

  def get_default(conn, _params) do
    redirect(conn, external: Links.Worker.get_default())
  end

  def refresh(conn, _params) do
    render(conn, "index.json", %{page: Links.Worker.refresh_paths()})
  end
end
