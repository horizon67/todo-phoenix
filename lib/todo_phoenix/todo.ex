defmodule TodoPhoenix.Todo do
  import Ecto.Query, warn: false
  alias TodoPhoenix.Repo
  alias TodoPhoenix.Todo.Task

  @doc """
  タスク一覧を取得する。
  """
  @spec list_tasks() :: [Task.t()]
  def list_tasks do
    Repo.all(Task)
  end

  @doc """
  タスクを作成する。
  """
  @spec create_task(map()) :: {:ok, Task.t()} | {:error, Ecto.Changeset.t()}
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end
end
