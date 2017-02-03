set body_kerbin to lexicon().

body_kerbin:add (
    "getG", {
        return ship:sensors:grav.
    }
).

body_kerbin:add (
    "orbitHeight",
    80000
).

body_kerbin:add (
    "orbitSpeed",
    
).