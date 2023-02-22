# defmodule EsphoenixGeoapi.Collection do
#   defstruct id: nil, data: nil
# end

defmodule EsphoenixGeoapi.Collection.Collections do
  defstruct id: nil, data: nil
end


defmodule EsphoenixGeoapiWeb.CollectionsController do
  use EsphoenixGeoapiWeb, :controller

  alias EsphoenixGeoapi.Collection
  alias EsphoenixGeoapi.Collection.Collections

  action_fallback EsphoenixGeoapiWeb.FallbackController

  def index(conn, _params) do
    collections = Collection.list_collections()
    render(conn, "index.json", collections: collections)
  end

  def create(conn, %{"collections" => collections_params}) do
    with {:ok, %Collections{} = collections} <- Collection.create_collections(collections_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.collections_path(conn, :show, collections))
      |> render("show.json", collections: collections)
    end
  end

  def show(conn, %{"id" => id}) do
    collections = Collection.get_collections!(id)
    render(conn, "show.json", collections: collections)
  end

  def update(conn, %{"id" => id, "collections" => collections_params}) do
    collections = Collection.get_collections!(id)

    with {:ok, %Collections{} = collections} <- Collection.update_collections(collections, collections_params) do
      render(conn, "show.json", collections: collections)
    end
  end

  def delete(conn, %{"id" => id}) do
    collections = Collection.get_collections!(id)

    with {:ok, %Collections{}} <- Collection.delete_collections(collections) do
      send_resp(conn, :no_content, "")
    end
  end
end
