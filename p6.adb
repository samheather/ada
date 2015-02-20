with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure p6 is
	
	-- Delay timing and randomness
	subtype Delay_Time is Integer range 1..10;
	package Random_Integer is new Ada.Numerics.Discrete_Random(Delay_Time);
	
	-- Client ID's and Individual Barriers
	type Client_ID is new Integer range 1 .. 5;
	type Bools is array (Client_ID) of Boolean;
	
	protected Controller is
		entry Barrier_Wait(Client : Client_ID);
	private
		entry Barrier_Release(Client_ID'Range) (Client : Client_ID);
		Open_Barrier : Bools := (others => False);
		Arrived : Integer := 0;
	end Controller;
	
	protected body Controller is
		entry Barrier_Wait(Client : Client_ID) when True is
		begin
			Arrived := Arrived + 1;
			if Arrived = Integer (Client_ID'Last) then
				Open_Barrier(Client_ID'First) := True;
			end if;
			requeue Barrier_Release(Client) with abort;
		end Barrier_Wait;
		
		entry Barrier_Release(for I in Client_ID'Range) (Client : Client_ID) when Open_Barrier(I) is
		begin
			if Client /= Client_ID'Last then
				Put_Line("Opening barrier: " & Client_ID'Image(Client_ID'Succ(Client)));
				Open_Barrier (Client_ID'Succ(Client)) := True;
			end if;
		end Barrier_Release;
	end Controller;
		
	task type Client(ID : Client_ID);
	task body Client is
		Gen : Random_Integer.Generator;
		Random_Int : Integer;
	begin
		Random_Integer.Reset(Gen, Integer(ID));
		Random_Int := Random_Integer.Random(Gen);
		delay Random_Int * 1.0;
		Put_Line("Task " & Client_ID'Image(ID) & " at barrier. Had random int: " & Integer'Image(Random_Int));
		select
			Controller.Barrier_Wait(ID);
			Put_Line("Task " & Client_ID'Image(ID) & " Released");
		or delay 10.0;
			Put_Line("Task " & Client_ID'Image(ID) & " not released");
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

