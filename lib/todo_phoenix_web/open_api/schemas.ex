defmodule TodoPhoenixWeb.OpenApi.Schemas do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  defmodule Task do
    OpenApiSpex.schema(%{
      title: "Task",
      description: "A task of the todo",
      type: :object,
      properties: %{
        id: %Schema{type: :integer, description: "Task ID"},
        content: %Schema{type: :string, description: "Content"},
        state: %Schema{type: :string, enum: [:new, :doing, :done], description: "State"},
        inserted_at: %Schema{
          type: :string,
          description: "Creation timestamp",
          format: :"date-time"
        },
        updated_at: %Schema{type: :string, description: "Update timestamp", format: :"date-time"}
      },
      required: [:content],
      example: %{
        "id" => 123,
        "content" => "test",
        "state" => "doing",
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => "2017-09-13T10:11:12Z"
      }
    })
  end

  defmodule TaskRequest do
    OpenApiSpex.schema(%{
      title: "TaskRequest",
      description: "POST body for creating a task",
      type: :object,
      properties: %{
        task: Task
      },
      required: [:task],
      example: %{
        "task" => %{
          "content" => "test",
          "state" => "new"
        }
      }
    })
  end

  defmodule TaskResponse do
    OpenApiSpex.schema(%{
      title: "TaskResponse",
      description: "Response schema for single task",
      type: :object,
      properties: %{
        data: Task
      },
      example: %{
        "data" => %{
          "id" => 123,
          "content" => "test",
          "state" => "doing"
        }
      },
      "x-struct": __MODULE__
    })
  end

  defmodule TasksResponse do
    OpenApiSpex.schema(%{
      title: "TasksResponse",
      description: "Response schema for multiple tasks",
      type: :object,
      properties: %{
        data: %Schema{description: "The tasks details", type: :array, items: Task}
      },
      example: %{
        "data" => [
          %{
            "id" => 123,
            "content" => "test",
            "state" => "doing"
          },
          %{
            "id" => 456,
            "content" => "test",
            "state" => "doing"
          }
        ]
      }
    })
  end

  defmodule NotFound do
    @moduledoc """
    404 - Not Found
    """
    require OpenApiSpex
    alias OpenApiSpex.Operation

    OpenApiSpex.schema(%{
      title: "NotFound",
      type: :object,
      properties: %{
        errors: %Schema{
          type: :array,
          items: %Schema{
            type: :object,
            properties: %{
              detail: %Schema{type: :string, example: "The requested resource cannot be found."},
              title: %Schema{type: :string, example: "Not Found"}
            }
          }
        }
      }
    })

    def response do
      Operation.response(
        "Not Found",
        "application/json",
        __MODULE__
      )
    end
  end

  defmodule BadRequest do
    @moduledoc """
    400 - Bad Request
    """
    require OpenApiSpex
    alias OpenApiSpex.Operation

    OpenApiSpex.schema(%{
      title: "BadRequest",
      type: :object,
      properties: %{
        errors: %Schema{
          type: :array,
          items: %Schema{
            type: :object,
            properties: %{
              detail: %Schema{type: :string, example: "bad request."},
              title: %Schema{type: :string, example: "Bad Request"}
            }
          }
        }
      }
    })

    def response do
      Operation.response(
        "Bad Request",
        "application/json",
        __MODULE__
      )
    end
  end

  defmodule NoContent do
    require OpenApiSpex
    alias OpenApiSpex.Operation

    OpenApiSpex.schema(%{type: :object, properties: %{}, additionalProperties: false})

    def response do
      Operation.response(
        "No Content",
        "application/json",
        __MODULE__
      )
    end
  end
end
