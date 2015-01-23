with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
procedure P2 is
	task numbers;
	task body numbers is
		X : Integer := 100;
	begin
		for I in 0..X loop
			Ada.Integer_Text_IO.Put(I);
		end loop;
	end numbers;

	task letters;
	task body letters is
	begin
		for I in Character'('a') .. Character'('z') loop
			Put_Line(Character'Image(I));
		end loop;
	end letters;
begin
	null;
end P2;

