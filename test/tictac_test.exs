defmodule TicTacToe.Test do
  use ExUnit.Case

  test 'can create valid board' do
    {check, _val} = Board.build("duck")
    assert check == :error

    {check, _val} = Board.build(3.25)
    assert check == :error

    {check, _val} = Board.build(10)
    assert check == :ok
  end 

  test 'can view board' do
    {:ok, board} = Board.build(4)
    visual_board = Board.display(board)
    assert length(visual_board) == 4
    assert length(Enum.at(visual_board,0)) == 4
    assert Enum.at(visual_board, 0) |>
           Enum.at(0) == 0
  end

  test 'can get and put square in board' do
    {:ok, board} = Board.build(5)
    assert Board.get(board, {1, 3}) == 0

    Board.put(board, "fox", {1, 3})
    assert Board.get(board, {1, 3}) == "fox"
  end 

  test 'can clear board' do
    {:ok, board} = Board.build(4)
    Board.put(board, "fox", {1, 3})
    assert Board.get(board, {1, 3}) == "fox"
    
    Board.clear(board)
    assert Board.get(board, {1, 3}) == 0
  end 

  test 'can start a game' do
    {check, _game} = TicTacToe.start(5)
    assert check == :ok
  end

  test 'can mark an occupied square' do
    {:ok, _game} = TicTacToe.start(3)
    {check, _result} = TicTacToe.go({1,1})
    assert :ok == check

    {check, _result} = TicTacToe.go({0,1})
    assert :ok == check

    {check, _result} = TicTacToe.go({0,1})
    assert :error == check
  end

  test 'the correct player wins' do 
  # player wins, player draws, player uses, known earlire or wait until all moves?
  end

end