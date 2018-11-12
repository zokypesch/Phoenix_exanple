defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :api do
    # plug CORSPlug, origin: "http://localhost:3000/"
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  pipeline :api_auth do
    plug(:ensure_authenticated)
  end

  # old
  # scope "/api", MyAppWeb do
  #   pipe_through :api
  #   resources "/users", UserController, except: [:new, :edit]
  #   post("/users/sign_in", UserController, :sign_in)
  # end

  scope "/api", MyAppWeb do
    pipe_through(:api)
    post("/users/sign_in", UserController, :sign_in)
    options   "/users/sign_in", UserController, :options
    get("/users/sign_out", UserController, :sign_out)
  end

  scope "/api", MyAppWeb do
    pipe_through([:api, :api_auth])
    resources("/users", UserController, except: [:new, :edit])
    resources("/modules", ModulController)
    resources("/role_permition", RolePermController)
    resources("/roles", RuleController)
    resources("/perms", PermController)
    resources("/perms_code", PermCodeController)
  end

  # Plug function
  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> render(MyAppWeb.Views.Api.Global.ErrorView, "401.json", message: "Unauthenticated user")
      |> halt()
    end
  end

end
