        
mtype = {critical, normal, open, close, on, off}

byte sensor_value = 100;

chan pressure = [1] of {mtype};
chan escapevalve = [1] of {mtype};
chan alarm = [1] of {mtype};
chan sensor_reading = [1] of {byte};

#define sensorcheck sensor_reading >=0 || sensor_reading <=149 || sensor_reading >=150 || sensor_reading <=199
#define pressurecheck len(pressure == 1)
#define valuecheck len(sensor_reading == 1)
#define escapevalvecheck len(escapevalve == 1)
#define alarmcheck len(alarm == 1)

ltl p1 { [] sensorcheck }
ltl p2 { [] pressurecheck -> <> valuecheck }
ltl p3 { []!(escapevalvecheck==open && alarm==on) }

active proctype control(){ 
    do
    :: sensor_reading!>=150 && <=200;
       pressure?critical;
       escapevalve?open;
       alarm?on;
    :: sensor_reading!>=0 && <=149;
       pressure?normal;;
       escapevalve?close;
       alarm?off;

    od
}

	
active proctype env(){   

    do
    :: (sensor_value >=150 && <=199) -> sensor_reading?>=150 && <=200;
                                        pressure!critical;
                                        escapevalve!open;
                                        alarm!on;
                                        sensor_value = sensor_value-1;
    :: (sensor_value >=0 && <=149) -> sensor_reading?>=0 && <=149;
                                      pressure!normal;
                                      escapevalve!close;
                                      alarm!off;
                                      sensor_value = sensor_value+1;
    od
}


 active proctype monitor(){   
    do :: assert sensor_value >= 0; sensor_value <= 149 ||
                   sensor_value >= 150; sensor_value <= 199; 
    od
}

init{
       ryn monitor();
       run control();
       run env();
}
