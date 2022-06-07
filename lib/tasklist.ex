defmodule Tasklist do
  defstruct id: 0, entries: %{}
  def hello do
    :world
  end
  def new(), do: %Tasklist{}

  def addTaskList(tasklist, entry) do
   entry = Map.put(entry, :id, tasklist.id)

   newentries = Map.put(
     tasklist.entries,
     tasklist.id,
     entry
   )

   %Tasklist{
     tasklist
     | entries: newentries,
      id: tasklist.id + 1
   }
  end

  def getTaskList(tasklist, date) do
    tasklist.entries
    |> Stream.filter(fn {_, entry,} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end
end
