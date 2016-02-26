defmodule Dinero.DebitTest do
  use Dinero.ModelCase

  alias Dinero.Debit

  @valid_attrs %{insurance: true, max_age: 42, name: "some content", opening: 42, promo: true, requirements: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Debit.changeset(%Debit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Debit.changeset(%Debit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
