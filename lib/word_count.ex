defmodule WordCount do
  def process_streams(streams) do
    result =
        streams
        |> Flow.from_enumerables()
        |> Flow.flat_map(&WordCount.split_phrase(&1))
        |> Flow.partition()
        |> Flow.reduce(fn -> %{} end, fn word, acc ->
          Map.update(acc, word, 1, &(&1 + 1))
        end)
        |> Enum.to_list()
        |> Enum.sort(fn {_key1, value1}, {_key2, value2} -> value1 > value2 end)

      Enum.take(result, 100)
      |> Enum.map(fn {phrase, number} -> IO.puts(phrase <> " - " <> to_string(number)) end)

      # File.write!('result.txt', inspect(result, pretty: true, limit: :infinity))
  end

  def split_phrase(phrase) do
    phrase
    |> format_and_split_phrase()
    |> expand_list([])
  end

  def format_and_split_phrase(phrase) do
    phrase
    |> String.replace(
      ["\n", "”", "“", "!", "’", "?", "(", ")", "\"", "_", "'", "=", "[", "]"],
      ""
    )
    |> String.downcase()
    |> String.split([" ", ",", ", ", ".", ". ", ":", ": ", ";", "; "], trim: true)
    |> List.delete("")
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
