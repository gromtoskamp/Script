set Warping to lexicon(

    //Warps an amount of seconds and waits with
    //execution of the rest of the script to prevent problems.
    "warpSeconds", {
        parameter seconds.
        set t to 0.
        wait until (getThrust() = 0).
        set refTime to time:seconds.
        warpTo(time:seconds + seconds).
        wait until(time:seconds > refTime + seconds).
        print "Warp completed!".
    },

    //Warps to nextNode
    "warpToNode", {
        parameter offset is 30.
        parameter node is nextNode.
        wait until (getThrust() = 0).
        warpSeconds(node:eta - (getTimeToBurn() / 2) - offset).
    },

    //Warp to right before transition and wait a few seconds to
    //ensure smooth transition.
    "transition", {
        warpSeconds(eta:transition - 1).
        wait 5.
        //setCurrentBody for the body of the new SOI.
    }

).

