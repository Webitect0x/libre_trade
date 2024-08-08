defmodule LibreTradeWeb.ExploreLive do
  use LibreTradeWeb, :live_view

  alias LibreTradeWeb.CreateThreadForm
  alias LibreTrade.Threads

  def mount(_params, _session, socket) do
    {:ok, assign(socket, threads: Threads.list_threads())}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_info({:thread_created, _thread_params}, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="mt-[5rem] text-center">
      <h1>Browse through different threads!</h1>
      <div class="max-w-[50rem] mt-[2rem] mx-auto flex items-center justify-between">
        <.link patch={~p"/explore/new"} class="glass-effect px-2">Create Thread</.link>
        <input placeholder="Search" class="glass-effect px-2" />
      </div>

      <div class="mt-[2rem] max-w-[50rem] mx-auto flex gap-5">
        <.link
          :for={thread <- @threads}
          patch={~p"/forum/t/#{thread.name}"}
          class="glass-effect w-[13rem] flex items-center gap-2 px-3"
        >
          <img src={thread.logo} class="w-[3rem] h-[3rem] rounded-full" />
          <div>
            <h2 class="text-2xl font-bold"><%= String.capitalize(thread.name) %></h2>
            <div class="text-xs"><%= thread.subscribers %> Subscribers</div>
          </div>
        </.link>
      </div>

      <.modal
        :if={@live_action == :new}
        id="create-thread-modal"
        on_cancel={JS.navigate(~p"/explore")}
        show
      >
        <.live_component module={CreateThreadForm} id="create-thread-form" />
      </.modal>
    </div>
    """
  end
end
