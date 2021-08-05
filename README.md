# Markex

A small package for creating 2D markup. 
Will be actively used in my projects. 
If you also decided to use my tool, then feel free to send corrections and suggestions

## Installation

This package [available in Hex](https://hex.pm/packages/markex) and can be installed
by adding `markex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:markex, "~> 1.1.0"}
  ]
end
```

## Usage

```elixir
import Markex.Element.Operators
alias Markex.Element

text = Element.new("some text")
space = Element.new(" ")
hor_bar = Element.new("@", 11, 1)
vert_bar = Element.new("@", 1, 5)


vert_bar <|> (hor_bar <~> space <~> text <~> space <~> hor_bar) <|> vert_bar 
|> Element.to_string()
|> IO.puts()

#   Result:
#     @@@@@@@@@@@@@
#     @           @
#     @ some text @
#     @           @
#     @@@@@@@@@@@@@

```

[Documentation on hex](https://hexdocs.pm/markex/readme.html).

