defmodule SendmailWeb.MailHTML do
  use SendmailWeb, :html

  embed_templates "mail_html/*"

  @doc """
  Renders a mail form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def mail_form(assigns)
end
