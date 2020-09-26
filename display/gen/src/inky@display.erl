-module(inky@display).
-compile(no_auto_import).

-export([new/2, set_pixel/3, get_pixel/2, get_pixels/1]).

new(Width, Height) ->
    {display, gleam@map:new(), Width, Height}.

is_visible(Display, Coordinate) ->
    {X, Y} = Coordinate,
    {display, _, Width, Height} = Display,
    (((X >= 0) andalso (X < Width)) andalso (Y >= 0)) andalso (Y < Height).

map_(Over, Coordinate, With) ->
    case is_visible(Over, Coordinate) of
        true ->
            erlang:setelement(2, Over, With(erlang:element(2, Over)));

        false ->
            Over
    end.

set_pixel(Display, Coordinate, Color) ->
    map_(
        Display,
        Coordinate,
        fun(GleamCaptureVariable) ->
            gleam@map:insert(GleamCaptureVariable, Coordinate, Color)
        end
    ).

get_pixel(Display, Coordinate) ->
    case is_visible(Display, Coordinate) of
        true ->
            {some,
             gleam@result:unwrap(
                 gleam@map:get(erlang:element(2, Display), Coordinate),
                 white
             )};

        _ ->
            none
    end.

get_pixels(Display) ->
    erlang:element(2, Display).
