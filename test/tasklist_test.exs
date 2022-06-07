defmodule TasklistTest do
  use ExUnit.Case
  doctest Tasklist

  test "greets the world" do
    assert Tasklist.hello() == :world
  end

  test "Tasklist.new() should return %Tasklist{entries: %{}, id: 0}" do
    assert Tasklist.new() == %Tasklist{entries: %{}, id: 0}
  end

  test "Tasklist.addTaskList(%Tasklist{entries: %{}, id: 0}, %{date: ~D[2022-06-05], value: Ebill Added) should return %Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: Ebill Added}}, id: 1}" do
    assert Tasklist.addTaskList(%Tasklist{entries: %{}, id: 0}, %{date: ~D[2022-06-05], value: "Ebill Added"}) == %Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}}, id: 1}
  end

  test "Tasklist.getTaskList(%{~D[2022-06-05] => [Ebill Added]}, ~D[2022-06-05]) should return [Ebill Added]" do
    assert Tasklist.getTaskList(%Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}}, id: 1}, ~D[2022-06-05]) ==  [%{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}]
  end

end
