with Ada.Text_IO; use Ada.Text_IO;
procedure P4 is

	type Integer_Array is array (0 .. 9) of Integer;
	oneSeven : Integer_Array := (0,0,0,0,0,0,0,0,0,0);
	pragma Volatile(oneSeven);

	protected Protected_Integer_Array is
		entry One (index : in Integer);
		entry Seven (index : in Integer);
	private
		countSoFar : Integer := 0;
		lastWritten : Integer := 7;
	end Protected_Integer_Array;

	protected body Protected_Integer_Array is
		entry One (index : in Integer) when lastWritten = 7 is
		begin
			oneSeven (index) := 1;
		end One;
		entry Seven (index : in Integer) when lastWritten = 1 is
		begin
			oneSeven (index) := 7;
		end Seven;
	end Protected_Integer_Array;

	procedure Writers is
		task ones;
		task body ones is
		begin
		for i in oneSeven'Range loop
			Protected_Integer_Array.One(i);
		end loop;
		end ones;

		task sevens;
		task body sevens is
		begin
		for i in oneSeven'Range loop
			Protected_Integer_Array.Seven(i);
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

