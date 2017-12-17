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
    {:ok, board} = Board.build(8)
    visual_board = Board.display(board)
    assert length(visual_board) == 8
    assert length(Enum.at(visual_board,0)) == 8
    assert Enum.at(visual_board, 0) |>
           Enum.at(0) == nil
  end

  test 'can get and put square in board' do
    {:ok, board} = Board.build(5)
    assert Board.get(board, {1, 3}) == nil

    Board.put(board, "fox", {1, 3})
    assert Board.get(board, {1, 3}) == "fox"
  end 

  test 'can clear board' do
    {:ok, board} = Board.build(4)
    Board.put(board, "fox", {1, 3})
    assert Board.get(board, {1, 3}) == "fox"
    
    Board.clear(board)
    assert Board.get(board, {1, 3}) == nil
  end 

  test 'can start a game' do
    {check, _game} = TicTacToe.start(5)
    assert check == :ok
  end

  test 'player 1 can mark a square' do
  # try creating player properly succeed, player badly fail
  end

  test 'player 2 can mark a square' do
  # try creating player properly succeed, same as first, fail
  end 

  test 'player 1 can not mark a square that is already marked' do
  # try inviting players, starting game without players, inviting third player
  end 

  test 'player can make a move' do 
  # player makes legal move, player makes illegal move due to bad entry, player makes illegal move due to already used
  end 

  test 'the correct player wins' do 
  # player wins, player draws, player uses, known earlire or wait until all moves?
  end

end