defmodule LibreTradeWeb.Components.Filter do
  use Phoenix.Component

  slot :inner_block

  def filter(assigns) do
    ~H"""
    <div class="glass-effect m-3 flex p-1">
      <form phx-change="select-per-page">
        <div class="flex flex-col">
          <label for="per-page">Filter By</label>
          <select name="per-page" class="border-none bg-transparent px-2 py-0">
            <%= render_slot(@inner_block) %>
          </select>
        </div>
      </form>
    </div>
    """
  end
end
