defmodule LibreTradeWeb.ForumLive.Components do
  use Phoenix.Component

  attr :rest, :global
  attr :threads, :list

  def side_bar(assigns) do
    ~H"""
    <div {@rest} class="h-[90vh] w-[16rem] glass-effect hidden text-center lg:block">
      <div class="flex h-full flex-col justify-between gap-2">
        <div class="flex flex-col items-center gap-2">
          <h1 class="mt-[2rem] text-2xl">LibreForum</h1>
          <div class="my-[2rem] text-xs">Popular Threads</div>

          <.link
            :for={thread <- @threads}
            navigate={"/forum/t/#{thread.name}"}
            class="glass-effect flex w-[12rem] items-center gap-2 px-3"
          >
            <img src={thread.logo} class="w-[2.5rem] h-[2.5rem] rounded-full" />
            <div>
              <h2 class="text-2xl font-bold"><%= String.capitalize(thread.name) %></h2>
              <div class="text-xs"><%= thread.subscribers %> Subscribers</div>
            </div>
          </.link>
        </div>

        <.link class="w-[8rem] mx-auto glass-effect mb-[5rem]" navigate="/explore">
          Explore Page
        </.link>
      </div>
    </div>
    """
  end
end
