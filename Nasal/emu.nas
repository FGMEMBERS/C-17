## DECU Attempt (!)


## Engines

#Initialise

      var engine1 = engines.Jet.new(0 , 0 , 0.01 , 5.21 , 4 , 4 , 0.05 , 1);
      var engine2 = engines.Jet.new(1 , 0 , 0.01 , 5.21 , 4 , 4 , 0.05 , 1);
      var engine3 = engines.Jet.new(2 , 0 , 0.01 , 5.21 , 4 , 4 , 0.05 , 1);
      var engine4 = engines.Jet.new(3 , 0 , 0.01 , 5.21 , 4 , 4 , 0.05 , 1);

   engine1.init();
   engine2.init();
   engine3.init();
   engine4.init();


props.globals.initNode("/sim/autostart/started", 0, "BOOL");
props.globals.initNode("/sim/engines/state", 0, "INT");

var eng1fuelon = func { setprop("/controls/engines/engine[0]/cutoff", 0);  gui.popupTip("Fuel Pump Engine 1 ON"); }
var eng1fueloff = func { setprop("/controls/engines/engine[0]/cutoff", 1); gui.popupTip("Fuel Pump Engine 1 OFF"); }

var eng2fuelon = func { setprop("/controls/engines/engine[1]/cutoff", 0); gui.popupTip("Fuel Pump Engine 2 ON"); }
var eng2fueloff = func { setprop("/controls/engines/engine[1]/cutoff", 1);  gui.popupTip("Fuel Pump Engine 2 OFF");}
var eng3fuelon = func { setprop("/controls/engines/engine[2]/cutoff", 0);  gui.popupTip("Fuel Pump Engine 3 ON");}
var eng3fueloff = func { setprop("/controls/engines/engine[2]/cutoff", 1);  gui.popupTip("Fuel Pump Engine 3 OFF");}
var eng4fuelon = func { setprop("/controls/engines/engine[3]/cutoff", 0);  gui.popupTip("Fuel Pump Engine 4 ON");}
var eng4fueloff = func { setprop("/controls/engines/engine[3]/cutoff", 1);  gui.popupTip("Fuel Pump Engine 4 OFF");}

var eng1starter = func { setprop("/controls/engines/engine[0]/starter", 1); gui.popupTip("STARTER Engine 1 ON"); }
var eng2starter = func { setprop("/controls/engines/engine[1]/starter", 1); gui.popupTip("STARTER Engine 2 ON"); }
var eng3starter = func { setprop("/controls/engines/engine[2]/starter", 1); gui.popupTip("STARTER Engine 3 ON"); }
var eng4starter = func { setprop("/controls/engines/engine[3]/starter", 1); gui.popupTip("STARTER Engine 4 ON"); }

var enginesrunning = func{
   # startup mode
   setprop("/sim/engines/state", 10);
}

var eng1start = func {
   setprop("/sim/engines/state", 1);  
   eng1fueloff();
   eng1starter();
   settimer(eng1fuelon, 2);
}

var eng2start = func {
   setprop("/sim/engines/state", 2);  
   eng2fueloff();
   eng2starter();
   settimer(eng2fuelon, 2);
};

var eng3start = func {
   setprop("/sim/engines/state", 3);  
   eng3fueloff();
   eng3starter();
   settimer(eng3fuelon, 2);
};

var eng4start = func {
   setprop("/sim/engines/state", 4);  
   eng4fueloff();
   eng4starter();
   settimer(eng4fuelon, 2);
   settimer(enginesrunning,30);
};

var engstart = func {
   # startup mode
    
   settimer(eng1start, 2);
   settimer(eng2start, 30);
    settimer(eng3start, 60);
    settimer(eng4start, 90);
}

var enginesoff = func{
   # engines off mode
   setprop("/sim/engines/state", 0);
}

var engstop = func {
   # shutdown mode
      eng1fueloff();    setprop("/sim/engines/state", 11);  
      eng2fueloff();    setprop("/sim/engines/state", 12);  
      eng3fueloff();    setprop("/sim/engines/state", 13);  
      eng4fueloff();    setprop("/sim/engines/state", 14);  
    settimer(enginesoff,15);
}

var autostart = func {
   var startstatus = getprop("/sim/autostart/started");
   if ( startstatus == 0 ) {
      gui.popupTip("Autostarting...");
      setprop("/sim/autostart/started", 1);
      setprop("/controls/electric/battery-switch", 1);
      settimer(engstart, 0.5);
      gui.popupTip("Starting Engines");
     }
   if ( startstatus == 1 ) {
      gui.popupTip("Shutting Down...");
      setprop("/sim/autostart/started", 0);
     eng1fueloff();
      eng2fueloff();
   }
   
}

var autostop = func {
   eng1fueloff();
   eng2fueloff();
   eng3fueloff();
   eng4fueloff();
   apufueloff();
}