-- Author:              Drew Tomkins
--
-- Last modified:       23.10.2021
--
-- Filename:            console.adb
--
-- Description:         Provides the package body for the Console package.
--                      Models the console associated with the AVP system, i.e. 
--                      the reset mechanism that is required to close the 
--                      emergency escape valve.


pragma SPARK_Mode (On); 
package body Console

is
   
   -- Enables the reset mechanism
   procedure Enable_Reset
   is
   begin
	   
      -- Sets the reset status to true and enables the reset mechanism
      Reset_Status:= true;
   
	 
   end Enable_Reset;

   -- Disables the reset mechanism
   procedure Disable_Reset
   is
   begin
	   
      -- Sets the reset status to false and disables the reset mechanism
      Reset_Status:= false;
   
	 
   end Disable_Reset;

   -- Checks to see if the reset mechanism is enabled
   function Reset_Enabled return Boolean
   is
   begin
	   
      -- Gets the current status of the reset mechanism and returns it
      return Reset_Status;
   
	 
   end Reset_Enabled;
   
  
   
end Console;
