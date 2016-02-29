defmodule Dinero.BankController do
  use Dinero.Web, :controller

  alias Dinero.Bank

  plug :scrub_params, "bank" when action in [:create, :update]

  def index(conn, _params) do
    banks = Repo.all(Bank)
    render(conn, "index.html", banks: banks)
  end

  def public_index(conn, _params) do
    banks = Repo.all(Bank)
    render(conn, "public_index.html", banks: banks)
  end

  def new(conn, _params) do
    changeset = Bank.changeset(%Bank{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bank" => bank_params}) do
    changeset = Bank.changeset(%Bank{}, bank_params)

    case Repo.insert(changeset) do
      {:ok, _bank} ->
        conn
        |> put_flash(:info, "Bank created successfully.")
        |> redirect(to: bank_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bank = Repo.get!(Bank, id)
    render(conn, "show.html", bank: bank)
  end

  def edit(conn, %{"id" => id}) do
    bank = Repo.get!(Bank, id)
    changeset = Bank.changeset(bank)
    render(conn, "edit.html", bank: bank, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bank" => bank_params}) do
    bank = Repo.get!(Bank, id)
    changeset = Bank.changeset(bank, bank_params)

    case Repo.update(changeset) do
      {:ok, bank} ->
        conn
        |> put_flash(:info, "Bank updated successfully.")
        |> redirect(to: bank_path(conn, :show, bank))
      {:error, changeset} ->
        render(conn, "edit.html", bank: bank, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bank = Repo.get!(Bank, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(bank)

    conn
    |> put_flash(:info, "Bank deleted successfully.")
    |> redirect(to: bank_path(conn, :index))
  end
end
