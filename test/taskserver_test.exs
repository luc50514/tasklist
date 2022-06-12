defmodule TaskServerTest do
  use ExUnit.Case
  doctest TaskServer

  test "start should start genericserver" do
    assert TaskServer.start() != nil
  end

  test "start should start genserver" do
    assert TaskServer.start_link() != "test"
  end

  test "init should start a new tasklist" do
    assert TaskServer.init() != nil
  end

  test "init with args should start a new tasklist" do
    assert TaskServer.init(["test"]) != nil
  end

  test "add task should send cast message" do
    serverid = TaskServer.start()
    assert TaskServer.addTask(serverid, %{date: ~D[2022-06-05], value: "Ebill Added"}) == {:cast, {:addTask, %{date: ~D[2022-06-05], value: "Ebill Added"}}}
  end

  test "add task Gen should send cast message using GenServer" do
   {:ok, serverid} = TaskServer.start_link()
    assert TaskServer.addTaskGen(serverid, %{date: ~D[2022-06-05], value: "Ebill Added"}) == :ok
  end

  test "get task should send call message" do
    serverid = TaskServer.start()
    TaskServer.addTask(serverid, %{date: ~D[2022-06-05], value: "Ebill Added"})
    assert TaskServer.getTasks(serverid, ~D[2022-06-05]) == [%{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}]
  end

  test "get all task gen should send call message" do
    {:ok, serverid} = TaskServer.start_link()
    TaskServer.addTaskGen(serverid, %{date: ~D[2022-06-05], value: "Ebill Added"})
    assert TaskServer.getAllGen(serverid) == %{0 => %{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}}
  end

  test "get task gen should send call message" do
    {:ok, serverid} = TaskServer.start_link()
    TaskServer.addTaskGen(serverid, %{date: ~D[2022-06-05], value: "Ebill Added"})
    assert TaskServer.getTasksGen(serverid, ~D[2022-06-05]) == [%{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}]
  end

  test "update task should update task and send cast message" do
    serverid = TaskServer.start()
    TaskServer.addTask(serverid, %{date: ~D[2022-06-05], value: "Ebill Added"})
    assert TaskServer.updatetaskGen(serverid, %{date: ~D[2022-06-05], id: 0, value: "Ebill Added More than 1"}) == :ok
  end

end
