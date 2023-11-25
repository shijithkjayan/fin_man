defmodule FinMan.Repo do
  use Ecto.Repo,
    otp_app: :fin_man,
    adapter: Ecto.Adapters.Postgres
end
