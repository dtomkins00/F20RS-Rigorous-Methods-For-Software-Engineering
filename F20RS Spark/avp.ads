-- Author:              Drew Tomkins
--
-- Last modified:       24.10.2021
--
-- Filename:            avp.adb
--
-- Description:         Provides the package specification for the AVP package.
--                      This models the overall control for the AVP system, which
--                      serves as the central system that handles the rest of the
--                      subsystems for the overall system.

pragma SPARK_Mode (On);
-- Inherit the subsystems packages to be used in the AVP package
with Alarm, Escapevalve, Sensors, Console;
package AVP 

is
   pragma Elaborate_Body;
   
   procedure Control
   with 
     -- Takes in the current state from the Sensors package
     -- and the current reset status from the Console package
     Global => (Input => (Sensors.State, Console.Reset_Status),
     -- Takes the current alarm state from the Alarm package, the
     -- current status of the escape valve from the EscapeValve package
     -- and the current alarm count from the Alarm package to be modified
     -- as necessary
	 In_Out => (Alarm.Alarm_State, Escapevalve.State, Alarm.Alarm_Cnt)),
     -- Checks to see if  the alarm count in the Alarm class is over or equal to 0
     Pre => Alarm.Alarm_Cnt >= 0,
     -- This post-condition checks to see if the end result is true
     Post => True;
end AVP;
