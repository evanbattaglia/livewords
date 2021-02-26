defmodule LivewordsWeb.HostLive do
  use LivewordsWeb, :live_view
  alias Livewords.Games

  defp topic(game_id), do: "game:#{game_id}"

  # TODO much is shared with PlayLive, extract

  def clue_string(template, modifiers, nouns) do
    [template] ++ Enum.reverse(modifiers) ++ Enum.reverse(nouns)
    |> Enum.join(" ")
  end

  def button_classes(word, used_words) do
    if Enum.member?(used_words, word), do: "used", else: "unused"
  end

  defp new_palette_assigns do
    Livewords.Corpus.new_palette(5, 5) ++ [used_modifiers: [], used_nouns: []]
  end

  @impl true
  def mount(%{"game_id" => game_id}, _session, socket) do
    LivewordsWeb.Endpoint.subscribe(topic(game_id))

    assigns = new_palette_assigns() ++ [
      game_id: game_id,
      clues: Games.get_clues(game_id),
      guesses: Games.get_guesses(game_id),
      used_modifiers: [],
      used_nouns: [],
    ]

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("new_clue", %{"text" => text}, socket) do
    game_id = socket.assigns.game_id
    Games.create_clue(game_id, text)
    LivewordsWeb.Endpoint.broadcast_from(self(), topic(game_id), "update_clues", nil)
      
    {:noreply, assign(socket, new_palette_assigns() ++ [clues: Games.get_clues(game_id)])}
  end

  @impl true
  def handle_event("skip", _, socket) do
    {:noreply, assign(socket, new_palette_assigns()}
  end

  defp add_or_remove(list, word) do
    if Enum.member?(list, word) do
      List.delete(list, word)
    else
      [ word | list]
    end
  end

  @impl true
  def handle_event("noun", %{"word" => word}, socket) do
    new_used_nouns = add_or_remove(socket.assigns.used_nouns, word)
    {:noreply, assign(socket, used_nouns: new_used_nouns)}
  end

  @impl true
  def handle_event("modifier", %{"word" => word}, socket) do
    new_used_modifiers = add_or_remove(socket.assigns.used_modifiers, word)
    {:noreply, assign(socket, used_modifiers: new_used_modifiers)}
  end

  @impl true
  def handle_info(%{event: "update_guesses"}, socket) do
    {:noreply, assign(socket, guesses: Games.get_guesses(socket.assigns.game_id))}
  end

  @impl true
  def handle_info(%{event: "update_clues"}, socket) do
    {:noreply, assign(socket, clues: Games.get_clues(socket.assigns.game_id))}
  end
end
