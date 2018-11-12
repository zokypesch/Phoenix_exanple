defmodule MyAppWeb.RuleControllerTest do
  use MyAppWeb.ConnCase

  alias MyApp.Role
  alias MyApp.Role.Rule

  @create_attrs %{display_name: "some display_name", name: "some name"}
  @update_attrs %{display_name: "some updated display_name", name: "some updated name"}
  @invalid_attrs %{display_name: nil, name: nil}

  def fixture(:rule) do
    {:ok, rule} = Role.create_rule(@create_attrs)
    rule
  end

  setup %{conn: conn} do
    {:ok, conn: conn, current_user: current_user} = MyApp.Auth.Test.setup_current_user(conn)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), current_user: current_user}
  end

  describe "index" do
    test "lists all roles", %{conn: conn} do
      conn = get conn, rule_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create rule" do
    test "renders rule when data is valid", %{conn: conn} do
      conn = post conn, rule_path(conn, :create), rule: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, rule_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "display_name" => "some display_name",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, rule_path(conn, :create), rule: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update rule" do
    setup [:create_rule]

    test "renders rule when data is valid", %{conn: conn, rule: %Rule{id: id} = rule} do
      conn = put conn, rule_path(conn, :update, rule), rule: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, rule_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "display_name" => "some updated display_name",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, rule: rule} do
      conn = put conn, rule_path(conn, :update, rule), rule: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete rule" do
    setup [:create_rule]

    test "deletes chosen rule", %{conn: conn, rule: rule} do
      conn = delete conn, rule_path(conn, :delete, rule)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, rule_path(conn, :show, rule)
      end
    end
  end

  defp create_rule(_) do
    rule = fixture(:rule)
    {:ok, rule: rule}
  end
end
