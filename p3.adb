with Ada.Text_IO; use Ada.Text_IO;
procedure P3 is

	type Integer_Array is array (0 .. 9) of Integer;
	oneSeven : Integer_Array := (0,0,0,0,0,0,0,0,0,0);
	--oneSeven : array (0 .. 100) of Integer;
	pragma Volatile(oneSeven);

	procedure Writers is
		task ones;
		task body ones is
		begin
			for i in oneSeven'Range loop
				oneSeven(i) := 1;
			end loop;
		end ones;

		task sevens;
		task body sevens is
		begin
			for i in oneSeven'Range loop
				oneSeven(i) := 7;
			end loop;
		end sevens;

	begin
		null;
	end;

begin
	Writers;
	for i in oneSeven'Range loop
		Put(Integer'Image(oneSeven(i)) & " ");
	end loop;
end P3;

