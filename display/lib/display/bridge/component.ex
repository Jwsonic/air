defmodule Display.Bridge.Component do
  @moduledoc """
  Component bridge holds functions with the intention of them being called from gleam.
  These functions help "lie" to the gleam compiler to make nice types
  """

  def add_to_graph(graph, component, data, opts) do
    component.add_to_graph(graph, data, opts)
  end

  def build!({:component, init_fn, _update_fn}) do
    component_module = module!(init_fn)
    dynamic_module = Module.concat(Display.GleamComponent, component_module)

    if :code.is_loaded(dynamic_module) == false do
      required_contents = build_required(component_module)

      contents =
        quote do
          unquote(required_contents)

          def handle_info(message, state) do
            try do
              case unquote(component_module).update(state, message) do
                {:ok, state} -> {:noreply, state}
                {:push, state, %Graph{} = graph} -> {:noreply, state, push: graph}
                {:error, reason} -> {:stop, {:bad_update, reason}}
              end
            rescue
              _ -> {:noreply, state}
            end
          end
        end

      Module.create(dynamic_module, contents, Macro.Env.location(__ENV__))
    end

    dynamic_module
  end

  # Big hack to get the module where the component was defined so we can dynamically build a component genserver
  defp module!(func) do
    func |> Function.info() |> Keyword.fetch!(:module)
  end

  defp build_required(component_module) do
    quote do
      use Scenic.Component
      alias Scenic.Graph

      def verify(data) do
        # TODO
        {:ok, data}
      end

      def info(_data) do
        "todo"
      end

      def init(data, _opts) do
        case unquote(component_module).init(data) do
          {:ok, _state} = result -> result
          {:push, state, %Graph{} = graph} -> {:ok, state, push: graph}
          {:error, reason} -> {:stop, {:bad_init, reason}}
        end
      end
    end
  end
end
