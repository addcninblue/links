defmodule LinksWeb.PageController do
  use LinksWeb, :controller

  def get_page(conn, %{"path" => path}) do
    redirect(conn, external: GDrive.Worker.get_path(path))
  end

  def get_default(conn, _params) do
    redirect(conn, external: GDrive.Worker.get_default())
  end

  def refresh(conn, _params) do
    render(conn, "index.json", %{page: GDrive.Worker.refresh_paths()})
  end
end
