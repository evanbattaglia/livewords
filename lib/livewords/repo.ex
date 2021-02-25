defmodule Livewords.Repo do
  use Ecto.Repo,
    otp_app: :livewords,
    adapter: Ecto.Adapters.Postgres
end
