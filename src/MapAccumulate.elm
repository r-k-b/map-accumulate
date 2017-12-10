module MapAccumulate exposing (mapAccumL)

{-| dfoo
@docs mapAccumL
-}


{-| mapAccumL
-}
mapAccumL : (a -> acc -> ( b, acc )) -> acc -> List a -> ( List b, acc )
mapAccumL f acc xxs =
    case xxs of
        [] ->
            ( [], acc )

        x :: xs ->
            let
                ( y, acc_ ) =
                    f x acc

                ( ys, acc__ ) =
                    mapAccumL f acc_ xs
            in
                ( y :: ys, acc__ )
