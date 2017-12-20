defmodule VictoryConditions do
  
  def test(board) do
    calculate_values(board) |> stalemate_test
  end

  defp calculate_values(board) do
   {:ok, board, Enum.map(board, fn x -> Enum.reduce(x, fn(curr, acc) -> curr * acc end) end)} 
  end 

  defp stalemate_test({_, board, results}) do
    case Enum.min(results) do
      0 -> {:ok, "Carry on", board}
      _ -> {:game_over, "Boring, it's a draw", board}
    end
  end

  defp win_test(n) when n == 2 or n == 2.0 do
    {:win, :p2}
  end 

  defp win_test(n) when n == 1 or n == 1.0 do
    {:win, :p1}
  end 

  defp win_test(n) do
    {:continue, :nobody}
  end
end