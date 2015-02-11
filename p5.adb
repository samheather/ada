with Ada.Text_IO; use Ada.Text_IO;
procedure P5 is

	Releaser : Integer := 3;

	protected Controller is
		entry Barrier_Wait(Client : Integer);
	private
		entry Barrier_Release(Client : Integer);
		barrierUp : Boolean := True;
		numberWaiting : Integer := 0;
	end Controller;
	
	protected body Controller is
		entry Barrier_Wait(Client : Integer) when True is
			begin
			if Client = Releaser then
				barrierUp := False;
			else
				requeue Barrier_Release;
				numberWaiting := numberWaiting + 1;
			end if;
		end Barrier_Wait;
			
		entry Barrier_Release(Client : Integer) when barrierUp = False is
			begin
			numberWaiting := numberWaiting - 1;
			if numberWaiting = 0 then
				barrierUp := True;
			end if;
		end Barrier_Release;
	end Controller;


	task type Client(Id : Integer);
	task body Client is
	begin
		Put_Line("Client " & Integer'Image(Id) & " Waiting at Barrier");
		select
			Controller.Barrier_Wait(Id);
			Put_Line("Client " & Integer'Image(Id) & " Released");
		or delay 3.0;
			Put_Line("Client " & Integer'Image(Id) & " Missed Release");
		end select;
	end Client;
	
	C1: Client(1);
	C2: Client(2);
	C3: Client(3);
	C4: Client(4);

begin
	null;
end P5;

