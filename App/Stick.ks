//default to no throttle.
set t to 1.
lock throttle to t.

rcs off.

set Stick to lexicon (

    "steerUp", {
        print "turning off sas".
        print "locking steer to (90, 90)".
        sas off.
        set steer to heading(90, 90).
        lock steering to steer.
    },

    "tipDown", {
        parameter pitch is 0.
        set steer to heading(90, 90 - pitch).
    },

    "setSasManeuver", {
        unlock steering.
        sas on.
        wait 1.
        set sasMode to "maneuver".
        wait 0.1.
    },

    "setSasRetrograde", {
        unlock steering.
        sas on.
        wait 0.1.
        set sasMode to "retrograde".
    }

).