defmodule EsphoenixGeoapi.Collection do
  @derive {Jason.Encoder, only: [:id, :data]}

  alias EsphoenixGeoapi.Collection

  defstruct id: nil, data: %{}

  def list_collections() do
    EsphoenixGeoapi.ElasticsearchCluster.search("my_index", %{})
  end

  def get_collection!(id) do
    case EsphoenixGeoapi.ElasticsearchCluster.get("my_index", id) do
      {:ok, %{"_source" => data}} -> %Collection{id: id, data: data}
      _ -> raise "Collection not found"
    end
  end

  def create_collection(data) do
    id = Integer.to_string(:erlang.unique_integer([positive: true]))
    EsphoenixGeoapi.ElasticsearchCluster.index("my_index", id, data)
    %Collection{id: id, data: data}
  end

  def update_collection(collection, data) do
    EsphoenixGeoapi.ElasticsearchCluster.update("my_index", collection.id, data)
    %Collection{id: collection.id, data: data}
  end

  def delete_collection(collection) do
    EsphoenixGeoapi.ElasticsearchCluster.delete("my_index", collection.id)
    :ok
  end
end
