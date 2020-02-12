
# mapAccumulate

![.github/workflows/make.yml](https://github.com/r-k-b/map-accumulate/workflows/.github/workflows/make.yml/badge.svg)

"Map Accumulate" helpers for Elm.

Useful if you want to modify items in two lists, each based on everything in 
the other list. For example, bullets hitting targets - we check which
bullets have collided with which targets, and for each collision we modify 
(or remove) the bullet and modify (or remove) the target.
