defmodule LibreTradeWeb.CreateThreadForm do
  use LibreTradeWeb, :live_component

  alias LibreTrade.Threads
  alias LibreTrade.Threads.Thread

  import LibreTradeWeb.Utils, only: [file_upload: 2, assign_form: 2]

  def mount(socket) do
    socket =
      socket
      |> allow_upload(
        :logo,
        accept: ~w(.jpg .jpeg .png .gif),
        max_entries: 1,
        max_file_size: 10_000_000
      )

    {:ok, assign_form(socket, Threads.change_thread(%Thread{}))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} phx-submit="save" phx-change="validate" phx-target={@myself}>
        <.input field={@form[:name]} placeholder="Name" />
        <.input field={@form[:description]} placeholder="Description" />

        <div class="drop" phx-drop-target={@uploads.logo.ref}>
          <div>
            <%!-- <img src="/images/upload.svg" /> --%>
            <div>
              <label for={@uploads.logo.ref}>
                <span>Upload a file</span>
                <.live_file_input upload={@uploads.logo} class="sr-only" />
              </label>
              <span>or drag and drop here</span>
            </div>
            <p>
              <%= @uploads.logo.max_entries %> photos max,
              up to <%= trunc(@uploads.logo.max_file_size / 1_000_000) %> MB each
            </p>
          </div>
        </div>

        <.error :for={err <- upload_errors(@uploads.logo)}>
          <%= Phoenix.Naming.humanize(err) %>
        </.error>

        <div :for={entry <- @uploads.logo.entries} class="entry">
          <.live_img_preview entry={entry} class="w-[12rem] h-[10rem]" />

          <div class="progress">
            <div class="value">
              <%= entry.progress %> %
            </div>

            <div class="bar">
              <span style={"width: #{entry.progress}%"}></span>
            </div>

            <.error :for={err <- upload_errors(@uploads.logo, entry)}>
              <%= Phoenix.Naming.humanize(err) %>
            </.error>
          </div>

          <a phx-click="cancel" phx-value-ref={entry.ref}>
            &times;
          </a>
        </div>

        <.button phx-disable-with="Uploading...">
          Upload
        </.button>
      </.form>
    </div>
    """
  end

  def handle_event("save", %{"thread" => thread_params}, socket) do
    logo = file_upload(socket, :logo)
    thread_params = Map.put(thread_params, "logo", hd(logo))

    case Threads.create_thread(thread_params) do
      {:ok, thread} ->
        send(self(), {:thread_created, thread})
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  def handle_event("validate", %{"thread" => params}, socket) do
    changeset =
      %Thread{}
      |> Threads.change_thread(params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end
end
