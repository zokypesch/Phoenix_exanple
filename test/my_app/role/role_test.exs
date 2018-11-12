defmodule MyApp.RoleTest do
  use MyApp.DataCase

  alias MyApp.Role

  describe "roles" do
    alias MyApp.Role.Rule

    @valid_attrs %{display_name: "some display_name", name: "some name"}
    @update_attrs %{display_name: "some updated display_name", name: "some updated name"}
    @invalid_attrs %{display_name: nil, name: nil}

    def rule_fixture(attrs \\ %{}) do
      {:ok, rule} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Role.create_rule()

      rule
    end

    test "list_roles/0 returns all roles" do
      rule = rule_fixture()
      assert Role.list_roles() == [rule]
    end

    test "get_rule!/1 returns the rule with given id" do
      rule = rule_fixture()
      assert Role.get_rule!(rule.id) == rule
    end

    test "create_rule/1 with valid data creates a rule" do
      assert {:ok, %Rule{} = rule} = Role.create_rule(@valid_attrs)
      assert rule.display_name == "some display_name"
      assert rule.name == "some name"
    end

    test "create_rule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Role.create_rule(@invalid_attrs)
    end

    test "update_rule/2 with valid data updates the rule" do
      rule = rule_fixture()
      assert {:ok, rule} = Role.update_rule(rule, @update_attrs)
      assert %Rule{} = rule
      assert rule.display_name == "some updated display_name"
      assert rule.name == "some updated name"
    end

    test "update_rule/2 with invalid data returns error changeset" do
      rule = rule_fixture()
      assert {:error, %Ecto.Changeset{}} = Role.update_rule(rule, @invalid_attrs)
      assert rule == Role.get_rule!(rule.id)
    end

    test "delete_rule/1 deletes the rule" do
      rule = rule_fixture()
      assert {:ok, %Rule{}} = Role.delete_rule(rule)
      assert_raise Ecto.NoResultsError, fn -> Role.get_rule!(rule.id) end
    end

    test "change_rule/1 returns a rule changeset" do
      rule = rule_fixture()
      assert %Ecto.Changeset{} = Role.change_rule(rule)
    end
  end
end
