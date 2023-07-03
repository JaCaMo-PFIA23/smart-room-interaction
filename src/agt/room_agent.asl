// gets the average of prefered temperatures sent by user agents
average_pt(T) :- .findall(UT, pref_temp(UT), LT) &
              LT \== [] &
              T = math.average(LT) .

// maintain goal pattern
+!temperature(T) : temperature(P) & (P - T) > 0
  <- turn_on .

+!temperature(T) : temperature(P) & (P - T) <= 0
  <- turn_off .

+temperature(T) : average_pt(P) & T <= P
  <- turn_off .

+pref_temp(UT)[source(Ag)]
   <- .println("New preference from ",Ag," = ",UT) ;
   
      if (pref_temp(Y)[source(Ag)] & UT \== Y) { // a kind of belief revision
         -pref_temp(Y)[source(Ag)] ;             // keeps just the last preference of some agent
      }
      ?average_pt(T) ;
      .drop_desire(temperature(_)) ;
      .println("Creating a new goal to set temperature to ", T) ;
      !temperature(T) .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }