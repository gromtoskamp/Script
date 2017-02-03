set Inclination to lexicon (

    "getTarget", {
        return Node["target"].
    },

    //compensate for frame of reference.
    "getVtarget", {
        set tgt to Inclination["getTarget"]().
        if body:name = "Kerbin" {
            return tgt:velocity.
        } else {
            return -1 * (tgt:body:velocity).
        }
    },

    "getAngularMomentums", {
        set tgt to Inclination["getTarget"]().
        set pm to tgt:position - tgt:body:position.
        set amm to vcrs(pm, Inclination["getVtarget"]()).
        set ps to ship:position - body:position.

        return lexicon(
            "ams0", vcrs(ps, ship:velocity:orbit),
            "ams1", "ams0:mag*amm:normalized"
            "ps", ps
        ).
    },

    "getAngularMomentumInclination", {
        set ang to Inclination["getAngularMomentums"]().
        set inc to vang(ang["ams0"], ang["ams1"]).
        Log["print"]("Inclination: " + round(inc, 1)).
        return inc.
    },

    "getSteeringVector", {
        set ang to Inclination["getAngularMomentums"]().
        set amp to vcrs(ang["ams0"], ang["ams1"]):normalized.
        set amdelta to ang["ams1"] - ang["ams0"].
        return lexicon (
            "amp", amp,
            "amdelta", amdelta
        ).
    },

    "getAnEta", {
        set ang to Inclination["getAngularMomentums"]().
        set strv to Inclination["getSteeringVector"]().
        set amp2ps to vang(strv["amp"], ang["ps"]).
        set side to vdot(amp,velocity:orbit).
        if side > 0 {
            set aburn to amp2ps.
        } else {
            set aburn to 360-amp2ps.
        }
        set smas to ps:mag.
        set ops to 2 * pi * sqrt(smas^3 / mu).
        set eta to aburn / 360 * ops.
        Log["print"](eta)
        return eta.
    },

    "getDeltaV", {
        set ang to Inclination["getAngularMomentums"]().
        set strv to Inclination["getSteeringVector"]().

        return strv["amdelta"]:mag/ang["ps"]:mag.
    },

    "setNode", {
        set inc  to Inclination["getAngularMomentumInclination"]().
        set dv   to Inclination["getDeltaV"]().
        set eta  to Inclination["getAnEta"]().
        set mNode to node(time:seconds + eta, 0, -dv * cos(inc/2), -dv*sin(inc/2)).
        add mNode.
    }
).