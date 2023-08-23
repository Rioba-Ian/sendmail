defmodule SendmailWeb.MailController do
  use SendmailWeb, :controller

  alias Sendmail.Mails
  alias Sendmail.Mails.Mail
  alias Sendmail.Contacts

  def index(conn, _params) do
    mails = Mails.list_mails(conn.assigns.current_user)
    render(conn, :index, mails: mails)
  end

  def new(conn, _params) do
    changeset = Mails.change_mail(%Mail{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"mail" => mail_params}) do
    contact_email = mail_params["contact_email"]

    contact =
      if contact_email != nil do
        Contacts.get_contact_by_email(mail_params["contact_email"]) ||
          case Contacts.create_contact(%{"email" => mail_params["contact_email"]}) do
            {:ok, contact} -> contact
            {:error, _changeset} -> nil
          end
      end

    if contact do
      # Associate the mail with the current user and contact
      mail_params = Map.put(mail_params, "contact_id", contact.id)
      mail_params = Map.put(mail_params, "user_id", conn.assigns.current_user.id)

      case Mails.create_mail(mail_params) do
        {:ok, mail} ->
          conn
          |> put_flash(:info, "Mail created successfully.")
          |> redirect(to: ~p"/mails/#{mail}")

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, :new, changeset: changeset)
      end
    else
      # Handle the case where no contact email was provided or contact creation failed
      conn
      |> put_flash(:error, "No contact with that email was found or could not be created.")
      |> render(:new, changeset: Mails.change_mail(%Mail{}))
    end
  end

  def show(conn, %{"id" => id}) do
    mail = Mails.get_mail!(id)
    render(conn, :show, mail: mail)
  end

  def edit(conn, %{"id" => id}) do
    mail = Mails.get_mail!(id)
    changeset = Mails.change_mail(mail)
    render(conn, :edit, mail: mail, changeset: changeset)
  end

  def update(conn, %{"id" => id, "mail" => mail_params}) do
    mail = Mails.get_mail!(id)

    case Mails.update_mail(mail, mail_params) do
      {:ok, mail} ->
        conn
        |> put_flash(:info, "Mail updated successfully.")
        |> redirect(to: ~p"/mails/#{mail}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, mail: mail, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mail = Mails.get_mail!(id)
    {:ok, _mail} = Mails.delete_mail(mail)

    conn
    |> put_flash(:info, "Mail deleted successfully.")
    |> redirect(to: ~p"/mails")
  end
end
