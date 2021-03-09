defmodule Links.Worker do
  use GenServer
  NimbleCSV.define(Parser, separator: ",", escape: "\"")

  @sheet_names Application.fetch_env!(:links, :sheet_names)
  @default_site Application.fetch_env!(:links, :default_site)
  @spreadsheet_key Application.fetch_env!(:links, :spreadsheet_key)

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
    {:reply, Map.get(link_map, path_name, @default_site), link_map}
  end

  @impl true
  def handle_call({:get_default}, _from, link_map) do
    {:reply, @default_site, link_map}
  end

  @impl true
  def handle_call({:refresh_paths}, _from, _link_map) do
    {:reply, "ok", get_new_paths()}
  end

  defp get_new_paths() do
    sheet_names = @sheet_names

    sheet_names
    |> Enum.map(fn sheet_name -> get_new_path(sheet_name) end)
    |> Enum.reduce(%{}, fn x, acc -> Map.merge(x, acc) end)
  end

  defp get_new_path(sheet_name) do
    {:ok, pid} = GSS.Spreadsheet.Supervisor.spreadsheet(@spreadsheet_key, list_name: sheet_name)
    {:ok, data} = GSS.Spreadsheet.read_rows(pid, 1, 200, column_to: 5, pad_empty: true)
    data |> Enum.reduce(%{}, fn [shortlink, url | _], acc -> Map.put(acc, shortlink, url) end)
  end
end
