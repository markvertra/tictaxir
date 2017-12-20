defmodule Board do
  use GenServer

  #Client
  
  def build(n, opts \\ %{})
  
  def build(n, opts) when is_integer(n) do
    start_board_server(n, opts)
  end

  def build(_n, _opts) do
    {:error, "invalid parameters"}
  end

  def display(board) do
    GenServer.call(board, {:display})
  end 

  def get(board, {column, row}) do
    GenServer.call(board, {:get, {column, row}})
  end 

  def put(board, item, {column, row}) do
    GenServer.cast(board, {:put, item, {column, row}})
  end

  def clear(board) do
    GenServer.call(board, {:clear})
  end 

  def stop(board) do
    GenServer.stop(board)
  end

  defp start_board_server(n, opts) do
    GenServer.start_link(__MODULE__, board_builder(n), name: opts[:name] || __MODULE__)
  end

  defp board_builder(n) do
    List.duplicate(0, n) |>
    List.duplicate(n)
  end

 #Server 

  def init(board) do
    {:ok, board}
  end

  def handle_call({:display}, _from, board) do 
    {:reply, board, board}
  end 

  def handle_call({:get, {column, row}}, _from, board) do
    {:reply, get_square(board, column, row), board}
  end

  def handle_call({:clear}, _from, board) do
    {:reply, :ok, Enum.map(board, fn x -> Enum.map(x, fn _y -> 0 end) end)}
  end

  def handle_cast({:put, item, {column, row}}, board) do
    {:noreply, put_square(board, item, column, row)}
  end

  defp put_square(board, item, column, row) do
    new_row = Enum.at(board,row) |>
    List.update_at(column, &(&1 = item))

    List.update_at(board, row, &(&1 = new_row))
  end

  defp get_square(board, column, row) do
    Enum.at(board, row) |> Enum.at(column)
  end
end