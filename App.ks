run App/Bodies.
run App/Grav.
run App/Log.
run App/Movement.
run App/Node.
run App/Orbiting.
run App/Orbiting/Inclination.
run App/Stick.
run App/Warping.

//main staging trigger.
when maxthrust = 0 then {
    print "Staging".
    stage.
    wait 0.1.
    preserve.
}.

//Main class.
set App to lexicon (

    //Launches to an orbit,
    //taking default orbital height from the current body.
    "launchToOrbit", {
        parameter orbitHeight is Orbiting["getDefaultOrbitHeight"]().

        set Orbiting["orbitHeight"] to orbitHeight.
        set orbitSpeed to Orbiting["getOrbital"].

        Orbiting["launch"]().
        Orbiting["circularize"]().
    },

    "setTarget", {
        parameter tgt.
        set target to tgt.
        set Node["target"] to target.
    },

    "goToTarget", {
        Node["matchInclination"]().
    }

).