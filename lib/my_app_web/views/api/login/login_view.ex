defmodule MyAppWeb.Views.Api.Login.LoginView do
  def render("sign_in.json", %{user: user}) do
    %{
      data: %{
        user: %{
          id: user.id,
          email: user.email
        }
      }
    }
  end
end
