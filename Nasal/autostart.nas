#*****************************************************
#* Simple autostart routine to fire all four engines *
#* Globemaster C-17                                  * 
#* (C) Israel Hernandez 2022                         *
#* GPL v3 or Higher                                  *
#*****************************************************

var StartUp = func() {
    gui.popupTip("Starting Engines");
    settimer (APUon, 1);
    settimer (enginesIgnition, 5);
    settimer (enginesSpoolUp, 25);
    settimer (APUoff, 35);
}

var enginesIgnition = func {
    setprop("controls/engines/engine/fuel-pump", 1);
    setprop("controls/engines/engine/cutoff", 1); 
    setprop("controls/engines/engine/starter", 1);
    setprop("controls/engines/engine[1]/fuel-pump", 1);
    setprop("controls/engines/engine[1]/cutoff", 1); 
    setprop("controls/engines/engine[1]/starter", 1);
    setprop("controls/engines/engine[2]/fuel-pump", 1);
    setprop("controls/engines/engine[2]/cutoff", 1); 
    setprop("controls/engines/engine[2]/starter", 1);
    setprop("controls/engines/engine[3]/fuel-pump", 1);
    setprop("controls/engines/engine[3]/cutoff", 1); 
    setprop("controls/engines/engine[3]/starter", 1);
}

var enginesSpoolUp = func {
    setprop("controls/engines/engine/cutoff", 0); 
    setprop("controls/engines/engine[1]/cutoff", 0); 
    setprop("controls/engines/engine[2]/cutoff", 0); 
    setprop("controls/engines/engine[3]/cutoff", 0); 
  
}

var APUon = func {
    setprop("controls/electric/battery-switch",1);
    setprop("controls/electric/APU-generator",1);
}

var APUoff = func {
    setprop("controls/electric/APU-generator",0);
}

