defmodule TicTacToe do
  use GenServer

  # Client API 

  def start(n) when n > 2 and n < 11 do 
    start_link(n)
  end

  def start(_n) do
    IO.puts "Invalid parameters: default board created, size 3"
    start_link(3)
  end

  def go({column, row}) do
    GenServer.call(__MODULE__, {:go, {column, row}})
  end 

  def restart do
    GenServer.call(__MODULE__, {:restart})
  end

  def display do
    GenServer.call(__MODULE__, {:display})
  end

  defp start_link(n, opts \\ %{}) do
    GenServer.start_link(__MODULE__, n, name: opts[:name] || __MODULE__)
  end

  # Server API

  def init(n) do 
    {:ok, board} = Board.build(n)
    {:ok, %{:turn => :p1, :game_board => board}}
  end

  def handle_call({:go, {column, row}}, _from, game) do
    case Board.get(game[:game_board], {column, row}) do
      nil -> 
        Board.put(game[:game_board], game[:turn], {column, row})
        {:reply, {{column, row}, game[:turn]}, turn_change(game)}
      _ ->
        {:reply, "Place already taken, go again", game}
    end
  end

  def handle_call({:display}, _from, game) do
    Enum.each Board.display(game[:game_board]), fn line ->
      IO.inspect line
    end
    {:reply, :ok, game}
  end

  def handle_call({:restart}, _from, game) do
    {:reply, "Game Restarted", Board.clear(game[:game_board])}
  end

  defp turn_change(game) do
    case game[:turn] do
      :p1 -> Map.put(game, :turn, :p2)
      :p2 -> Map.put(game, :turn, :p1)
    end
  end
end
