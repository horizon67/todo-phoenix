defmodule TodoPhoenixWeb.TaskControllerTest do
  use TodoPhoenixWeb.ConnCase
  import TodoPhoenix.TodoFixtures

  @create_attrs %{
    content: "bar",
    state: :new
  }
  @update_attrs %{
    content: "foo",
    state: :doing
  }
  @invalid_attrs %{content: nil}
  @blank_params %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "ステータスコード200を返却すること", %{conn: conn} do
      conn = get(conn, Routes.task_path(conn, :index))
      assert json_response(conn, :ok)["data"] == []
    end
  end

  describe "create task" do
    test "登録に成功した場合、ステータスコード201を返却すること", %{conn: conn} do
      conn = post(conn, Routes.task_path(conn, :create), task: @create_attrs)
      assert response(conn, :created)
    end

    test "パラメータが不正な場合、ステータスコード422を返却すること", %{conn: conn} do
      conn = post(conn, Routes.task_path(conn, :create), task: @invalid_attrs)
      assert response(conn, :unprocessable_entity)
    end

    test "パラメータが空の場合、ステータスコード400を返すこと", %{conn: conn} do
      conn = post(conn, Routes.task_path(conn, :create), @blank_params)

      assert response(conn, :bad_request)
    end
  end

  describe "update task" do
    setup [:create_task]

    test "更新に成功した場合、ステータスコード200を返却すること", %{conn: conn, task: task} do
      conn = patch(conn, Routes.task_path(conn, :update, task), task: @update_attrs)
      assert response(conn, :ok)
    end

    test "パラメータが不正な場合、ステータスコード422を返却すること", %{conn: conn, task: task} do
      conn = patch(conn, Routes.task_path(conn, :update, task), task: @invalid_attrs)
      assert response(conn, :unprocessable_entity)
    end

    test "パラメータが空の場合、ステータスコード400を返すこと", %{conn: conn, task: task} do
      conn = patch(conn, Routes.task_path(conn, :update, task), @blank_params)

      assert response(conn, :bad_request)
    end
  end

  describe "delete task" do
    setup [:create_task]

    test "削除に成功した場合、ステータスコード204を返却すること", %{conn: conn, task: task} do
      conn = delete(conn, Routes.task_path(conn, :delete, task))
      assert response(conn, :no_content)
    end
  end

  defp create_task(_) do
    task = task_fixture()
    %{task: task}
  end
end
