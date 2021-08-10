defmodule Markex.Element.Operators do
  import Markex.Element, only: [over: 2, beside: 2]

  alias Markex.Element

  @moduledoc """
  Pretty operators for actions with elements
  """

  @spec Element.t() <~> Element.t() :: Element.t()
  @doc """
  See `Markex.Element.over/2`
  """
  def top <~> bottom do
    over(top, bottom)
  end

  @spec Element.t() <|> Element.t() :: Element.t()
  @doc """
  See `Markex.Element.beside/2`
  """
  def left <|> right do
    beside(left, right)
  end
end
