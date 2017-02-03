run vectors.

//make throttle directly controllable.
set t to 1.
lock throttle to t.

//Kerbins G
set kerbinG to 9.8.

set g to kerbinG.

set steer to heading(90, 90).
lock steering to steer.

//staging trigger.
set lockstaging to 0.
when maxthrust = 0 then {
    if lockstaging = 0 {
        print "Staging".
        stage.
        wait 0.1.
    }
    preserve.
}.

//gets maximum acceleration for the current point in time.
function getMaxA {
    return (maxthrust / ship:mass).
}

//gets the current combined thrust of all engines.
function getThrust {
    return maxThrust * t.
}

//gettimeToAltitude.
function getTimeToAltitude {
    parameter desiredAltitude is 0.
    return ((alt:radar - desiredAltitude) / abs(verticalspeed)).
}

//gets the time required to come to a stop when falling straight down.
function getStopTime {
    return abs(verticalspeed) / (getMaxA() - g).
}

//woop woop.
function suicideBurn {
    parameter desiredAlt is 0.
    until alt:radar < desiredAlt {
        set timeToAltitude to getTimeToAltitude(desiredAlt).
        set stopTime to getStopTime().
        clearscreen.
        print "BRACE!".
        print "Time to Alt: " + desiredAlt + " : " + timeToAltitude.
        print "stopTime:    " + stopTime.

        if (timeToAltitude < (stopTime)) {
            gear on.
            set t to 1.
        }
        if (timeToAltitude > (stopTime)) {
            set t to 0.
        }
    }
}

function land {
    parameter waitTime is 30.
    set t to 0.
    extendGear().
    sas off.
    set steer to heading(90, 90).
    set stamp to time:seconds + waitTime.
    wait until time:seconds > stamp.
}

function getPoint {
    parameter seconds is 5.
}

//acc = -g.
//avgV = curV / 2.
//tV0 = (curV / acc):mag.
//ptV0 = avgV * tV0.

function getPredict {
        set a to -1 * g.
        set avgV to ship:velocity:surface / 2.
        set tV0 to (ship:velocity:surface:mag / a).
        return -1 * (avgV * tV0).
}

function predict {
        set v to getPredict().
        clearScreen.
        clearVecDraws().
        vectors["drawSurfaceVelocityX"]().
        vectors["drawSurfaceVelocityY"]().
        vectors["drawSurfaceVelocityZ"]().
        vectors["drawPredictedHeight"]().
        vectors["drawGravityVector"]().
        vectors["drawPredictions"]().
}

function test {
    set velocity to vecDraw (
      V(0,0,0),
      ship:velocity:surface,
      RGB(1,0,0),
      "Velocity",
      1.0,
      TRUE,
      0.2
    ).
}

//run test.
//arr["test"]().

until false {
    on ag1 {
        set t to 0.
    }
    
    on ag2 {
        set t to 1.
    }
    
    on ag3 {
        set steer to heading(90, 45).
    }
    
        predict().
}