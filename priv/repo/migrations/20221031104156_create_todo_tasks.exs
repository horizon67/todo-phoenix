defmodule TodoPhoenix.Repo.Migrations.CreateTodoTasks do
  use Ecto.Migration

  def change do
    create table(:todo_tasks) do
      add :content, :string
      add :state, :integer

      timestamps()
    end
  end
end
