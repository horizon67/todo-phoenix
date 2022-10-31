defmodule TodoPhoenixWeb.TaskController do
  use TodoPhoenixWeb, :controller

  alias TodoPhoenix.Todo
  alias TodoPhoenix.Todo.Task

  def index(conn, _params) do
    tasks = Todo.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    case Todo.create_task(task_params) do
      {:ok, %Task{}} -> send_resp(conn, :created, "")
        send_resp(conn, :created, "")
      {:error, _} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  def create(conn, _), do: send_resp(conn, :bad_request, "")
end
