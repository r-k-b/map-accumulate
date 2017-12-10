
# mapAccumulate

"Map Accumulate" helpers for Elm.


# examples

Given a string `a` and a list of integers, compare `a` to each integer `b`.
If `b` is odd, append it to `a`, and multiply it by 10 inside the list.

```
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
```