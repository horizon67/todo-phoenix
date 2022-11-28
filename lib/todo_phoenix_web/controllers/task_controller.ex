defmodule TodoPhoenixWeb.TaskController do
  use TodoPhoenixWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias TodoPhoenix.Todo
  alias TodoPhoenix.Todo.Task

  # alias OpenApiSpex.Schema
  alias TodoPhoenixWeb.OpenApi.Schemas
  use Phoenix.Controller

  tags ["tasks"]
  security [%{}, %{"petstore_auth" => ["write:tasks", "read:tasks"]}]

  operation :index,
    summary: "List tasks",
    description: "List all tasks",
    responses: [
      ok: {"Task List Response", "application/json", Schemas.TasksResponse}
    ]
  def index(conn, _params) do
    tasks = Todo.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  operation :create,
    summary: "Create task (this line becomes the operation's `summary`)",
    description: "Create a task (this block of text becomes the operation's `description`)",
    request_body:
      {"The task attributes", "application/json", Schemas.TaskRequest, required: true},
    responses: [
      created: {"Task Response", "application/json", Schemas.TaskResponse},
      bad_request: Schemas.GenericError.response()
    ]
  def create(conn, %{"task" => task_params}) do
    case Todo.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_status(:created)
        |> render("task.json", task: task)
      {:error, _} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  def create(conn, _), do: send_resp(conn, :bad_request, "")

  operation :update,
    summary: "Update task",
    parameters: [
      id: [in: :path, description: "Task ID", type: :integer, example: 123]
    ],
    request_body: {"Task params", "application/json", Schemas.TaskRequest, required: true},
    responses: [
      ok: {"Task Response", "application/json", Schemas.TaskResponse},
      bad_request: Schemas.GenericError.response()
    ]
  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Todo.get_task!(id)

    case Todo.update_task(task, task_params) do
      {:ok, task} ->
        render(conn, "task.json", task: task)
      {:error, _} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  def update(conn, _), do: send_resp(conn, :bad_request, "")

  operation :delete,
    summary: "Delete task",
    parameters: [
      id: [in: :path, description: "Task ID", type: :integer, example: 123]
    ],
    responses: [
      no_content: Schemas.NoContent.response()
    ]
  def delete(conn, %{"id" => id}) do
    task = Todo.get_task!(id)

    case Todo.delete_task(task) do
      {:ok, %Task{}} ->
        send_resp(conn, :no_content, "")
      {:error, _} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end
end
