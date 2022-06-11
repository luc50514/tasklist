defmodule TaskServer do
  use GenServer
  def start do
    GenericServer.start(TaskServer)
  end

  def start_link do
    GenServer.start_link(__MODULE__,[]) #Using Module in place of TaskServer
  end

  def getAllGen(serverid) do
    GenServer.call(serverid, :getAll)
  end

  def addTaskGen(serverId, newentry) do
    GenServer.cast(serverId, {:addTask, newentry})
  end

  def addTask(serverId, newentry) do
    GenericServer.cast(serverId, {:addTask, newentry})
  end

  def updatetaskGen(serverid, entry) do
    GenServer.cast(serverid, {:updateTask, entry})
  end

  def getTasks(servierId, date) do
    GenericServer.call(servierId, {:gettasks, date})
  end

  def getTasksGen(servierId, date) do
    GenServer.call(servierId, {:gettasks, date})
  end

  def init do
    Tasklist.new()
  end

  def init(_) do
   send(self(), :process_init)
    {:ok, Tasklist.new()}
  end

  def handlecall({:gettasks, date}, tasklist) do
    {Tasklist.getTaskList(tasklist, date),tasklist}
  end

  def handle_info(:process_init, state) do
    IO.inspect("TaskList is ready")
    {:noreply, state}
  end

  def handle_info(msg, state) do
    IO.inspect("Invalid Message: #{msg}")
    {:noreply, state}
  end

  def handle_call({:gettasks, date}, _from, state) do
    {:reply, Tasklist.getTaskList(state, date),state}
  end

  def handle_call(:getAll, _from, state) do
    {:reply, Tasklist.getalltasks(state),state}
  end

  def handlecast({:addTask, newentry}, taskList) do
    Tasklist.addTaskList(taskList, newentry)
  end

  def handle_cast({:addTask, newentry}, state) do
    {:noreply, Tasklist.addTaskList(state, newentry)}
  end

  def handle_cast({:updateTask, entry}, state) do
    {:noreply, Tasklist.updateTaskList(state, entry)}
  end
end
