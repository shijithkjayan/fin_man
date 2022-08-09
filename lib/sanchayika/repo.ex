defmodule Sanchayika.Repo do
  use Ecto.Repo,
    otp_app: :sanchayika,
    adapter: Ecto.Adapters.Postgres
end
