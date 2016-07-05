var outside = props.globals.initNode("/sim/sound/outside-vol", 0, "DOUBLE");
var inside = props.globals.initNode("/sim/sound/inside-vol", 1, "DOUBLE");

setlistener("/sim/current-view/internal", func(vw){
    if(vw.getValue()){
    	print("view switched to INSIDE");
    	outside.setDoubleValue(0);
    	inside.setDoubleValue(1.0);
    }else{
    	print("view switched to OUTSIDE");
    	outside.setDoubleValue(1.0);
    	inside.setDoubleValue(0);
    }
},1,0);