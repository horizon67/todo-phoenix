defmodule TodoPhoenix.TodoTest do
  use TodoPhoenix.DataCase
  import TodoPhoenix.TodoFixtures

  alias TodoPhoenix.Todo
  alias TodoPhoenix.Todo.Task

  describe "list_tasks" do
    test "taskが配列で取得できること" do
      task = task_fixture()
      assert Todo.list_tasks() == [task]
    end
  end

  describe "create_task" do
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

  describe "update_task" do
    @valid_attrs %{content: "updated", state: :done}
    @invalid_attrs %{content: nil}

    test "taskが更新できること" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Todo.update_task(task, @valid_attrs)
      assert task.content == "updated"
      assert task.state == :done
    end

    test "パラメータが不正な場合、Changesetエラーが返却されること" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_task(task, @invalid_attrs)
    end
  end

  describe "delete_task" do
    test "taskが削除できること" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Todo.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_task!(task.id) end
    end
  end
end
