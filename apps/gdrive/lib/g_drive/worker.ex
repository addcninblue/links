defmodule GDrive.Worker do
  use GenServer
  NimbleCSV.define(Parser, separator: ",", escape: "\"")

  # Client

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def get_path(path_name) do
    GenServer.call(__MODULE__, {:get_path, path_name})
  end

  def get_default() do
    GenServer.call(__MODULE__, {:get_default})
  end

  def refresh_paths() do
    GenServer.call(__MODULE__, {:refresh_paths})
  end

  ## Callbacks

  @impl true
  def init(_default_map) do
    HTTPoison.start()
    {:ok, get_new_paths()}
  end

  @impl true
  def handle_call({:get_path, path_name}, _from, link_map) do
    {:reply,
     Map.get(link_map, path_name, Application.get_env(:gdrive, GDrive.Worker)[:default_site]),
     link_map}
  end

  @impl true
  def handle_call({:get_default}, _from, link_map) do
    {:reply,
     Application.get_env(:gdrive, GDrive.Worker)[:default_site],
     link_map}
  end

  @impl true
  def handle_call({:refresh_paths}, _from, _link_map) do
    {:reply, "ok", get_new_paths()}
  end

  defp get_new_paths() do
    sheet_names = Application.get_env(:gdrive, GDrive.Worker)[:sheet_names] |> String.split(",")

    sheet_names
    |> Enum.map(fn sheet_name -> get_new_path(sheet_name) end)
    |> Enum.reduce(%{}, fn x, acc -> Map.merge(x, acc) end)
  end

  defp get_new_path(sheet_name) do
    spreadsheet_key = Application.get_env(:gdrive, GDrive.Worker)[:spreadsheet_key]

    url =
      "https://docs.google.com/spreadsheets/d/1kA8o_QyoVeXkhu9PZZoZSJUy1xRczvNDPAeYMS_Cfy8/export?format=csv&id=#{
        spreadsheet_key
      }&gid=#{sheet_name}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Parser.parse_string(skip_headers: true)
        |> Enum.reduce(%{}, fn [shortlink, url | _], acc -> Map.put(acc, shortlink, url) end)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found")
        %{}

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
        %{}
    end
  end
end
