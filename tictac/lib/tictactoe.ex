defmodule TicTacToe do
  use GenServer

  # Client API 

  def start(n) when n > 2 and n < 6 do 
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
    {:ok, %{:turn => 1, :game_board => board, :results => %{:draw => 0, :win1 => 0, :win2 => 0}}}
  end

  def handle_call({:go, {column, row}}, _from, game) do
    case Board.get(game[:game_board], {column, row}) do
      0 -> 
        Board.put(game[:game_board], game[:turn], {column, row})
        {result, message} = VictoryConditions.test(Board.display(game[:game_board]))
        case result do
          :ok -> {:reply, {:ok, "Good move #{game[:turn]}"}, turn_change(game)}
          :win1 -> end_game(game, :win1)
          :win2 -> end_game(game, :win2)
          :draw -> end_game(game, :draw)
        end
        {:reply, {:ok, message}, game}
      _ ->
        {:reply, {:error, "Place already taken, go again"}, game}
    end
  end

  def handle_call({:display}, _from, game) do
    Enum.each Board.display(game[:game_board]), fn line ->
      IO.inspect line
    end
    {:reply, :ok, game}
  end

  def handle_call({:restart}, _from, game) do
    Board.clear(game[:game_board])
    {:reply, "Game Restarted", game}
  end

  defp end_game(game, outcome) do
    Board.clear(game[:game_board])
    update_in(game, [:results, outcome], &(&1 + 1))
  end

  defp turn_change(game) do
    case game[:turn] do
      1 -> Map.put(game, :turn, 2)
      2 -> Map.put(game, :turn, 1)
    end
  end
end
