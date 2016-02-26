ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Dinero.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Dinero.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Dinero.Repo)

