defmodule EsphoenixGeoapiWeb.CollectionsView do
  use EsphoenixGeoapiWeb, :view
  alias EsphoenixGeoapiWeb.CollectionsView

  def render("index.json", %{collections: collections}) do
    %{data: render_many(collections, CollectionsView, "collections.json")}
  end

  def render("show.json", %{collections: collections}) do
    %{data: render_one(collections, CollectionsView, "collections.json")}
  end

  def render("collections.json", %{collections: collections}) do
    %{
      id: collections.id,
      id: collections.id,
      data: collections.data
    }
  end
end
