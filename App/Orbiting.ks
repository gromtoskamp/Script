set Orbiting to lexicon (

    //in m, desired orbitheight to launch to.
    //set default to current planets default orbitheight.
    "orbitHeight", Orbiting["getDefaultOrbitHeight"](),

    //gets the default orbitheight of the current body.
    "getDefaultOrbitHeight", {
        return Bodies[body:name]["orbitHeight"].
    },

    "getOrbitSpeed", {
        set orbitSpeed to sqrt(body:mu / (body:radius + Orbiting["orbitHeight"]).
        print "calculated orbitSpeed: " + orbitSpeed.
        return orbitSpeed.
    },

    "launch", {
        print "launching".
        set orbitSpeed to Orbiting["getOrbitSpeed"]().
        set correctionalSpeed to (orbitspeed / 20).

        //start by blasting up.
        Stick["steerUp"]().
        set t to 1.

        //to make sure we first go up for a short amount of time
        set correctedSpeed to max(0, ship:velocity:surface:mag - correctionalSpeed).

        //burn until we have an orbiting apoapsis.
        until ship:apoapsis > Orbiting["orbitHeight"] {
            Stick["tipDown"](
                min(90, (correctedSpeed * 2/ orbitSpeed) * 90)
            ).
        }

        //cut the throttle.
        set t to 0.
        wait 0.1.
    },

    "coast", {
        print "coasting to apoaps.".
        until eta:apoapsis < 5 {
            set steer to heading(90, 0).
            if ship:apoapsis < Orbiting["orbitHeight"] {
                set t to 1.
            }

            if ship:apoapsis > Orbiting["orbitHeight"] {
                set t to 0.
            }
        }
    },

    "circularize", {
        print "Circularizing our orbit".
        coast(Orbiting["orbitHeight"]).
        until ship:periapsis > (Orbiting["orbitHeight"] * 0.975) {
            set steer to heading(90, 2).
            if eta:apoapsis < 5 {
                set t to 1.
            }

            if eta:apoapsis > 5 and eta:apoapsis < 100 {
                set t to 0.
            }

            if eta:apoapsis > 100 {
                set steer to heading(90, 10).
                set t to 1.
            }
        }
        set t to 0.
        wait 0.1.
    }

).