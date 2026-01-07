defmodule CandoTest do
  use ExUnit.Case
  doctest Cando

  defmodule ExampleUser do
    defstruct [:id, :role]

    defimpl Cando.Permission do
      def can?(user, _action), do: user.role == :admin
    end
  end

  describe "can?" do
    test "returns false for unimplemeted module" do
      refute Cando.can?(:foobar, :edit_post)
    end

    test "returns true for admin user" do
      user = %ExampleUser{id: 1, role: :admin}
      assert Cando.can?(user, :edit_post)
    end

    test "returns false for non-admin user" do
      user = %ExampleUser{id: 1, role: :guest}
      refute Cando.can?(user, :edit_post)
    end
  end

  describe "cannot?" do
    test "returns true for unimplemeted module" do
      assert Cando.cannot?(:foobar, :edit_post)
    end

    test "returns false for admin user" do
      user = %ExampleUser{id: 1, role: :admin}
      refute Cando.cannot?(user, :edit_post)
    end

    test "returns true for non-admin user" do
      user = %ExampleUser{id: 1, role: :guest}
      assert Cando.cannot?(user, :edit_post)
    end
  end

  describe "can!" do
    test "raises error for unimplemeted module" do
      assert_raise Cando.PermissionError, fn -> Cando.can!(:foobar, :edit_post) end
    end

    test "does not raise error for admin user" do
      user = %ExampleUser{id: 1, role: :admin}
      assert Cando.can!(user, :edit_post)
    end

    test "raises error for non-admin user" do
      user = %ExampleUser{id: 1, role: :guest}
      assert_raise Cando.PermissionError, fn -> Cando.can!(user, :edit_post) end
    end
  end

  describe "cannot!" do
    test "does not raise error for unimplemeted module" do
      assert Cando.cannot!(:foobar, :edit_post)
    end

    test "raises error for admin user" do
      user = %ExampleUser{id: 1, role: :admin}
      assert_raise Cando.PermissionError, fn -> Cando.cannot!(user, :edit_post) end
    end

    test "does not raise error for non-admin user" do
      user = %ExampleUser{id: 1, role: :guest}
      assert Cando.cannot!(user, :edit_post)
    end
  end
end
