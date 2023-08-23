defmodule Sendmail.Mails.Mail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mails" do
    field :body, :string
    field :subject, :string

    belongs_to :contact, Sendmail.Contacts.Contact
    belongs_to :user, Sendmail.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(mail, attrs) do
    mail
    |> cast(attrs, [:subject, :body, :user_id])
    |> validate_required([:subject, :body])
    |> cast_assoc(:contact)
  end
end
