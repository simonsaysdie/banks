defmodule Dinero.CreditTest do
  use Dinero.ModelCase

  alias Dinero.Credit

  @valid_attrs %{additional_cards: true, annual: 42, cat: 42, insurance: true, max_age: 42, min_age: 42, min_income: 42, name: "some content", opening: 42, promo: true, requirements: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Credit.changeset(%Credit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Credit.changeset(%Credit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
