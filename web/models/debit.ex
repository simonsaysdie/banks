defmodule Dinero.Debit do
  use Dinero.Web, :model

  schema "debits" do
    field :name, :string
    field :requirements, :string
    field :opening, :integer
    field :max_age, :integer
    field :promo, :boolean, default: false
    field :insurance, :boolean, default: false

    timestamps
  end

  @required_fields ~w(name requirements opening max_age promo insurance)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
