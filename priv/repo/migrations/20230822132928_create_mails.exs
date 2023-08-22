defmodule Sendmail.Repo.Migrations.CreateMails do
  use Ecto.Migration

  def change do
    create table(:mails) do
      add :subject, :string
      add :body, :string
      add :contact_id, references(:contacts, on_delete: :nothing)

      timestamps()
    end

    create index(:mails, [:contact_id])
  end
end
