defmodule Sendmail.Repo do
  use Ecto.Repo,
    otp_app: :sendmail,
    adapter: Ecto.Adapters.Postgres
end
