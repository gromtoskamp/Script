lock steering to heading(90, 90).
set t to 0.
lock throttle to t.
stage.
set d to 1.

when verticalspeed < -0.1then {
  set d to -1.
  preserve.
}.

when verticalspeed > 0 then {
  set d to 1.
  preserve.
}.

when ship:sensors:acc:mag < 1 then {
  set td to td + 0.1.
  preserve.
}.

when ship:sensors:acc:mag > 1 then {
  set td to td - 0.1.
  preserve.
}.

when ship:altitude > 100 then {
  set t to td.
  preserve.
}.

when ship:altitude < 100 then {
  set 
  preserve.
}.

until ship:altitude > 1000 {
  
}.
