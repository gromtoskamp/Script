set Bodies to lexicon(

    "Kerbin", lexicon(
        "orbitHeight", 80000
        "orbitSpeed", {
            declare local B to Bodies["getCurrentBody"]().
            return sqrt(B:mu / (B:radius + Bodies["Kerbin"]["orbitHeight"])
        }
    ).
).

