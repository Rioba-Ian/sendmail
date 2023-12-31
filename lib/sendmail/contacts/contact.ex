defmodule Sendmail.Contacts.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field :name, :string
    field :email, :string
    belongs_to :user, Sendmail.Accounts.User

    has_many :emails, Sendmail.Mails.Mail
    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:name, :email, :user_id])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
