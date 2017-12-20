# defmodule VictoryConditions do
  
#   def test(board) do
#     calculate_values(board) |> stalemate_test
#   end

#   defp calculate_values(board) do
#    Enum.map(board, fn x -> Enum.reduce(x, fn(curr, acc) -> curr * acc end) end) 
#   end 

#   defp find_root(array) do
#    Enum.map(array, fn x -> :math.pow(x, 1/length(array)) end)
#   end

#   defp stalemate_test(results) do
#     case Enum.min(results) do
#       0 -> calculate_values(results) |> Enum.map(fn x -> win_test(x) end)
#       _ -> {:game_over, "Boring, it's a draw"}
#     end
#   end

#   defp win_test(2.0) do
#     {:win2, "Great job player two, you won"}
#   end 

#   defp win_test(1.0) do 
#     {:win1, "Great job player one, you own"}
#   end 

#   defp win_test(_n) do
#     {:ok, "Carry on"}
#   end
# end