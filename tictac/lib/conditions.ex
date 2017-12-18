defmodule VictoryConditions do
  
  def test(board) do 
    horizontal_test(board) |> win_test
  end

  defp horizontal_test(board) do
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