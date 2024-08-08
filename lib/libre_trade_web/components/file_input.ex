defmodule LibreTradeWeb.Components.FileInput do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <div class="drop" phx-drop-target={@uploads.logo.ref}>
      <div>
        <img src="/images/upload.svg" class="w-[5rem]" />
        <div>
          <label for={@uploads.logo.ref}>
            <span>Upload a Logo</span>
            <.live_file_input upload={@uploads.logo} class="sr-only" />
          </label>
          <span>or drag and drop here</span>
        </div>
      </div>
    </div>
    """
  end
end
