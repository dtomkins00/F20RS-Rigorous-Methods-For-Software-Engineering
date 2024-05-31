-- Author:              Drew Tomkins
--
-- Last modified:       23.10.2021
--
-- Filename:            alarm.adb
--
-- Description:         Provides the package body for the Alarm package.
--                      Models the alarm device associated with
--                      the AVP controller and the alarm count.

pragma SPARK_Mode (On);
package body Alarm 
is
   -- Sets off the alarm
   procedure Enable
   is
   begin
      -- Sets the alarm state to true and triggers the alarm
      Alarm_State:= True;
      -- Adds 1 to the alarm count
      Alarm_Cnt:= Alarm_Cnt + 1;
       
   end Enable;
   
   -- Turns the alarm off
   procedure Disable
   is
   begin   
      -- Sets the alarm state to false and turns the alarm off
      Alarm_State:= False;
   end Disable;

   -- Checks the current alarm state to see if the alarm is currently active
   function Enabled return Boolean
   is
   begin
	   
      -- Return the current state of the alarm
      return Alarm_State;
  
   end Enabled;

   -- Gets the current alarm count
   function Alarm_Cnt_Value return Integer
   is
   begin

      -- Returns the current count of alarms at that point
      return Alarm_Cnt;
  
   end Alarm_Cnt_Value;
   
begin
   
   -- Sets the alarm state to false so the alarm begins as off
   Alarm_State := false;
   -- Sets the alarm count to 0
   Alarm_Cnt := 0;

end Alarm;
