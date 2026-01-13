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

For more information, refer to the [documentation](https://hexdocs.pm/cando).

## Adding to Phoenix

Simply import `Cando` into the application `html_helpers`, like do:

```elixir
defmodule MyAppWeb do
  defp html_helper do
    quote do
      import Cando
    end
  end
end
```

You can now access the `can*` functions in your templates and views.

In order to return alternate status codes when `Cando.Permission` is raised simply add the following to your project:

```elixir

defimpl Plug.Exception, for: Cando.PermissionError do
  def status(_exception), do: 403
  def actions(_), do: []
end
```
