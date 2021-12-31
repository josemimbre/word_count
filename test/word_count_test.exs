defmodule WordCountTest do
  use ExUnit.Case, async: true

  test "list expand with more than 3 elements" do
    list = WordCount.expand_list(["1", "2", "3", "4", "5", "6"], [])
    assert Enum.member?(list, "1 2 3")
    assert Enum.member?(list, "2 3 4")
    assert Enum.member?(list, "3 4 5")
    assert Enum.member?(list, "4 5 6")
  end

  test "list expand with 2 elements" do
    list = WordCount.expand_list(["1", "2"], [])
    assert list == []
  end

  test "list expand with 1 elements" do
    list = WordCount.expand_list(["1"], [])
    assert list == []
  end
end
