with Ada.Text_IO;use Ada.Text_IO;
procedure Prac_2 is
   task Numbers;
   task body Numbers is
   begin
      for i in 1 ..100 loop
         Put_line(Integer'Image(i));
      end loop;
   end Numbers;


   task Hello;
   task body Hello is
   begin
      for i in Character'('a') .. Character'('z') loop
         Put_Line(Character'Image(i));
      end loop;
   end Hello;

begin
   null;
end Prac_2;
