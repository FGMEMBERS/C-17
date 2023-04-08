var self = cmdarg();
var float_0 = self.getNode("sim/multiplay/generic/float[0]", 1);
var float_1 = self.getNode("sim/multiplay/generic/float[1]", 1);
var ramp_door = self.getNode("instrumentation/doors/ramp/position-norm", 1);
var para = self.getNode("instrumentation/paras/trigger", 1);
ramp_door.alias(float_1);

var rootindex =  root.getIndex();
print(rootindex);
var power_path = "sim/signals/fdm-initialized"; # Path to 28V DC supply
var rotate_path = "sim/model/lights/beacon"; # Path to beacon rotation property for animation
var strobe_path = "sim/model/lights/strobe"; # Path to strobe
var anim_path = "sim/model/lights/beacon/rotation";
var fullpath = "/ai/models/multiplayer["~ rootindex ~"]";
fullpathrot = fullpath~"/"~rotate_path;
fullpathstr = fullpath~"/"~strobe_path;
fullpathint1 = fullpath~"/"~"instrumentation/paras/trigger";
var int_1 = self.getNode("sim/multiplay/generic/int[1]", 1);
para.alias(int_1);
var onInt1Triggered = func {
    print("Int1 Triggered!");
}
setlistener(int_1, onInt1Triggered);
print("set listener on property: "~fullpathint1);
var mplights = func {
    root.initNode(rotate_path, 0, "DOUBLE");
    root.initNode(anim_path, 0, "DOUBLE");
    var beaconswitch = fullpath ~ "/sim/multiplay/generic/int[5]";
    aircraft.light.new(fullpathrot, [1.2, 1.2], beaconswitch);
    aircraft.light.new(fullpathstr, [0.05, 2.2], power_path);
}

#Beacon Rotation
var rotate = func {
    var trigger = root.getNode("sim/model/lights/beacon/state");
    var state = trigger.getBoolValue();
    speed = 1.2;
    rotpath = fullpath~"/"~anim_path;
    if ( state ) { interpolate(rotpath, 1, speed); }
    if ( !state ) { interpolate(rotpath, 0, speed); }
} 

# Daylight Adjuster
var dayadj = func {
    root.initNode("sim/model/lights/daylight-adjuster", 0.2, "DOUBLE");
    var rad = getprop("/sim/time/sun-angle-rad");
    var fact = ((( 1 / rad ) * 1.4) - 0.25);
    root.getNode("sim/model/lights/daylight-adjuster").setValue(fact);
    #setprop("sim/model/lights/daylight-adjuster", fact);
    settimer(dayadj, 0.5);
}

var init = func {
    var rootindex =  root.getIndex();
    var fullpath = "/ai/models/multiplayer["~ rootindex ~"]";
    var trigger = fullpath ~ "/sim/model/lights/beacon/state";
    setlistener(trigger, rotate);
    mplights();
    dayadj();
}

settimer(init, 1);
