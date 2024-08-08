defmodule LibreTradeWeb.Utils do
  alias Phoenix.{LiveView, VerifiedRoutes, Component}

  def file_upload(socket, name) do
    LiveView.consume_uploaded_entries(socket, name, fn meta, entry ->
      dest =
        Path.join([
          "priv",
          "static",
          "uploads",
          "#{entry.uuid}-#{entry.client_name}"
        ])

      File.cp!(meta.path, dest)

      url_path =
        VerifiedRoutes.static_path(
          socket,
          "/uploads/#{Path.basename(dest)}"
        )

      {:ok, url_path}
    end)
  end

  def assign_form(socket, %Ecto.Changeset{} = changeset) do
    Component.assign(socket, :form, Component.to_form(changeset))
  end
end
