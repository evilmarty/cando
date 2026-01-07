defmodule Cando do
  @moduledoc """
  An Elixir library for managing permissions.

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

  """

  defprotocol Permission do
    @fallback_to_any true

    @doc """
    Checks if the given subject has permission to perform the specified action.
    """
    @spec can?(any(), any()) :: boolean()
    def can?(subject, action)
  end

  defmodule PermissionError do
    @moduledoc """
    An error raised when a permission check fails.
    """

    defexception message: "permission denied", subject: nil, action: nil
  end

  @doc """
  Checks if the given subject has permission to perform the specified action.
  """
  def can?(subject, action), do: Permission.can?(subject, action)

  @doc """
  Checks if the given subject does not have permission to perform the specified action.
  """
  def cannot?(subject, action), do: !can?(subject, action)

  @doc """
  Raises a `PermissionError` if the subject does not have permission to perform the specified action.
  """
  def can!(subject, action) do
    can?(subject, action) || raise %PermissionError{subject: subject, action: action}
  end

  @doc """
  Raises a `PermissionError` if the subject has permission to perform the specified action.
  """
  def cannot!(subject, action) do
    cannot?(subject, action) || raise %PermissionError{subject: subject, action: action}
  end
end

defimpl Cando.Permission, for: Any do
  def can?(_subject, _action), do: false
end
