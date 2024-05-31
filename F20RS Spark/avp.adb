-- Author:              Drew Tomkins
--
-- Last modified:       24.10.2021
--
-- Filename:            avp.adb
--
-- Description:         Provides the package body for the AVP package.
--                      This models the overall control for the AVP system, which
--                      serves as the central system that handles the rest of the
--                      subsystems for the overall system.

pragma SPARK_Mode (On);
with Alarm, Escapevalve, Sensors, Console;
package body AVP

is
   -- Serves as the controller for the entire AVP system and uses the
   -- 4 subsystems accordingly to control it
   procedure Control is
      -- Declares a variable for the sensor value by giving it the Sensor_Type subtype
      -- from the Sensors package
      Sensor_Value: Sensors.Sensor_Type;
   begin
   
      -- Assigns the reading from the Read_Sensor_Majority function in
      -- the Sensors package to the Sensor_Value variable
      Sensor_Value := Sensors.Read_Sensor_Majority;
   
      -- Checks to see if the escape valve isn't opened
      if Escapevalve.Opened = false then
    
         -- Checks to see if the sensor reading was below 100
         if (Sensor_Value < 100) then
	  
            -- Checks to see if the alarm is currently active
            if Alarm.Enabled = True then
               -- Shuts off the alarm if it is active
               Alarm.Disable;
            end if;

            -- Checks to see if the reading is equal to or above 100
         else if (Sensor_Value >= 100) then
		 
               -- If the value is above 100, then this checks to see if
               -- the reading is below or equal to 149
               if (Sensor_Value <= 149) then
                  -- Checks to see if the alarm is disabled
                  if Alarm.Enabled = False then
                     -- Sets off the alarm if it isn't already on
                     Alarm.Enable;				
                  else
                     -- If the value doesn't decrease on the next reading
                     -- then open the escape valve
                     Escapevalve.Open;
                  end if;
			
                  -- Checks to see if the reading is equal to or over 150
               else if (Sensor_Value >= 150) then
                     -- Open the escape valve if the above is true
                     Escapevalve.Open;
                     -- Checks to see if the alarm isn't on
                     if Alarm.Enabled = False then
                        -- Sets off the alarm if it isn't already on
                        Alarm.Enable;
                     end if;
                  end if;
               end if;
            end if;

            -- Checks to see if the reset mechanism is enabled from the console
            if Console.Reset_Enabled = true then
               -- Reset mechanism turns off the alarm...
               Alarm.Disable;
               -- and closes the escape valve
               Escapevalve.Close;
            end if;
         end if;
      end if;
		 
   end Control;
end AVP;
