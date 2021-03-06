defmodule Dinero.CreditController do
  use Dinero.Web, :controller

  alias Dinero.{Credit, Bank}

  plug :scrub_params, "credit" when action in [:create, :update]

  def index(conn, _params) do
    credits = Repo.all(Credit)
    render(conn, "index.html", credits: credits)
  end

  def public_index(conn, _params) do
    credits = Credit.all_with_banks
    banks = Bank.all_with_cards
    render(conn, "public_index.html", credits: credits, banks: banks)
  end

  def by_bank(conn, %{"credit_terms" => %{"bank_id" => bank_id, "min_income" => min_income}}) do
    credits = Credit.by_bank_with_income(bank_id, min_income)
    banks = Bank.all_with_cards
    render(conn, "public_index.html", credits: credits, banks: banks)
  end

  def new(conn, _params) do
    changeset = Credit.changeset(%Credit{})
    banks = Bank.all_with_cards
    render(conn, "new.html", changeset: changeset, banks: banks)
  end

  def create(conn, %{"credit" => credit_params}) do
    changeset = Credit.changeset(%Credit{}, credit_params)
    banks = Bank.all_with_cards

    case Repo.insert(changeset) do
      {:ok, _credit} ->
        conn
        |> put_flash(:info, "Credit created successfully.")
        |> redirect(to: credit_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, banks: banks)
    end
  end

  def show(conn, %{"id" => id}) do
    credit = Repo.get!(Credit, id)
    render(conn, "show.html", credit: credit)
  end

  def edit(conn, %{"id" => id}) do
    credit = Repo.get!(Credit, id)
    changeset = Credit.changeset(credit)
    banks = Bank.all_with_cards
    render(conn, "edit.html", credit: credit, changeset: changeset, banks: banks)
  end

  def update(conn, %{"id" => id, "credit" => credit_params}) do
    credit = Repo.get!(Credit, id)
    changeset = Credit.changeset(credit, credit_params)
    banks = Bank.all_with_cards

    case Repo.update(changeset) do
      {:ok, credit} ->
        conn
        |> put_flash(:info, "Credit updated successfully.")
        |> redirect(to: credit_path(conn, :show, credit))
      {:error, changeset} ->
        render(conn, "edit.html", credit: credit, changeset: changeset, banks: banks)
    end
  end

  def delete(conn, %{"id" => id}) do
    credit = Repo.get!(Credit, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(credit)

    conn
    |> put_flash(:info, "Credit deleted successfully.")
    |> redirect(to: credit_path(conn, :index))
  end
end
