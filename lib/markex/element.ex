defmodule Markex.Element do
  @moduledoc """
  Creating and working with elements for 2D markup
  """

  @typedoc """
  List of strings, where all string the same length
  """
  @type element :: list(String.t())

  @doc """
  Creates new element using regular string or list of strings

  In the latter case, automatically makes all strings the same length.

  ## Examples

      iex> Markex.Element.new("Hello, world!")
      ["Hello, world!"]

      iex> Markex.Element.new(["Hello, world!", "or something idk", "."])
      [
        "Hello, world!   ",
        "or something idk",
        ".               "
      ]
  """
  @doc since: "1.0.0"
  @spec new(String.t()) :: element
  def new(content) when is_binary(content) do
    [content]
  end

  @doc since: "1.0.0"
  @spec new(list(String.t())) :: element
  def new(content) when is_list(content) do
    width = Enum.reduce(content, 0, &max(String.length(&1), &2))
    Enum.map(content, &String.pad_trailing(&1, width))
  end

  @doc """
  Fills an element of length `w` and height `h` with char `ch`

  ## Examples

      iex> Markex.Element.new("#", 5, 5)
      [
        "#####",
        "#####",
        "#####",
        "#####",
        "#####"
      ]
  """
  @doc since: "1.0.0"
  @spec new(String.t(), non_neg_integer(), non_neg_integer()) :: element
  def new(ch, w, h) do
    ch
    |> String.duplicate(w)
    |> List.duplicate(h)
  end

  @doc """
  Return string representation of `element`

  ## Examples
      iex> Markex.Element.new("#", 2, 2) |> Markex.Element.to_string()
      "##\\n##"
  """
  @doc since: "1.0.0"
  @spec to_string(element) :: String.t()
  def to_string(element) do
    Enum.join(element, "\n")
  end

  @doc """
  The correct way to get the height of an `element`

  Also see `Markex.Element.size/1`
  """
  @doc since: "1.0.0"
  @spec height(element) :: non_neg_integer()
  def height(element) do
    length(element)
  end

  @doc """
  The correct and safe way to get the width of an `element`

  Also see `Markex.Element.size/1`
  """
  @doc since: "1.0.0"
  @spec width(element) :: non_neg_integer()
  def width(element) do
    if height(element) != 0 do
      String.length(List.first(element))
    else
      0
    end
  end

  @doc """
  The correct and safe way to get the width and height of an `element`

  See also `Markex.Element.width/1` and `Markex.Element.height/1`.

  ## Examples
      iex> Markex.Element.new("#", 4, 5) |> Markex.Element.size()
      {4, 5}
  """
  @doc since: "1.0.0"
  @spec size(element) :: {non_neg_integer(), non_neg_integer()}
  def size(element) do
    {width(element), height(element)}
  end

  @doc """
  Adds space to the sides of the `element` so that the width matches `n`

  ## Examples
      iex> Markex.Element.new("#") |> Markex.Element.wider(6)
      [
        "  #   "
      ]
  """
  @doc since: "1.1.0"
  @spec wider(element, pos_integer(), :center | :left | :right) :: element
  def wider(element, n, align \\ :center)
  def wider(element, n, :center) do
    add_space = n - width(element)
    left = Integer.floor_div(add_space, 2)

    element
    |> Enum.map(&String.pad_leading(&1, width(element) + left))
    |> Enum.map(&String.pad_trailing(&1, n))
  end

  def wider(element, n, :left) do
    element
    |> Enum.map(&String.pad_trailing(&1, n))
  end

  def wider(element, n, :right) do
    element
    |> Enum.map(&String.pad_leading(&1, n))
  end

  @doc """
  Adds space to the top and bottom of the `element` so that the height matches `n`

  ## Examples
      iex> Markex.Element.new("#") |> Markex.Element.higher(6)
      [
        " ",
        " ",
        "#",
        " ",
        " ",
        " "
      ]
  """
  @doc since: "1.1.0"
  @spec higher(element, pos_integer(), :center | :top | :bottom) :: element
  def higher(element, n, align \\ :center)
  def higher(element, n, :center) do
    add_space = n - height(element)
    up = Integer.floor_div(add_space, 2)
    down = add_space - up

    blank = String.duplicate(" ", width(element))

    List.duplicate(blank, up)
    |> Enum.concat(element)
    |> Enum.concat(List.duplicate(blank, down))
  end

  def higher(element, n, :top) do
    add_space = n - height(element)

    blank = String.duplicate(" ", width(element))

    element
    |> Enum.concat(List.duplicate(blank, add_space))
  end

  def higher(element, n, :bottom) do
    add_space = n - height(element)

    blank = String.duplicate(" ", width(element))

    List.duplicate(blank, add_space)
    |> Enum.concat(element)
  end

  @doc """
  Positions `this` on top of `that`, makes the elements wider as needed

  The `align` argument can be used to position the elements correctly relative
  to each other and can be `:center`, `:left`, or `:right`.

  See also `Markex.Element.Operators.<~>/2` and `Markex.Element.wider/2`.

  ## Examples
      iex> Markex.Element.over(Markex.Element.new("#", 1, 2), Markex.Element.new("$", 3, 2))
      [
        " # ",
        " # ",
        "$$$",
        "$$$"
      ]
  """
  @doc since: "1.1.0"
  @spec over(element, element, :center | :left | :right) :: element
  def over(this, that, align \\ :center) do
    w = max(width(this), width(that))
    this = wider(this, w, align)
    that = wider(that, w, align)
    Enum.concat(this, that)
  end

  @doc """
  Positions `this` to the left of `that`, makes the elements higher if needed

  The `align` argument can be used to position the elements correctly relative
  to each other and can be `:center`, `:top`, or `:bottom`.

  See also `Markex.Element.Operators.<|>/2` and `Markex.Element.higher/2`.

  ## Examples
      iex> Markex.Element.beside(Markex.Element.new("#"), Markex.Element.new("$", 2, 3))
      [
        " $$",
        "#$$",
        " $$"
      ]
  """
  @doc since: "1.1.0"
  @spec beside(element, element, :center | :top | :bottom) :: element
  def beside(this, that, align \\ :center) do
    h = max(height(this), height(that))
    this = higher(this, h, align)
    that = higher(that, h, align)

    Enum.zip(this, that)
    |> Enum.map(fn {l1, l2} -> l1 <> l2 end)
  end
end
