defmodule MarkexElementTest do
  use ExUnit.Case
  doctest Markex.Element

  alias Markex.Element

  describe "creating element" do
    test "from string" do
      assert Element.new("Hello, world!") == ["Hello, world!"]
    end

    test "from list of strings" do
      list = ["Some long text", "short text"]
      assert Element.new(list) == ["Some long text", "short text    "]
    end

    test "by filling char" do
      assert Element.new("@", 4, 3) == ["@@@@", "@@@@", "@@@@"]
    end

    test "without content" do
      assert Element.new("#", 0, 0) == []
    end
  end

  describe "get the size" do
    test "of a regular element" do
      e = Element.new("4", 13, 19)
      assert Element.size(e) == {13, 19}
    end

    test "of a zero-width element" do
      e = Element.new("4", 0, 19)
      assert Element.size(e) == {0, 0}
    end

    test "of a zero-height element" do
      e = Element.new("4", 13, 0)
      assert Element.size(e) == {0, 0}
    end

    test "of an empty element" do
      e = Element.new("4", 0, 0)
      assert Element.size(e) == {0, 0}
    end
  end

  describe "merging elements" do
    setup do
      elem1 = Element.new("#", 4, 3)
      elem2 = Element.new("@", 2, 1)
      %{1 => elem1, 2 => elem2}
    end

    test "horizontally without arguments", context do
      new_elem = Element.beside(context[1], context[2])
      assert new_elem ==
        ["####  ",
         "####@@",
         "####  "]
    end

    test "horizontally with center alignment", context do
      new_elem = Element.beside(context[1], context[2], :center)
      assert new_elem ==
        ["####  ",
         "####@@",
         "####  "]
    end

    test "horizontally with top alignment", context do
      new_elem = Element.beside(context[1], context[2], :top)
      assert new_elem ==
        ["####@@",
         "####  ",
         "####  ",]
    end

    test "horizontally with bottom alignment", context do
      new_elem = Element.beside(context[1], context[2], :bottom)
      assert new_elem ==
        ["####  ",
         "####  ",
         "####@@"]
    end

    test "horizontally using operators", context do
      import Element.Operators
      new_elem = context[1] <|> context[2]
      assert new_elem ==
        ["####  ",
         "####@@",
         "####  "]
    end

    test "vertically without arguments", context do
      new_elem = Element.over(context[1], context[2])
      assert new_elem ==
        ["####",
         "####",
         "####",
         " @@ "]
    end

    test "vertically with center alignment", context do
      new_elem = Element.over(context[1], context[2], :center)
      assert new_elem ==
        ["####",
         "####",
         "####",
         " @@ "]
    end

    test "vertically with left alignment", context do
      new_elem = Element.over(context[1], context[2], :left)
      assert new_elem ==
        ["####",
         "####",
         "####",
         "@@  "]
    end

    test "vertically with right alignment", context do
      new_elem = Element.over(context[1], context[2], :right)
      assert new_elem ==
        ["####",
         "####",
         "####",
         "  @@"]
    end

    test "vertically using operators", context do
      import Element.Operators
      new_elem = context[1] <~> context[2]
      assert new_elem ==
        ["####",
         "####",
         "####",
         " @@ "]
    end
  end

  test "element to string" do
    str =
      Element.new(["Long text", "short"])
      |> Element.to_string()

    assert str == "Long text\nshort    "
  end
end
