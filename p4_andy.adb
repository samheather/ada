with Ada.Text_IO; use Ada.Text_IO;
procedure Prac_4 is

   Global_Array : array (1 .. 100) of Integer;
   pragma Volatile(Global_Array);

   protected Turn is
      entry Wait_Ones_Turn(Index : Integer);
      entry Wait_Sevens_Turn(Index : Integer);
   private
      Last : Integer := 1;
      Count : Integer := -1;
   end Turn;

   protected body Turn is
      entry Wait_Ones_Turn(Index : Integer) when Last = 7 is
      begin
         if Count = 1 then
            Last := 1;
            Count := 0;
         else
            Count := Count + 1;
         end if;
         Global_Array (Index) := 1;

      end Wait_Ones_Turn;

      entry Wait_Sevens_Turn(Index : Integer) when Last = 1 is
      begin
         If Count = -1 or Count = 1 then
            Last := 7;
            Count := 0;
         else
            Count := Count + 1;
         end if;
         Global_Array (Index) := 7;

      end Wait_Sevens_Turn;
   end Turn;



   procedure Go is
      procedure Slow_Down is -- use this if you want to check your solution for tasks
                             -- running at different speeds
      begin
         for i in 1 .. 10000 loop
            null;
         end loop;
      end Slow_Down;


      task One;
      task body One is
      begin
         Put_Line("One running");
         for i in Global_Array'Range loop
            Turn.Wait_Ones_Turn(i);
         end loop;
      end One;

      task Seven;
      task body Seven is
      begin
         Put_Line("Seven running");
         for i in Global_Array'Range loop
            Turn.Wait_Sevens_Turn(i);
         end loop;
      end Seven;
   begin
      null;
   end Go;

begin

   for i in Global_Array'Range loop
      Global_Array (i) := 0;
   end loop;

   Go;

   for i in Global_Array'Range loop
     Put_line(Integer'Image(Global_Array(i)));
   end loop;

end Prac_4;
