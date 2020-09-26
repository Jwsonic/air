-module(air_sensors).
-compile(no_auto_import).

-export([pm2/1]).

pm2(Pid) ->
    case uart:read(Pid, 10000) of
        {ok, <<66, 77, FrameLength:16, Pm1:8, Pm2:8, _rest/binary>>} ->
            {ok, Pm2};

        {ok, Data} ->
            {error,
             gleam@string:concat([<<"Unexpected read response: "/utf8>>, Data])};

        _ ->
            {error, <<"Error"/utf8>>}
    end.
