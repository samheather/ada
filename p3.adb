with Ada.Text_IO; use Ada.Text_IO;
procedure P3 is

	type Integer_Array is array (0 .. 9) of Integer;
	oneSeven : Integer_Array := (0,0,0,0,0,0,0,0,0,0);
	--oneSeven : array (0 .. 100) of Integer;
	pragma Volatile(oneSeven);

  procedure Slow_Down is
  begin
     for i in 1 .. 10000 loop
        null;
     end loop;
  end Slow_Down;

	procedure Writers is
		task ones;
		task body ones is
		begin
			for i in oneSeven'Range loop
				if oneSeven (i) = 7 then
               oneSeven (i) := 1;
            else
               oneSeven (i) := 1;
               Slow_Down;
            end if;
			end loop;
		end ones;

		task sevens;
		task body sevens is
		begin
			for i in oneSeven'Range loop
				if oneSeven (i) = 1 then
               oneSeven (i) := 7;
            else
               oneSeven (i) := 7;
               Slow_Down;
            end if;
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

