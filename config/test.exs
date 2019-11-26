use Mix.Config

# Configure your database
config :cockroach_liveview, CockroachLiveview.Repo,
  username: "postgres",
  password: "postgres",
  database: "cockroach_liveview_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cockroach_liveview, CockroachLiveviewWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
