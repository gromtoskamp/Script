set vectors to lexicon().

vectors:add (
    "ship",
    v(0,0,0)
).

vectors:add (
    "drawSurfaceVelocityX", {
        set xVector to vecDraw (
            vectors["ship"],
            v(ship:velocity:surface:x, 0, 0),
            rgb(1,0,0),
            "x",
            1.0,
            true,
            0.2
        ).
    }
).

vectors:add (
    "drawSurfaceVelocityY", {
        set zVector to vecDraw (
            vectors["ship"],
            v(0, 0, ship:velocity:surface:z),
            rgb(0,0,1),
            "y",
            1.0,
            true,
            0.2
           ).
    }
).

vectors:add (
    "drawSurfaceVelocityZ", {
        set zVector to vecDraw (
            vectors["ship"],
            v(0, 0, ship:velocity:surface:z),
            rgb(0,0,1),
            "z",
            1.0,
            true,
            0.2
           ).
    }
).

vectors:add (
    "drawPredictedHeight", {
        set predictedHeightVector to vecDraw (
            vectors["ship"],
            vectors["getPredictedHeightVector"](),
            rgb(1,0,0),
            "PredictedHeight",
            1.0,
            true,
            0.2
        ).
    }
).

vectors:add (
    "getPredictedHeightVector", {
        set a to g.
        set avgV to ship:velocity:surface / 2.
        set tV0 to  ship:velocity:surface:mag / a.
        return (avgV * tV0).
    }
).

vectors:add (
    "drawGravityVector", {
        set gravityVector to vecDraw (
            vectors["ship"],
            vectors["getGravityVector"](),
            rgb(1,0,1),
            "gravity",
            1.0,
            true,
            0.2
        ).
    }
).

vectors:add (
    "getGravityVector", {
        return ship:sensors:grav.
    }
).

vectors:add (
    "getSurfacePositionAt", {
        parameter seconds is 1.
        return (
            positionAt(ship, time:seconds + seconds) -
            (seconds *
                (orbit:velocity:orbit - orbit:velocity:surface)
            )
        ).
    }
).

vectors:add (
    "drawPrediction", {
        parameter seconds is 1.
        set vectorName to "prediction_" + seconds.
        vecDraw (
            vectors["ship"],
            vectors["getSurfacePositionAt"](seconds),
            rgb(1, 0, 0),
            "prediction_" + seconds,
            1.0,
            true,
            0.3
        ).
    }
).

vectors:add (
    "drawPredictions", {
        parameter seconds is 20.
        set s to 0.
        until s > seconds {
            vectors["drawPrediction"](s).
            set s to (s + 1).
        }
    }
).


















