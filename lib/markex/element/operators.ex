defmodule Markex.Element.Operators do
  import Markex.Element, only: [over: 2, beside: 2]

  @type element :: Markex.Element.element()

  @moduledoc """
  Pretty operators for actions with elements
  """

  @spec element <~> element :: element
  @doc """
  See `Markex.Element.over/2`
  """
  def top <~> bottom do
    over(top, bottom)
  end

  @spec element <|> element :: element
  @doc """
  See `Markex.Element.beside/2`
  """
  def left <|> right do
    beside(left, right)
  end
end
