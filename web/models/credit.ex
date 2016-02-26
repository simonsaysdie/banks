defmodule Dinero.Credit do
  use Dinero.Web, :model

  schema "credits" do
    belongs_to :bank, Dinero.Bank
    field :name, :string
    field :requirements, :string
    field :min_age, :integer
    field :max_age, :integer
    field :promo, :boolean, default: false
    field :insurance, :boolean, default: false
    field :cat, :integer
    field :annual, :integer
    field :additional_cards, :boolean, default: false
    field :min_income, :integer

    timestamps
  end

  @required_fields ~w(name requirements min_age max_age promo insurance cat annual additional_cards min_income bank_id)
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
