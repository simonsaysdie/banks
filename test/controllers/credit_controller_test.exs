defmodule Dinero.CreditControllerTest do
  use Dinero.ConnCase

  alias Dinero.Credit
  @valid_attrs %{additional_cards: true, annual: 42, cat: 42, insurance: true, max_age: 42, min_age: 42, min_income: 42, name: "some content", opening: 42, promo: true, requirements: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, credit_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing credits"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, credit_path(conn, :new)
    assert html_response(conn, 200) =~ "New credit"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, credit_path(conn, :create), credit: @valid_attrs
    assert redirected_to(conn) == credit_path(conn, :index)
    assert Repo.get_by(Credit, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, credit_path(conn, :create), credit: @invalid_attrs
    assert html_response(conn, 200) =~ "New credit"
  end

  test "shows chosen resource", %{conn: conn} do
    credit = Repo.insert! %Credit{}
    conn = get conn, credit_path(conn, :show, credit)
    assert html_response(conn, 200) =~ "Show credit"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, credit_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    credit = Repo.insert! %Credit{}
    conn = get conn, credit_path(conn, :edit, credit)
    assert html_response(conn, 200) =~ "Edit credit"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    credit = Repo.insert! %Credit{}
    conn = put conn, credit_path(conn, :update, credit), credit: @valid_attrs
    assert redirected_to(conn) == credit_path(conn, :show, credit)
    assert Repo.get_by(Credit, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    credit = Repo.insert! %Credit{}
    conn = put conn, credit_path(conn, :update, credit), credit: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit credit"
  end

  test "deletes chosen resource", %{conn: conn} do
    credit = Repo.insert! %Credit{}
    conn = delete conn, credit_path(conn, :delete, credit)
    assert redirected_to(conn) == credit_path(conn, :index)
    refute Repo.get(Credit, credit.id)
  end
end
