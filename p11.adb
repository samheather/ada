pragma Task_Dispatching_Policy(FIFO_Within_Priorities);
with System; use System;
with Ada.Text_IO; use Ada.Text_IO;
procedure p11 is

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
	begin
		select
			Interrupt_Controller.Wait_For_Interrupt;
			Put_Line("Infinite_Work interupted");
		then abort
			Infinite_Work;
		end select;
	end Start;

begin
	null;
end p11;