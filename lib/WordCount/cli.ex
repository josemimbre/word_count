defmodule WordCount.CLI do
  def main([]) do
    stdio = IO.stream(:stdio, :line)
    IO.inspect(Enum.to_list(stdio))
  end

  def main(args) do
    streams = for file <- args, do: File.stream!(file, read_ahead: 100_000)

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

    File.write!('result.txt',inspect(result, pretty: true,limit: :infinity))
  end
end
