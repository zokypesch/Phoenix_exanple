defmodule MyAppWeb.UserController do
  use MyAppWeb, :controller

  alias MyApp.Auth
  alias MyApp.Auth.User

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Auth.get_user!(id)

    with {:ok, %User{} = user} <- Auth.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    with {:ok, %User{}} <- Auth.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  #added by triadi
  # def sign_in(conn, %{"email" => email, "password" => password}) do
  #   case MyApp.Auth.authenticate_user(email, password) do
  #     {:ok, user} ->
  #       conn
  #       |>put_status(:ok)
  #       |>render(MyAppWeb.Views.Api.Login.LoginView, "sign_in.json", user: user)
  #     {:error, message} ->
  #       conn
  #       |>put_status(:unauthorized)
  #       |>render(MyAppWeb.Views.Api.Global.ErrorView, "401.json", message: message)
  #   end
  # end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case MyApp.Auth.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_status(:ok)
        |> render(MyAppWeb.Views.Api.Login.LoginView, "sign_in.json", user: user)

      {:error, message} ->
        conn
        |> delete_session(:current_user_id)
        |> put_status(:unauthorized)
        |> render(MyAppWeb.Views.Api.Global.ErrorView, "401.json", message: message)
    end
  end

  def sign_out(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_status(:ok)
    |> render(MyAppWeb.Views.Api.Global.GlobalView, "200.json", message: "successfully logout")
  end

  def login_w_credential(conn, %{"email" => email, "password" => password}) do
    conn
    |>
  end

end
