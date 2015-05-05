with MaRTE_OS;
with Text_IO;
with Chute; use Chute;
with Ada.Calendar; use Ada.Calendar;


procedure b is
	task Release_Balls is
	begin
		Text_IO.Put ("Beginning to release balls");
		loop
			Hopper_Load;
			delay until Clock + 0.32;
			Hopper_Unload;
		end loop;
	end Release_Balls

	task Second is
	begin
		loop
			Sorter_Metal;
			Sorter_Close;
			Sorter_Glass;
		end loop;
	end Second;
begin

   Text_IO.New_Line;
   Text_IO.Put ("Hello, This is a AdaA program running on MaRTE OS.");
   Text_IO.New_Line (2);
	null;

end b;
