defmodule MyAppWeb.RuleView do
  use MyAppWeb, :view
  alias MyAppWeb.RuleView

  def render("index.json", %{roles: roles}) do
    %{data: render_many(roles, RuleView, "rule.json")}
  end

  def render("show.json", %{rule: rule}) do
    %{data: render_one(rule, RuleView, "rule.json")}
  end

  def render("rule.json", %{rule: rule}) do
    %{id: rule.id,
      name: rule.name,
      display_name: rule.display_name}
  end
end
