set Node to lexicon (

    "target", 0,

    "getTarget", {
        if (Node["target"] = 0) {
            Log["print"]("no target found.").
        }
        return Node["target"].
    },

    "getTimeToBurn", {
        nextNode:deltaV:mag / (maxthrust / ship:mass).
    }

    "burnNode", {
        parameter thr is 1.
        set timeToBurn to Node["getTimeToBurn"]().
        wait (nextnode:eta - (timeToBurn / 2)).
        Log["print"]("burning the node").
        set t to thr.
        wait until nextnode:deltaV:mag < 1.
        set t to 0.
        wait 0.1.
        remove nextnode.
    },

    "executeNode", {
        parameter thr is 1.
        Warping["warpToNode"]().
        Stick["setSasManeuver"]().
        Node["burnNode"](thr).
    },

    "matchInclination", {
        Log["print"]("Matching inclination").

        Inclination["setNode"]().
        Node["executeNode"]().
    }



).