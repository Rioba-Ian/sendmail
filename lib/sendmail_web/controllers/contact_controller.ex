defmodule SendmailWeb.ContactController do
  use SendmailWeb, :controller

  alias Sendmail.Contacts
  alias Sendmail.Contacts.Contact

  def index(conn, _params) do
    contacts = Contacts.list_contacts(conn.assigns.current_user)
    render(conn, :index, contacts: contacts)
  end

  def new(conn, _params) do
    changeset = Contacts.change_contact(%Contact{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"contact" => contact_params}) do
    contact_params = Map.put(contact_params, "user_id", conn.assigns.current_user.id)

    case Contacts.create_contact(contact_params) do
      {:ok, contact} ->
        conn
        |> put_flash(:info, "Contact created successfully.")
        |> redirect(to: ~p"/contacts/#{contact}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    contact = Contacts.get_contact!(id)
    render(conn, :show, contact: contact)
  end

  def edit(conn, %{"id" => id}) do
    contact = Contacts.get_contact!(id)
    changeset = Contacts.change_contact(contact)
    render(conn, :edit, contact: contact, changeset: changeset)
  end

  def update(conn, %{"id" => id, "contact" => contact_params}) do
    contact = Contacts.get_contact!(id)

    case Contacts.update_contact(contact, contact_params) do
      {:ok, contact} ->
        conn
        |> put_flash(:info, "Contact updated successfully.")
        |> redirect(to: ~p"/contacts/#{contact}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, contact: contact, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    contact = Contacts.get_contact!(id)
    {:ok, _contact} = Contacts.delete_contact(contact)

    conn
    |> put_flash(:info, "Contact deleted successfully.")
    |> redirect(to: ~p"/contacts")
  end
end
