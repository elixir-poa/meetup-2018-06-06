defmodule Luhn do

  def generate(number) do
    # generate luhn number, 7992739871x -> 3
    unless check_number(number) do
      false
    else
      reversed = number
                 |> String.to_charlist
                 |> Enum.reverse
                 |> Enum.map(&cast_to_number/1)

      doubles = Enum.take_every(reversed, 2)
                |> Enum.map(&double/1)
                |> Enum.map(&foobar/1)
                |> Enum.sum()

      singles = tl(reversed)
                |> Enum.take_every(2)
                |> Enum.sum()

      rem((singles + doubles) * 9, 10)
    end
  end

  def cast_to_number(string) do
    string - ?0
  end

  def foobar(number) when number > 10 do
    rem(number, 10) + div(number, 10)
  end

  def foobar(number), do: number

  def check_number(number) when is_bitstring(number) do
    String.to_charlist(number)
    |> Enum.all?(&symbol_is_digit?/1)
  end

  defp symbol_is_digit?(symbol) do
    symbol >= ?0 and symbol <= ?9
  end

  defp double(x), do: 2 * x
end
