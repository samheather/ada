with Ada.Text_IO; use Ada.Text_IO;
procedure p5_second is

	Releaser : Integer := 3;
	
	protected Controller is
		entry Barrier_Wait(Client : Integer);
	private
		entry Barrier_Release(Client : Integer);
		Barrier_Up : Boolean := True;
	end Controller;
	
	protected body Controller is
		entry Barrier_Wait(Client : Integer) when True is
		begin
			if Client = Releaser then
				Barrier_Up := False;
			else
				requeue Barrier_Release with abort;
			end if;
		end Barrier_Wait;
		
		entry Barrier_Release(Client : Integer) when Barrier_Up = False is
		begin
			if Barrier_Release'Count = 0 then
				Barrier_Up := True;
			end if;
		end Barrier_Release;
	end Controller;
		
	task type Client(ID : Integer);
	task body Client is
	begin
		Put_Line("Task " & Integer'Image(ID) & " at barrier");
		select
			Controller.Barrier_Wait(ID);
			Put_Line("Task " & Integer'Image(ID) & " Released");
		or delay 3.0;
			Put_Line("Task " & Integer'Image(ID) & " not released");
		end select;
	end;
		
	C1 : Client(1);
	C2 : Client(2);
	C3 : Client(3);
	C4 : Client(4);
	C5 : Client(5);

begin
	null;
end p5_second;

