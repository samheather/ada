pragma Task_Dispatching_Policy(FIFO_Within_Priorities);
with Ada.Text_IO; use Ada.Text_IO;
with System; use System;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Real_Time.Timing_Events; use Ada.Real_Time.Timing_Events;
procedure p7 is
	
	TE : aliased Timing_Event;
	Period : constant Time_Span := Milliseconds(100);

	Start_Time : Time := Clock + Milliseconds(100);

	protected Releaser is
		entry Wait_Next_Release;
		procedure Release(Event : in out Timing_Event);
	private
		Go : Boolean := False;
		Next_Time : Time := Start_Time;
	end Releaser;
	
	protected body Releaser is
		entry Wait_Next_Release when Go is
			Go := False;
		end Wait_Next_Release;
		
		procedure Release(Event : in out Timing_Event) is
			Go := True;
			Next_Time := Next_Time + Period;
			Event.Set_Handler(Next_Time, Release'Access); ---- What is this access parameter?

	task Periodic is
		pragma Priority(System.Priority'First + 5);
	end Periodic;

	task body Periodic is
		Period : constant Time_Span := Milliseconds(100);
		Next_Time : Time;
	begin
		delay until Start_Time;
		for I in Integer range 1 .. 10 loop
			Next_Time := Clock + Period;
			Put_Line("High priority task running");
			delay until Next_Time;
			Next_Time := Next_Time + Period;
		end loop;
	end Periodic;

	task Worker is
		pragma Priority(System.Priority'First);
	end Worker;

	task body Worker is
		I : Integer := 0;
		F : Duration := 0.0;
	begin
		delay until Start_Time;
		loop
			Put_Line("Low executing");
			for J in 1 .. 10000000 loop
				F := F + Duration(J * 10.0);
			end loop;
			I := I + 1;
			exit when I = 40;
		end loop;
		Put_Line("Low terminating");
	end Worker;

begin
	null;
end p7;

