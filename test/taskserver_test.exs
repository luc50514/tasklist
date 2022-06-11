defmodule TaskServerTest do
  use ExUnit.Case
  doctest TaskServer

  test "start should start genericserver" do
    assert TaskServer.start() != nil
  end

  test "init should start a new tasklist" do
    assert TaskServer.init() != nil
  end

  test "add task should send cast message" do
    serverid = TaskServer.start()
    assert TaskServer.addTask(serverid, %{date: ~D[2022-06-05], value: "Ebill Added"}) == {:cast, {:addTask, %{date: ~D[2022-06-05], value: "Ebill Added"}}}
  end

  test "get task should send call message" do
    serverid = TaskServer.start()
    TaskServer.addTask(serverid, %{date: ~D[2022-06-05], value: "Ebill Added"})
    assert TaskServer.getTasks(serverid, ~D[2022-06-05]) == [%{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}]
  end

end
