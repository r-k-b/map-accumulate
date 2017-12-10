module MapAccumulate exposing (mapAccumL)

{-|


# MapAccumulate

@docs mapAccumL

-}


{-| From [Haskell's documentation][haskelldocs]:

> The mapAccumL function behaves like a combination of fmap and foldl; it
> applies a function to each element of a structure, passing an accumulating
> parameter from left to right, and returning a final value of this
> accumulator together with the new structure.

Originally based on fatho's [labyrinth] project.

[haskelldocs]: https://hackage.haskell.org/package/base-4.10.1.0/docs/Data-List.html#v:mapAccumL
[labyrinth]: https://github.com/fatho/labyrinth/blob/8a522c0bdfbd5459bc00d9b1ba3334483995dbd7/Util.elm#L28-L35


### example 1

Given a string `a` and a list of integers, test each integer `b`.
If `b` is odd, append it to `a`, and multiply it by 10 inside the list.

    a = ""
    b = [ 1, 2, 3, 4 ]

    func : Int -> String -> ( Int, String )
    func b a =
        if b % 2 == 0 then
            -- even
            ( b, a )
        else
            -- odd
            ( b * 10, a ++ "," ++ toString b )

    mapAccumL func "" [ 1, 2, 3, 4 ]
        -- == `( [ 10, 2, 30, 4], ",1,3" )`.


### example 2

Given a string `a` and a list of integers, test each integer `b`.
If `b` is odd, append it to `a`, and remove it from the list.

    a = ""
    b = [ 1, 2, 3, 4 ]

    func : Int -> String -> ( Maybe Int, String )
    func b a =
        if b % 2 == 0 then
            -- even
            ( Just b, a )
        else
            -- odd
            ( Nothing, a ++ "," ++ toString b )

    justSomethings : (List (Maybe a), b) -> (List a, b)
    justSomethings =
        (\( list, b ) -> ( list |> Maybe.Extra.values, b ))

    mapAccumL func "" [ 1, 2, 3, 4 ]
        |> justSomethings
        -- == `( [ 2, 4], ",1,3" )`.


### example 3

Given a string `a` and a list of integers, test `a` and each integer `b`.
If `b` is odd, append it to `a`, and remove it from the list.
If `b` is `42`, the final `a` must equal `towel!`, and no further `b`s
should be removed from the list.

    a = ""
    b = [ 1, 2, 3, 4 ]

    func : Int -> String -> ( Maybe Int, String )
    func b a =
        if a == "towel!" then
            ( Just b, a )
        else if b == 42 then
            ( Just b, "towel!" )
        else if b % 2 == 0 then
            -- even
            ( Just b, a )
        else
            -- odd
            ( Nothing, a ++ "," ++ toString b )

    justSomethings : (List (Maybe a), b) -> (List a, b)
    justSomethings =
        (\( list, b ) -> ( list |> Maybe.Extra.values, b ))

    mapAccumL func "" [ 1, 2, 3, 42, 5, 6, 7 ]
        |> justSomethings
        -- == `( [ 2, 42, 5, 6, 7 ], "towel!" )`

-}
mapAccumL : (a -> acc -> ( b, acc )) -> acc -> List a -> ( List b, acc )
mapAccumL f acc0 xxs =
    case xxs of
        [] ->
            ( [], acc0 )

        x :: xs ->
            let
                ( y, acc1 ) =
                    f x acc0

                ( ys, acc2 ) =
                    mapAccumL f acc1 xs
            in
                ( y :: ys, acc2 )
