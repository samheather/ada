pragma Task_Dispatching_Policy(FIFO_Within_Priorities);
with System; use System;
with Ada.Text_IO; use Ada.Text_IO;
procedure p10 is

	protected Interrupt_Controller is
		entry Wait_For_Interrupt;
		procedure Raise_Interrupt;
	private
		Go : Boolean := False;
	end Interrupt_Controller;
	
	protected body Interrupt_Controller is
		entry Wait_For_Interrupt when Go is
		begin
			Go := False;
		end Wait_For_Interrupt;
		
		procedure Raise_Interrupt is
		begin
			Go := True;
		end Raise_Interrupt;
	end Interrupt_Controller;
		

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
			Interrupt_Controller.Wait_For_Interrupt;
			Put_Line("Infinite_Work interupted");
		then abort
			Infinite_Work;
		end select;
	end Start;
	
	task Boss;
	task body Boss is
	begin
		delay 1.0;
		Interrupt_Controller.Raise_Interrupt;
	end Boss;	

begin
	null;
end p10;