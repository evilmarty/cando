# Cando

An Elixir library for managing permissions.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cando` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cando, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/cando>.

## Usage

Implement the `Cando.Permission` protocol for your user or subject structs to define custom permission logic.

```elixir
defmodule MyApp.User do
  defstruct [:id, :role]

  defimpl Cando.Permission do
    def can?(user, _action), do: user.role == :admin
    def can?(_user, _action), do: false
  end
end
```

Then you can check permissions like this:

```elixir
Cando.can?(%MyApp.User{id: 1, role: :admin), :edit_post)  # true
Cando.can?(%MyApp.User{id: 2, role: :guest), :edit_post)  # false
```
