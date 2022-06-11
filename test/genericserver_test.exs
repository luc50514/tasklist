defmodule GenericServerTest do
  use ExUnit.Case
  doctest GenericServer

  test "GenericServer.start should return not nill" do
    assert GenericServer.start(TaskServer) != nil
  end

  test "GenericServer.call should return test" do
    serverid = GenericServer.start(TaskServer)
    assert GenericServer.call(serverid, {:gettasks, ~D[2022-06-05]})  == []
  end

  test "GenericServer.cast should return test" do
    serverid = GenericServer.start(TaskServer)
    assert GenericServer.cast(serverid, {:addTask, ~D[2022-06-05]})  == {:cast, {:addTask, ~D[2022-06-05]}}
  end
end
