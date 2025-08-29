defmodule Filterizer.Repo do
  use Ecto.Repo,
    otp_app: :filterizer,
    adapter: Ecto.Adapters.Postgres
end
