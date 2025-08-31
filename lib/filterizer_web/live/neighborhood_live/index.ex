defmodule FilterizerWeb.NeighborhoodLive.Index do
  use FilterizerWeb, :live_view

  alias Filterizer.Neighborhoods

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Neighborhoods
        <:actions>
          <.button variant="primary" navigate={~p"/neighborhoods/new"}>
            <.icon name="hero-plus" /> New Neighborhood
          </.button>
        </:actions>
      </.header>

      <.table
        id="neighborhoods"
        rows={@streams.neighborhoods}
        row_click={fn {_id, neighborhood} -> JS.navigate(~p"/neighborhoods/#{neighborhood}") end}
      >
        <:col :let={{_id, neighborhood}} label="Name">{neighborhood.name}</:col>
        <:action :let={{_id, neighborhood}}>
          <div class="sr-only">
            <.link navigate={~p"/neighborhoods/#{neighborhood}"}>Show</.link>
          </div>
          <.link navigate={~p"/neighborhoods/#{neighborhood}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, neighborhood}}>
          <.link
            phx-click={JS.push("delete", value: %{id: neighborhood.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Neighborhoods")
     |> stream(:neighborhoods, Neighborhoods.list_neighborhoods())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    neighborhood = Neighborhoods.get_neighborhood!(id)
    {:ok, _} = Neighborhoods.delete_neighborhood(neighborhood)

    {:noreply, stream_delete(socket, :neighborhoods, neighborhood)}
  end
end
