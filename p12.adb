pragma Task_Dispatching_Policy(FIFO_Within_Priorities);
with System; use System;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;
procedure p12 is

	procedure Finite_Work(Cycles : Integer) is
	  F : Duration := 0.0;
	  I : Integer := 0;
	begin
		Put_Line("Working");
		loop
		  I := I + 1;
		  for J in 1 .. 10000000 loop
			F := F + Duration(J * 10.0);
		  end loop;
		  Put_Line("Still Working");
		  exit when I = Cycles;
		end loop;
	end Finite_Work;
	
	task Start;
	
	task body Start is
		StartTime : CPU_Time;
		EndTime : CPU_Time;
		Difference : Time_Span;
	begin
		StartTime := Ada.Execution_Time.Clock;
		Finite_Work(20);
		EndTime := Ada.Execution_Time.Clock;
		Difference := EndTime - StartTime;
		Put_Line("Time taken is: " & Duration'Image (To_Duration (Difference)) & " s");
	end Start;

begin
	null;
end p12;