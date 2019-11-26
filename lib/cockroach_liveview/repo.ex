defmodule CockroachLiveview.Repo do
  use Ecto.Repo,
    otp_app: :cockroach_liveview,
    adapter: Ecto.Adapters.CockroachDB
end
