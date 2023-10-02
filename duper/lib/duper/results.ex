defmodule Duper.Results do
  use GenServer

  @me __MODULE__
  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: @me)
  end

  def add_hash_for(path, hash) do
    GenServer.call(@me, {:add, path, hash})
  end

  def find_duplicates() do
    GenServer.call(@me, :find_duplicates)
  end

  def init(:no_args) do
    {:ok, %{}}
  end

  def handle_cast({:add, path, hash}, results) do
    results = Map.update(results, hash, [path], fn existing -> [path | existing] end)
  end

  def handle_call(:find_duplicates, _from, results) do
    {:reply, hash_with_more_then_one_path(results), results}
  end

  defp hash_with_more_then_one_path(results) do
    results
    |> Enum.filter(fn {_hash, paths} -> length(paths) > 1 end)
    |> Enum.map(&elem(&1, 1))
  end
end
