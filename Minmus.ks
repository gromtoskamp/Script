//initial stage.
App["launchToOrbit"]().

//find transfer window to the Mun.
findNode().
finetuneNode().

//prepare for burn.
//get to the Mun.
executeNode().

//find finetune node.
findFineTuneNode().
executeNode(0.1).

transition().
enterOrbit().
executeNode().

setSasRetrograde().
wait 10.
set g to munG.
slowdownTo(200).
extendGear().
suicideBurn(10).
land().

print "orbit!".

launchToOrbit().
gear off.
escapeToPeri().

warpSeconds(eta:periapsis - 100).
lowerPeriTo(35000).
set g to kerbinG.
suicideBurn(12).
