defmodule TasklistTest do
  use ExUnit.Case
  doctest Tasklist

  test "greets the world" do
    assert Tasklist.hello() == :world
  end

  test "Tasklist.new() should return %Tasklist{entries: %{}, id: 0}" do
    assert Tasklist.new() == %Tasklist{entries: %{}, id: 0}
  end

  test "Tasklist.new(entries) should return %Tasklist{entries: %{}, id: 0}" do
    entries = [
      %{date: ~D[2022-06-05], value: "Add Payee"},
      %{date: ~D[2022-06-05], value: "Enroll Payee"},
      %{date: ~D[2022-06-05], value: "Add Bill"}
    ]

    assert Tasklist.new(entries) == %Tasklist{
      entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: "Add Payee"}, 1 => %{date: ~D[2022-06-05], id: 1, value: "Enroll Payee"}, 2 => %{date: ~D[2022-06-05], id: 2, value: "Add Bill"}},
      id: 3
    }
  end

  test "Tasklist.addTaskList(%Tasklist{entries: %{}, id: 0}, %{date: ~D[2022-06-05], value: Ebill Added) should return %Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: Ebill Added}}, id: 1}" do
    assert Tasklist.addTaskList(%Tasklist{entries: %{}, id: 0}, %{date: ~D[2022-06-05], value: "Ebill Added"}) == %Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}}, id: 1}
  end

  test "Tasklist.getalltasks(tasklist) should return entries" do
    task1 = Tasklist.addTaskList(%Tasklist{entries: %{}, id: 0}, %{date: ~D[2022-06-05], value: "Add Payee"})
    task2 =Tasklist.addTaskList(task1, %{date: ~D[2022-06-05], value: "Enroll Payee"})
    task3 = Tasklist.addTaskList(task2, %{date: ~D[2022-06-05], value: "Get Bill from provider"})

    assert Tasklist.getalltasks(task3) == %{0 => %{date: ~D[2022-06-05], id: 0, value: "Add Payee"}, 1 => %{date: ~D[2022-06-05], id: 1, value: "Enroll Payee"}, 2 => %{date: ~D[2022-06-05], id: 2, value: "Get Bill from provider"}}

  end

  test "Tasklist.getTaskList(%{~D[2022-06-05] => [Ebill Added]}, ~D[2022-06-05]) should return [Ebill Added]" do
    assert Tasklist.getTaskList(%Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}}, id: 1}, ~D[2022-06-05]) ==  [%{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}]
  end

  test "Tasklist.updateTaskList should return %Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: Ebill Added More than 1}, id: 1}" do
    assert Tasklist.updateTaskList(%Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}}, id: 1}, %{date: ~D[2022-06-05], id: 0, value: "Ebill Added More than 1"}) == %Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: "Ebill Added More than 1"}}, id: 1}
  end

  test "Tasklist.getTaskListById should return %Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: Ebill Added}, id: 1}" do
    assert Tasklist.getTaskListById(%Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}}, id: 1}, 1) == {:error, %Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}}, id: 1}}
  end

  test "Tasklist.getTaskListById should return map when id is in tasklist" do
    assert Tasklist.getTaskListById(%Tasklist{entries: %{0 => %{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}}, id: 1}, 0) == {:ok, %{date: ~D[2022-06-05], id: 0, value: "Ebill Added"}}
  end

  test "Tasklist.updateTaskList should update values in TaskList" do
    task1 = Tasklist.addTaskList(%Tasklist{entries: %{}, id: 0}, %{date: ~D[2022-06-05], value: "Add Payee"})
    task2 =Tasklist.addTaskList(task1, %{date: ~D[2022-06-05], value: "Enroll Payee"})
    task3 = Tasklist.addTaskList(task2, %{date: ~D[2022-06-05], value: "Get Bill from provider"})
    assert Tasklist.updateTaskList(task3, %{date: ~D[2022-07-05], id: 2, value: "Add july ebill for today"}) == %Tasklist{
      entries: %{
        0 => %{date: ~D[2022-06-05], id: 0, value: "Add Payee"},
        1 => %{date: ~D[2022-06-05], id: 1, value: "Enroll Payee"},
        2 => %{date: ~D[2022-07-05], id: 2, value: "Add july ebill for today"}
      },
      id: 3
    }

  end
end
