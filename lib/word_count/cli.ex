defmodule WordCount.CLI do
  def main([]) do
    stdio = IO.stream(:stdio, :line)
    WordCount.process_streams([stdio])
  end

  def main(args) do
    streams = for file <- args, do: File.stream!(file, read_ahead: 100_000)
    WordCount.process_streams(streams)
  end
end
