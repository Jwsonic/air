-module(inky).
-compile(no_auto_import).

-export([start_link/2, set_display/2]).

start_link(A, B) ->
    'Elixir.Inky':start_link(A, B).

set_display(Pid, Display) ->
    'Elixir.Inky':set_pixels(Pid, inky@display:get_pixels(Display)).
