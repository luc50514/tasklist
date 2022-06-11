defmodule TaskServer do

  def start do
    GenericServer.start(TaskServer)
  end

  def addTask(serverId, newentry) do
    GenericServer.cast(serverId, {:addTask, newentry})
  end

  def getTasks(servierId, date) do
    GenericServer.call(servierId, {:gettasks, date})
  end
  def init do
    Tasklist.new()
  end

  def handlecall({:gettasks, date}, tasklist) do
    {Tasklist.getTaskList(tasklist, date),tasklist}
  end

  def handlecast({:addTask, newentry}, taskList) do
    Tasklist.addTaskList(taskList, newentry)
  end

end
