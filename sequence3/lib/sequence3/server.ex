defmodule Sequence.Server do
  use GenServer

  #####
  # 外部API

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  def init(_) do
    {:ok, Sequence.Stash.get()}
  end

  def init(stack) when is_list(stack) do
    {:ok, stack}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_call({:set_number, new_number}, _from, _current_number) do
    {:reply, new_number, new_number}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  def terminate(_reason, current_number) do
    Sequence.Stash.update(current_number)
  end
end
