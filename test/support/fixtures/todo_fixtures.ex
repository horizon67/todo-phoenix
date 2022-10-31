defmodule TodoPhoenix.TodoFixtures do
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        content: "hoge",
        state: :new
      })
      |> TodoPhoenix.Todo.create_task()

    task
  end
end
