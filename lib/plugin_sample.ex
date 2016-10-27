defmodule PluginSample do
  require Logger

  def get_plugins() do
    plugins = Enum.map(Application.get_env(:plugin_sample, :plugins), fn %{path: path, mod: mod} ->
      try do
        Code.append_path(path)
        {:module, mod}= Code.ensure_loaded(mod)
        apply(mod, :plugin_init, [])
        mod
      rescue
        error ->
          Logger.warn "plugin loading failed: #{mod}, #{error}"
          nil
      end
    end) |> Enum.filter(fn x -> not is_nil(x) end)
  end

  def call_plugins(plugins) do
    Enum.each(plugins, fn mod ->
      try do
        apply(mod, :call, [])
      rescue
        error ->
          Logger.warn "#{mod}.call failed: #{error}"
      end
    end)
  end

  def callback() do
    IO.puts "callback called"
  end

end
