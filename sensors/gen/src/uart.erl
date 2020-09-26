-module(uart).
-compile(no_auto_import).

-export([start_link/0, open/3, read/2]).

start_link() ->
    'Elixir.Circuits.UART':start_link().

open(Pid, Name, Options) ->
    Result = gleam@dynamic:atom('Elixir.Circuits.UART':open(Pid, Name, Options)),
    case Result of
        {ok, _} ->
            {ok, nil};

        {error, Error} ->
            gleam@io:debug(Error),
            {error, <<"Open error. Please see debug."/utf8>>}
    end.

read(A, B) ->
    'Elixir.Circuits.UART':read(A, B).
