with Ada.Text_IO; use Ada.Text_IO;
procedure P4 is

	protected type Protected_Integer_Array is
		entry One;
		entry Seven;
	private
		

	type Integer_Array is array (0 .. 9) of Integer;
	oneSeven : Integer_Array := (0,0,0,0,0,0,0,0,0,0);
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
end P4;

