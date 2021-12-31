defmodule WordCountTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  doctest WordCount

  setup do
    {:ok, pid_simple} = "a b c\na b c\n" |> StringIO.open()
    {:ok, pid_complex1} = "can’t can’t can’t\nwon't wont' won't\n" |> StringIO.open()

    %{
      stream_simple: IO.binstream(pid_simple, :line),
      stream_complex1: IO.binstream(pid_complex1, :line)
    }
  end

  test "process a simple string", %{stream_simple: stream, stream_complex1: _} do
    assert capture_io(fn -> WordCount.process_streams([stream]) end) == "a b c - 2\n"
  end

  test "process a complex string", %{stream_simple: _, stream_complex1: stream} do
    assert capture_io(fn -> WordCount.process_streams([stream]) end) == "wont wont wont - 1\ncant cant cant - 1\n"
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
