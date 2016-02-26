defmodule Dinero.BankTest do
  use Dinero.ModelCase

  alias Dinero.Bank

  @valid_attrs %{name: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bank.changeset(%Bank{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bank.changeset(%Bank{}, @invalid_attrs)
    refute changeset.valid?
  end
end
