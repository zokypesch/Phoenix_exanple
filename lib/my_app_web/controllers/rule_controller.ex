defmodule MyAppWeb.RuleController do
  use MyAppWeb, :controller

  alias MyApp.Role
  alias MyApp.Role.Rule

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    roles = Role.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"rule" => rule_params}) do
    with {:ok, %Rule{} = rule} <- Role.create_rule(rule_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", rule_path(conn, :show, rule))
      |> render("show.json", rule: rule)
    end
  end

  def show(conn, %{"id" => id}) do
    rule = Role.get_rule!(id)
    render(conn, "show.json", rule: rule)
  end

  def update(conn, %{"id" => id, "rule" => rule_params}) do
    rule = Role.get_rule!(id)

    with {:ok, %Rule{} = rule} <- Role.update_rule(rule, rule_params) do
      render(conn, "show.json", rule: rule)
    end
  end

  def delete(conn, %{"id" => id}) do
    rule = Role.get_rule!(id)
    with {:ok, %Rule{}} <- Role.delete_rule(rule) do
      send_resp(conn, :no_content, "")
    end
  end
end
