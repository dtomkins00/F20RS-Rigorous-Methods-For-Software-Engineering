-- Author:              Drew Tomkins
--
-- Last modified:       23.10.2021
--
-- Filename:            escapevalve.adb
--
-- Description:         Provides the package body for the Escapevalve package.
--                      Models the emergency escape valve associated with the 
--                      pressure vessel.

pragma SPARK_Mode (On);
package body Escapevalve

is
   
   -- Opens the escape valve
   procedure Open
   is
   begin
	   
      -- Sets the state to true and opens the escape valve
      State:= true;
   
   end Open;

   -- Closes the escape valve
   procedure Close
   is
   begin
	   
      -- Sets the state to true and closes the escape valve
      State:= false;
	   
   end Close;
   

   -- Checks to see if the escape valve is opened
   function Opened return Boolean
   is
   begin
	   
      -- Gets the current status of the escape valve and returns it
      Return State;
	
   end Opened;

end Escapevalve;

