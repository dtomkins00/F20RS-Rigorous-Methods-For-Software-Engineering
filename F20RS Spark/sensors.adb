-- Author:              Drew Tomkins

-- Last modified:       23.10.2021
--
-- Filename:            sensors.adb
--
-- Description:         Package body for the Sensors package.
--                      Models the 3 pressure sensors associated with the AVP system. Note that
--                      a single sensor reading is calculated using a majority vote
--                      algorithm.

pragma SPARK_Mode (On); 
package body Sensors
 
is
   
   -- Writes values to each of the 3 sensors
   procedure Write_Sensors(Value_1, Value_2, Value_3: in Sensor_Type)
   is
   begin
      -- For each sensor in the array, a value is assigned to it
      State(1) := Value_1;
      State(2) := Value_2;
      State(3) := Value_3;

   end Write_Sensors;

   -- Reads the sensors that are taken in from the Sensor_Index_Type subtype and returns the sensor in use
   function Read_Sensor(Sensor_Index: in Sensor_Index_Type) return Sensor_Type
   is
      -- Declare the 'sensortype' variable by giving it the Sensor_Type subtype and assigning an initial value to it
      Sensor: Sensor_Type := Init_Value;
	  
   begin
	   
      -- Checks to see if the current value of the sensor index is below the value of the last sensor checked
      if Sensor_Index < Sensor_Index_Type'Last then
         -- If the value is 1 then the sensor is set to the first sensor
         if Sensor_Index = 1 then
            Sensor := State(1);
            -- If the value is 2 then the sensor is set to the second sensor
         elsif Sensor_Index = 2 then
            Sensor:= State(2);
            -- Otherwise the sensor is set to the third sensor
         else
            Sensor:= State(3);
         end if;
      end if;
      -- Return the sensor that was read
      return Sensor;
   end Read_Sensor;
  
   -- Get the majority value of the 3 sensor readings
   function Read_Sensor_Majority return Sensor_Type
   is
      -- Declare the sensortype variable by giving if the Sensor_Type subtype
      sensor_reading: Sensor_Type;
   begin
      -- If Sensors 1 and 2 are equal then the reading to be returned will be that of the first sensor
      if State(1) = State(2) then
         Sensor_Reading:= State(1);
         -- If Sensors 1 and 3 are equal then the reading to be returned will be that of the second sensor
      elsif State(1) = State(3) then
         Sensor_Reading:= State(2);
         -- If Sensors 2 and 2 are equal then the reading to be returned will be that of the third sensor
      elsif State(2) = State(3) then
         Sensor_Reading:= State(3);
         -- If there is no majoirty then the reading to be returned will be undefined
      else
         Sensor_Reading:= Undef_Value;
      end if;
      -- Return the majority reading from the 3 sensors
      return Sensor_Reading;
   end Read_Sensor_Majority;
		
begin
   -- Initialise each sensor in the array with an initial value
   State(1) := Init_Value;
   State(2) := Init_Value;
   State(3) := Init_Value;
   
end Sensors;
