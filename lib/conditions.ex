defmodule VictoryConditions do
  
  def test(board) do
    testable_array(board) |>
    Enum.map(fn x -> win_test(x) end) |>
    Enum.find(:ok, fn x -> x != :ok end)
  end

  def stalemate_test(board) do
    List.flatten(board) |>
    Enum.find(fn x -> x == 0 end) 
  end

  defp testable_array(board) do
    horizontal_values(board) ++ 
    vertical_values(board) ++
    diagonal(board) ++
    inverse_diagonal(board) |>
    Enum.map(fn x -> :math.pow(x, 1/length(board)) end)
  end

  defp horizontal_values(board) do
   Enum.map(board, fn x -> Enum.reduce(x, fn(curr, acc) -> curr * acc end) end) 
  end 

  defp vertical_values(board) do
    Matrix.transpose(board) |> horizontal_values
  end
  
  defp diagonal(board) do
    result = length(board) |>
              Matrix.ident |>
              Matrix.emult(board) |>
              List.flatten |>
              Enum.filter(fn x -> x != 0 end)
    case length(result) == length(board) do
      true ->
        diag = Enum.reduce(result, fn (curr, acc) -> curr * acc end) 
      false ->
        diag = 0.0
    end
    [diag]
  end

  defp inverse_diagonal(board) do
    Enum.reverse(board) |> diagonal
  end

  defp win_test(2.0), do: :win2
  defp win_test(1.0), do: :win1
  defp win_test(_n), do: :ok
end