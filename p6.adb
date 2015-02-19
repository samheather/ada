with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure p6 is
	
	-- Delay timing and randomness
	subtype Delay_Time is Integer range 1..10;
	package Random_Integer is new Ada.Numerics.Discrete_Random(Delay_Time);
	
	-- Client ID's and Individual Barriers
	type Client_ID is new Integer range 1 .. 5;
	type Bools is array (Client_ID) of Boolean;

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
		Gen : Random_Integer.Generator;
		Random_Int : Integer;
	begin
		Random_Integer.Reset(Gen, Integer(ID));
		Random_Int := Random_Integer.Random(Gen);
		delay Randon_Int * 1.0;
		Put_Line("Task " & Integer'Image(ID) & " at barrier");
		select
			Controller.Barrier_Wait(ID);
			Put_Line("Task " & Integer'Image(ID) & " Released");
		or delay 10.0;
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
end p6;

