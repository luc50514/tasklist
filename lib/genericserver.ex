defmodule GenericServer do
  def start(module) do
    spawn(fn ->
      initvalues = module.init()
      loop(module, initvalues)
    end)
  end

  defp loop(module, current) do
    receive do
      {:call, request, caller} ->
        {response, newvalue} =
          module.handlecall(
            request,
            current
          )
      send(caller, {:response, response})
      loop(module, newvalue)
      {:cast, request} ->
        newvalue = module.handlecast(
          request,
          current
        )
      loop(module, newvalue)
    end

  end
  def call(serverid, request) do
    send(serverid, {:call, request, self()})
    receive do
      {:response, response} ->
        response
    end
  end
  def cast(serverid, request) do
    send(serverid, {:cast, request})
  end
end
