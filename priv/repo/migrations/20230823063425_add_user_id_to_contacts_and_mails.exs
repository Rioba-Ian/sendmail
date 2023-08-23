defmodule Sendmail.Repo.Migrations.AddUserIdToContactsAndMails do
  use Ecto.Migration

  def change do
    alter table(:contacts) do
      add :user_id, references(:users, on_delete: :delete_all)
    end

    alter table(:mails) do
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create index(:contacts, [:user_id])
    create index(:mails, [:user_id])
  end
end
