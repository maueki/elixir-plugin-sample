defmodule PluginSample.Plugin.TestPlugin do
  def plugin_init() do
    IO.puts "call plugin_init"
  end

  def call() do
    PluginSample.callback()
  end
end
