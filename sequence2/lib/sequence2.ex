defmodule Sequence do
  @server Sequence.Server
  def start_link(list) when is_list(list) do
    GenServer.start_link(@server, list, name: @server)
  end

  def start_link(current_number) do
    GenServer.start_link(@server, current_number, name: @server)
  end

  def next_number do
    GenServer.call(@server, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(@server, {:increment_number, delta})
  end

  def push(item) do
    GenServer.cast(@server, {:push, item})
  end

  def pop do
    GenServer.call(@server, :pop)
  end
end
