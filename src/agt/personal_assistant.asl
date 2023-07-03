// Translation of the low, medium, high temperature levels into the internal agent scale
level_temp(low,    10) .
level_temp(medium, 20) .
level_temp(high,   30) .

// Inference of the preferred temperature level from the activity
pref_temp(T) :- activity(A) & preferred(A, L) & level_temp(L, T) .

+activity(A) : A \== "none"
  <- ?pref_temp(T) ;
     .print("New user activity ", A, " preferred temperature is ", T) ;
     .send(room_agent, tell, pref_temp(T)) .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }