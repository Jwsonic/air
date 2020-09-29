defmodule GleamComponent do
  defmacro __using__(opts) do
    unless Keyword.has_key?(opts, :component) do
      raise "You must provide a component module with GleamComponent"
    end

    # {:component, init_fn, update_fn} = opts[:component].component()

    # {:init_opts, :up, 1, 2} |> init_fn.() |> IO.inspect(label: :call)

    # unless is_function(init_fn, 1) do
    #   raise "Given component does not implement init/1"
    # end

    # unless is_function(update_fn, 2) do
    #   raise "Given component does not implement update_fn/2"
    # end

    # %{module: mod} = __ENV__

    # IO.inspect(mod, label: :module)

    quote bind_quoted: [component: opts[:component]], location: :keep do
      use Scenic.Component

      alias Scenic.Graph

      require Logger

      def verify(data) do
        {:ok, data}
      end

      def info(_data) do
        "todo"
      end

      def init(data, opts) do
        {:component, init_fn, _} = unquote(component).new()

        case init_fn.(data) |> IO.inspect(label: :init) do
          {:state, %Graph{} = graph, _, _, _} = state -> {:ok, {state, graph}, push: graph}
          result -> {:stop, {:bad_init, result}}
        end
      end

      def handle_info(message, state) do
        try do
          {:component, _, update_fn} = unquote(component).new()

          state = update_fn.(state, message)

          {:noreply, state}
        rescue
          _ -> {:noreply, state}
        end
      end
    end
  end
end
