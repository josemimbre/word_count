defmodule WordCount.CLI do
  def main(args) do
    case args do
      [] ->
        stdio = IO.stream(:stdio, :line)
        streams = [stdio]
        WordCount.process_streams(streams)

      _ ->
        streams = for file <- args, do: File.stream!(file, read_ahead: 100_000)
        WordCount.process_streams(streams)
    end
  end
end
