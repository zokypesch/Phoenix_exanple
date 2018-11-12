defmodule MyAppWeb.Views.Api.Global.GlobalView do
  def render("200.json", %{message: message}) do
    %{
      status: :ok,
      message: message
    }
  end
end
