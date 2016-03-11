defmodule Dinero.DebitController do
  use Dinero.Web, :controller

  alias Dinero.Debit
  alias Dinero.Bank

  plug :scrub_params, "debit" when action in [:create, :update]

  def index(conn, _params) do
    debits = Repo.all(Debit)
    render(conn, "index.html", debits: debits)
  end

  def public_index(conn, _params) do
    debits = Debit.all_with_banks
    render(conn, "public_index.html", debits: debits)
  end

  def new(conn, _params) do
    changeset = Debit.changeset(%Debit{})
    banks = Bank.all_with_cards
    render(conn, "new.html", changeset: changeset, banks: banks)
  end

  def create(conn, %{"debit" => debit_params}) do
    changeset = Debit.changeset(%Debit{}, debit_params)

    case Repo.insert(changeset) do
      {:ok, _debit} ->
        conn
        |> put_flash(:info, "Debit created successfully.")
        |> redirect(to: debit_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    debit = Repo.get!(Debit, id)
    render(conn, "show.html", debit: debit)
  end

  def edit(conn, %{"id" => id}) do
    debit = Repo.get!(Debit, id)
    changeset = Debit.changeset(debit)
    banks = Bank.all_with_cards
    render(conn, "edit.html", debit: debit, changeset: changeset, banks: banks)
  end

  def update(conn, %{"id" => id, "debit" => debit_params}) do
    debit = Repo.get!(Debit, id)
    changeset = Debit.changeset(debit, debit_params)

    case Repo.update(changeset) do
      {:ok, debit} ->
        conn
        |> put_flash(:info, "Debit updated successfully.")
        |> redirect(to: debit_path(conn, :show, debit))
      {:error, changeset} ->
        render(conn, "edit.html", debit: debit, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    debit = Repo.get!(Debit, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(debit)

    conn
    |> put_flash(:info, "Debit deleted successfully.")
    |> redirect(to: debit_path(conn, :index))
  end
end
