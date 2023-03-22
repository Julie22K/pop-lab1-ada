with Ada.Calendar; use Ada.Calendar;
 with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers; use Ada.Containers;
with Ada.Containers.Generic_Array_Sort;

procedure main is
   --Number_Threads:Integer:=4;
   type arr_d is array (Natural range <>) of Duration;
   timers : arr_d := (4.0, 7.0, 2.0, 8.0);

   --sort
procedure Sort is new Ada.Containers.Generic_Array_Sort
    (Index_Type  => Natural,
    Element_Type => Duration,
    Array_Type   => arr_d);

   A:Duration;

   task type break_thread;
   task type main_thread(id: Integer);

   task body break_thread is
   begin
      for t in timers'Range loop
         A:=timers(t);
         delay A;
         timers(t):=0.0;
      end loop;


   end break_thread;

   task body main_thread is
      step : Long_Long_Integer := 2;
      number : Long_Long_Integer := 0;
      numeric : Long_Long_Integer := 0;
      sum : Long_Long_Integer := 0;
      can_stop:Boolean:=false;

      b:Duration:=timers(id);
   begin
      loop
         number := number + step;
         numeric := numeric + 1;
         sum := sum + number;

         if  timers(id) = 0.0  then
            can_stop := true;
         end if;

         exit when can_stop;
      end loop;

      delay 1.0;
      Ada.Text_IO.Put_Line("Id:"&id'Img&"  Sum:"&sum'Img&"  Numeric:"&numeric'Img);

   for t in timers'Range loop

         timers(t):=timers(t)-b;
      end loop;
   end main_thread;

   b1 : break_thread;

   t1 : main_thread(0);
   t2 : main_thread(1);
   t3 : main_thread(2);
   t4 : main_thread(3);
begin
   Sort(timers);
end main;
