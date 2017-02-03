set Movements to lexicon(

    "setThrust", {
        parameter targetThrust.
        set t to (targetThrust / ship:maxThrust).
    },

    "setTwr", {
        parameter targetTwr.
        set t to (targetTwr * ship:mass * g) / ship:maxThrust.
    },

    "setVerticalSpeed", {
        parameter targetSpeed.
        parameter d is 1.
        set acceleration to d * (targetSpeed - verticalSpeed).
        Movements["setThrust"](ship:mass * (acceleration + g)).
    },

    "setOrbitalSpeed", {
        parameter targetSpeed.
        parameter d is 1.
        set acceleration to d * (targetSpeed - orbit:velocity:orbit:mag).
        Movements["setThrust"](ship:mass * (acceleration + g)).
    },

    "getForwardSpeed", {
        return ship:velocity:surface * ship:facing:forevector.
    },

    "getSideSpeed", {
        return ship:velocity:surface * ship:facing:starvector.
    },

    "getVerticalSpeed", {
        return ship:velocity:surface * ship:facing:upvector.
    }

).