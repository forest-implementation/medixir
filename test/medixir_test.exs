defmodule MedixirTest do
  use ExUnit.Case
  doctest Medixir

  test "greets the world" do
    assert Medixir.hello() == :world
  end

  # test "fast_median" do
  #   # 1..25 |> Enum.map(fn x -> Enum.random(0..100) end)
  #   assert [70, 35, 2, 47, 43, 79, 74, 36, 49, 98, 98, 9, 67, 28, 59, 30, 21, 11, 12, 17, 66, 90, 93, 34, 85] |> Medixir.nth(10) == 35
  # end

  # test "med" do
  #   assert [1,2,3,4,5] |> Medixir.med == 3
  #   assert [2,3,1,4] |> Medixir.med == 3
  #   assert [2,3,1,4,5] |> Medixir.med == 3
  #   assert [70, 35, 2, 47, 43, 79, 74, 36, 49, 98, 98, 9, 67, 28, 59, 30, 21, 11, 12, 17, 66, 90, 93, 34, 85] |> Medixir.med == 59
  # end

  test "mergemap" do
    assert [%{1 => [5]}, %{1 => [6], 2 => [7]}] |> Medixir.mergetwo == %{1 => [5, 6], 2 => [7]}

    assert [%{{false, true} => [70], {true, false} => [2, 35, 43, 47]},
    %{{false, true} => [74, 79, 98], {true, false} => [36, 49]},
    %{{false, false} => [59], {false, true} => [67, 98], {true, false} => [9, 28]},
    %{{true, false} => [11, 12, 17, 21, 30]},
    %{{false, true} => [66, 85, 90, 93], {true, false} => [34]}]
    |> Medixir.mergetwo == %{
      {false, false} => [59],
      {false, true} => [70, 74, 79, 98, 67, 98, 66, 85, 90, 93],
      {true, false} => [2, 35, 43, 47, 36, 49, 9, 28, 11, 12, 17, 21, 30, 34]
    }

  end

  test "sortchunks" do
    assert [10,9,8,7,6,5,4,3,2,1,0] |> Medixir.sortchunks(5) == [[6,7,8,9,10],[1,2,3,4,5],[0]]
  end

  test "find" do
    input = [88, 23, 71, 45, 26, 74, 54, 14, 52, 7, 3, 22, 37, 3, 79, 30, 7, 73, 83, 91, 86,
    47, 58, 70, 60]
    right = input |> Enum.sort |> Enum.at(13)

    left = input |> Medixir.find(Enum.at(input,0), 13)
    assert left == right
  end

  test "findslow" do
    input = 1..20000 |> Enum.map(fn _ -> Enum.random(0..100000000) end)
    input |> Enum.sort |> Enum.at(238) |> IO.inspect
  end
  
  test "findfast" do
    input = 1..20000 |> Enum.map(fn _ -> Enum.random(0..100000000) end)
    input |> Medixir.find(Enum.at(input,0), 238) |> IO.inspect
  end

  def size(arr), do: size(arr,0)
  def size([], c), do: c
  def size([_|tail], c), do: size(tail, c+1)

  test "testsize" do
    assert [1,2,3] |> size == 3
  end



end
