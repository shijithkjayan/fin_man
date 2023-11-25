defmodule FinManWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use FinManWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(FinManWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, :error) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(FinManWeb.ErrorView)
    |> render(:"400")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(FinManWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
