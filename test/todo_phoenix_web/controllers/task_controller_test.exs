defmodule TodoPhoenixWeb.TaskControllerTest do
  use TodoPhoenixWeb.ConnCase

  @create_attrs %{
    content: "bar",
    state: :new
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
end
