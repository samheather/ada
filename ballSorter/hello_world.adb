with MaRTE_OS;
with Text_IO;
with Chute; use Chute;
with Ada.Calendar; use Ada.Calendar;


procedure Hello_World is
	Sensed : Chute.Ball_Sensed;
	DetectedTime : Time;

	task Release_Balls;
	task body Release_Balls is
	begin
		loop
			Text_IO.Put ("L");
			Hopper_Load;
			delay 0.5;
			Hopper_Unload;
			delay 0.5;
			Text_IO.Put ("U");
		end loop;
	end Release_Balls;

	task Get_Next;
	task body Get_Next is
		b_type : Ball_Sensed;
		b_time : Time;
	begin
		loop
			Text_IO.Put ("G");
			Get_Next_Sensed_Ball(b_type, b_time);
		end loop;
	end Get_Next;

begin

	Text_IO.New_Line;
	Text_IO.Put ("Hello, This is a Ada program running on MaRTE OS.");
	Text_IO.New_Line (2);

	--Chute.Get_Next_Sensed_Ball(Sensed, DetectedTime);
	null;
	
    
end Hello_World;
