pragma Task_Dispatching_Policy(FIFO_Within_Priorities);
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with System; use System;

procedure p9 is

	procedure Infinite_Work is
		F : Duration := 0.0;
	begin
		Put_Line("Working");
		loop
			for J in 1 .. 10000000 loop
				F := F + Duration(J * 10.0);
			end loop;
			Put_Line("Still Working");
		end loop;
	end Infinite_Work;
	
	task Start;
	
	task body Start is
	begin
		select
			delay 1.0;
			Put_Line("Infinite_Work interupted");
		then abort
			Infinite_Work;
		end select;
	end Start;

begin
	null;
end p9;