defmodule GleamComponent do
  defmacro __using__(opts) do
    # TODO: Change this to use gleam.component/0
    unless Keyword.has_key?(opts, :component) do
      raise "You must provide a component module with GleamComponent."
    end

    quote location: :keep do
      use Scenic.Component

      alias Scenic.Graph

      require Logger

      def verify(data) do
        unquote do
          case Kernel.function_exported?(opts[:component], :verify, 1) do
            true ->
              quote do
                unquote(opts)[:component].verify(data)
              end

            false ->
              raise "Component module must implement verify/1"
          end
        end
      end

      def info(_data) do
        "todo"
      end

      def init(data, opts) do
        unquote do
          case Kernel.function_exported?(opts[:component], :init, 1) do
            true ->
              quote do
                case unquote(opts)[:component].init(data) do
                  {state, %Graph{} = graph} -> {:ok, {state, graph}, push: graph}
                  result -> {:stop, {:bad_init, result}}
                end
              end

            false ->
              raise "Component module must implement init/1"
          end
        end
      end

      def handle_info(message, state) do
        case Kernel.function_exported?(opts[:component], :update, 3) do
          true ->
            quote do
              try do
                state = unquote(opts)[:component].update(state, message)

                {:noreply, state}
              end
            end

          false ->
            {:noreply, state}
        end
      end
    end
  end
end
