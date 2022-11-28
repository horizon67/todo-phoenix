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
  タスクを取得する。
  """
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  タスクを作成する。
  """
  @spec create_task(map()) :: {:ok, Task.t()} | {:error, Ecto.Changeset.t()}
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  タスクを更新する。
  """
  @spec update_task(Task.t(), map()) :: {:ok, Task.t()} | {:error, Ecto.Changeset.t()}
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  タスクを削除する。
  """
  @spec delete_task(Task.t()) :: {:ok, Task.t()} | {:error, Ecto.Changeset.t()}
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end
end
