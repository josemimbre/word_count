defmodule WordCount do
  def split_phrase(phrase) do
    phrase
    |> String.replace(~r"[\n:_!@#$%^&*:|,./;?()'’]", "")
    |> String.downcase()
    |> String.split(" ", trim: true)
    |> List.delete("")
    |> expand_list([])
  end

  def expand_list([_head, _tail], accumulator) do
    accumulator
  end

  def expand_list([_head], accumulator) do
    accumulator
  end

  def expand_list([head | tail], accumulator) do
    {:ok, next_0} = Enum.fetch(tail, 0)
    {:ok, next_1} = Enum.fetch(tail, 1)
    element = head <> " " <> next_0 <> " " <> next_1

    expand_list(tail, [
      element | accumulator
    ])
  end

  def expand_list([], accumulator) do
    accumulator
  end
end