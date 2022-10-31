defmodule TodoPhoenix.TodoTest do
  use TodoPhoenix.DataCase
  import TodoPhoenix.TodoFixtures

  alias TodoPhoenix.Todo
  alias TodoPhoenix.Todo.Task

  describe "task.list_tasks" do
    test "taskが配列で取得できること" do
      task = task_fixture()
      assert Todo.list_tasks() == [task]
    end
  end

  describe "task.create_task" do
    @valid_attrs %{content: "bar", state: :doing}
    @invalid_attrs %{content: nil}

    test "taskが登録できること" do
      assert {:ok, %Task{} = task} = Todo.create_task(@valid_attrs)
      assert task.content == "bar"
      assert task.state == :doing
    end

    test "パラメータが不正な場合、Changesetエラーが返却されること" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task(@invalid_attrs)
    end
  end
end
