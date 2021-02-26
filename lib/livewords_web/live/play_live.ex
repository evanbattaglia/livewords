defmodule LivewordsWeb.PlayLive do
  use LivewordsWeb, :live_view
  alias Livewords.Games

  defp topic(game_id), do: "game:#{game_id}" # TODO dedup

  @impl true
  def mount(%{"game_id" => game_id}, _session, socket) do
    LivewordsWeb.Endpoint.subscribe(topic(game_id))

    clues = Games.get_clues(game_id)
    guesses = Games.get_guesses(game_id)
    {:ok, assign(socket, game_id: game_id, clues: clues, guesses: guesses)}
  end

  @impl true
  def handle_event("guess", %{"text" => text}, socket) do
    game_id = socket.assigns.game_id
    Games.create_guess(game_id, text)
    LivewordsWeb.Endpoint.broadcast_from(self(), topic(game_id), "update_guesses", nil)
    {:noreply, assign(socket, guesses: Games.get_guesses(game_id))}
  end

  @impl true
  def handle_info(%{event: "update_guesses"}, socket) do
    {:noreply, assign(socket, guesses: Games.get_guesses(socket.assigns.game_id))}
  end

  @impl true
  def handle_info(%{event: "update_clues"}, socket) do
    {:noreply, assign(socket, clues: Games.get_clues(socket.assigns.game_id))}
  end

  # @impl true
  # def handle_event("suggest", %{"q" => query}, socket) do
  #   {:noreply, assign(socket, results: search(query), query: query)}
  # end

  # @impl true
  # def handle_event("search", %{"q" => query}, socket) do
  #   case search(query) do
  #     %{^query => vsn} ->
  #       {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}

  #     _ ->
  #       {:noreply,
  #        socket
  #        |> put_flash(:error, "No dependencies found matching \"#{query}\"")
  #        |> assign(results: %{}, query: query)}
  #   end
  # end

  # defp search(query) do
  #   if not LivewordsWeb.Endpoint.config(:code_reloader) do
  #     raise "action disabled when not in development"
  #   end

  #   for {app, desc, vsn} <- Application.started_applications(),
  #       app = to_string(app),
  #       String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
  #       into: %{},
  #       do: {app, vsn}
  # end
end
