defmodule EsphoenixGeoapiWeb.CollectionsControllerTest do
  use EsphoenixGeoapiWeb.ConnCase

  import EsphoenixGeoapi.CollectionFixtures

  alias EsphoenixGeoapi.Collection.Collections

  @create_attrs %{
    data: %{},
    id: 42
  }
  @update_attrs %{
    data: %{},
    id: 43
  }
  @invalid_attrs %{data: nil, id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all collections", %{conn: conn} do
      conn = get(conn, Routes.collections_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create collections" do
    test "renders collections when data is valid", %{conn: conn} do
      conn = post(conn, Routes.collections_path(conn, :create), collections: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.collections_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "data" => %{},
               "id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.collections_path(conn, :create), collections: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update collections" do
    setup [:create_collections]

    test "renders collections when data is valid", %{conn: conn, collections: %Collections{id: id} = collections} do
      conn = put(conn, Routes.collections_path(conn, :update, collections), collections: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.collections_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "data" => %{},
               "id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, collections: collections} do
      conn = put(conn, Routes.collections_path(conn, :update, collections), collections: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete collections" do
    setup [:create_collections]

    test "deletes chosen collections", %{conn: conn, collections: collections} do
      conn = delete(conn, Routes.collections_path(conn, :delete, collections))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.collections_path(conn, :show, collections))
      end
    end
  end

  defp create_collections(_) do
    collections = collections_fixture()
    %{collections: collections}
  end
end
