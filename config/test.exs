import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :fin_man, FinMan.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "fin_man_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fin_man, FinManWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "qZ4UE+FRFSJMJAO7DFVnqkPchdB1GcCxeLn2H8ifgPJ+hymhJFh0dNl14bUyRiO6",
  server: false

# In test we don't send emails.
config :fin_man, FinMan.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
