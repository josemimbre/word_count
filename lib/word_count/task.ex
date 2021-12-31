defmodule WordCount.Task do
  use Task

  def start_link(arg) do
    Task.start_link(__MODULE__, :run, [arg])
  end

  def run(arg) do
    parent = self()

    File.stream!(arg, read_ahead: 100_000)
    |> Flow.from_enumerable()
    |> Flow.flat_map(&String.split(&1, "."))
    |> Flow.flat_map(&WordCount.split_phrase(&1))
    |> Flow.reject(&(&1 == ""))
    |> Flow.partition()
    # ETS
    |> Flow.reduce(fn -> :ets.new(:ngram, []) end, fn ngram, ets ->
      :ets.update_counter(ets, ngram, {2, 1}, {ngram, 0})
      ets
    end)
    |> Flow.on_trigger(fn ets ->
      :ets.give_away(ets, parent, [])
      # Emit the ETS
      {[ets], :new_reduce_state_which_wont_be_used}
    end)
    |> Enum.to_list()

    IO.puts("fin")
  end
end
