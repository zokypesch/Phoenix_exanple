defmodule MyAppWeb.PermControllerTest do
  use MyAppWeb.ConnCase

  alias MyApp.Permition
  alias MyApp.Permition.Perm

  @create_attrs %{module_id: 42, name: "some name", perrmission_code: "some perrmission_code"}
  @update_attrs %{module_id: 43, name: "some updated name", perrmission_code: "some updated perrmission_code"}
  @invalid_attrs %{module_id: nil, name: nil, perrmission_code: nil}

  def fixture(:perm) do
    {:ok, perm} = Permition.create_perm(@create_attrs)
    perm
  end

  setup %{conn: conn} do
    {:ok, conn: conn, current_user: current_user} = MyApp.Auth.Test.setup_current_user(conn)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), current_user: current_user}
  end

  describe "index" do
    test "lists all permitions", %{conn: conn} do
      conn = get conn, perm_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create perm" do
    test "renders perm when data is valid", %{conn: conn} do
      conn = post conn, perm_path(conn, :create), perm: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, perm_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "module_id" => 42,
        "name" => "some name",
        "perrmission_code" => "some perrmission_code"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, perm_path(conn, :create), perm: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update perm" do
    setup [:create_perm]

    test "renders perm when data is valid", %{conn: conn, perm: %Perm{id: id} = perm} do
      conn = put conn, perm_path(conn, :update, perm), perm: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, perm_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "module_id" => 43,
        "name" => "some updated name",
        "perrmission_code" => "some updated perrmission_code"}
    end

    test "renders errors when data is invalid", %{conn: conn, perm: perm} do
      conn = put conn, perm_path(conn, :update, perm), perm: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete perm" do
    setup [:create_perm]

    test "deletes chosen perm", %{conn: conn, perm: perm} do
      conn = delete conn, perm_path(conn, :delete, perm)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, perm_path(conn, :show, perm)
      end
    end
  end

  defp create_perm(_) do
    perm = fixture(:perm)
    {:ok, perm: perm}
  end
end
