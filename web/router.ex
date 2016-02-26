defmodule Dinero.Router do
  use Dinero.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Dinero do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

  end

  scope "/admin", Dinero do
    pipe_through :browser # Use the default browser stack

    resources "/banks", BankController
    resources "/debits", DebitController
    resources "/credits", CreditController

  end
  # Other scopes may use custom stacks.
  # scope "/api", Dinero do
  #   pipe_through :api
  # end
end
