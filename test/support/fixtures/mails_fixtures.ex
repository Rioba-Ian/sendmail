defmodule Sendmail.MailsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sendmail.Mails` context.
  """

  @doc """
  Generate a mail.
  """
  def mail_fixture(attrs \\ %{}) do
    {:ok, mail} =
      attrs
      |> Enum.into(%{
        body: "some body",
        subject: "some subject"
      })
      |> Sendmail.Mails.create_mail()

    mail
  end
end
