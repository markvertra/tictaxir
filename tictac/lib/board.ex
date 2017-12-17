defmodule Board do
  use GenServer

  #Client
  
  def build(n) when is_integer(n) do
    start_board_server(n)
  end

  def display(client) do
    GenServer.call(client, {:display})
  end 

  def get(client, {column, row}) do
    GenServer.call(client, {:get, {column, row}})
  end 

  def put(client, item, {column, row}) do
    GenServer.cast(client, {:put, item, {column, row}})
  end

  def clear(client) do
    GenServer.call(client, {:clear})
  end 

  def stop(client) do
    GenServer.stop(client)
  end

  defp start_board_server(n) do
    GenServer.start_link(__MODULE__, board_builder(n))
  end

  defp board_builder(n) do
    List.duplicate(nil, n) |>
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
    {:reply, :ok, board_builder(length(board))}
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