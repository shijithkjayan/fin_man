defmodule FinMan.Fixtures do
  @moduledoc """
  All fixtures we need to run the test suite.
  """
  defmacro __using__(_) do
    quote do
      import FinMan.UsersFixtures
    end
  end
end
