defmodule TodoPhoenix.Todo.Task do
  @moduledoc """
  Todo.Taskのスキーマ
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  schema "todo_tasks" do
    field :content, :string
    field :state, Ecto.Enum, values: [new: 0, doing: 1, done: 2], default: :new

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:content, :state])
    |> validate_required([:content, :state])
  end
end
