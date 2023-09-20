defmodule Sequence.Server do
  use GenServer

  def init(initial_number) when is_integer(initial_number) do
    {:ok, initial_number}
  end

  def init(stack) when is_list(stack) do
    {:ok, stack}
  end

  def handle_call({:stack, item}, _, stack) when is_list(stack) do
    {:reply, {:stack, item, [item | stack]}, [item | stack]}
  end

  def handle_call(:pop, _, []) do
    {:reply, {:pop, :empty, []}, []}
  end

  def handle_call(:pop, _, [head | tail]) do
    {:reply, {:pop, head, tail}, tail}
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

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect(state)}', and I'm happy"}]]
  end

  def handle_call({:factors, number}, _, _) do
    {:reply, {:factors_of, number, factors(number)}, []}
  end

  @doc """
  Caluculate the prime factors of a number
  ## Parameters
    - `number` - The number to calculate the factors of
  ## Examples
      iex> Sequence.Server.factors(12)
      [2, 2, 3]
      iex> Sequence.Server.factors(2**10)
      [2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
      iex> Sequence.Server.factors(1031)
      [1031]
  """
  def factors(number) do
    factors(number, 2, [])
  end

  defp factors(1, _, l) do
    l
    |> Enum.reverse()
  end

  defp factors(number, divider, l) when rem(number, divider) == 0 do
    factors(div(number, divider), divider, [divider | l])
  end

  defp factors(number, divider, l) do
    factors(number, divider + 1, l)
  end
end
