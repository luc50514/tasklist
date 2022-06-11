defmodule Tasklist do
  defstruct id: 0, entries: %{}
  def hello do
    :world
  end

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %Tasklist{},
      fn entry, acc -> addTaskList(acc, entry) end
    )
  end

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

  def getTaskListById(tasklist, entryId) do
    case Map.fetch(tasklist.entries, entryId) do
      :error -> {:error, tasklist}
      {:ok, entry} -> {:ok, entry}
    end
  end
  def updateTaskList(tasklist, %{} = newentry) do
    updateTaskList(tasklist, newentry.id, fn _ -> newentry end)
  end

  def updateTaskList(tasklist, entryId, update_fn) do
    case Map.fetch(tasklist.entries, entryId) do
      :error ->
        tasklist

      {:ok, oldEntry} ->
        newentry = update_fn.(oldEntry)

      newentries = Map.put(
          tasklist.entries,
          newentry.id,
          newentry
        )

      %Tasklist{
          tasklist
          | entries: newentries
        }
    end

  end
end
