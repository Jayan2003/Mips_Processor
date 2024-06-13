library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;


--library UNISIM;
--use UNISIM.VComponents.all;

entity Alu is
    Port ( a1 : in  STD_LOGIC_VECTOR (31 downto 0);
           a2 : in  STD_LOGIC_VECTOR (31 downto 0);
           alu_control : in  STD_LOGIC_VECTOR (3 downto 0);
           alu_result : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC);
end Alu;

architecture Behavioral of Alu is
signal resultx: std_logic_vector(31 downto 0);
begin
process(a1,a2,alu_control)
begin
case alu_control is
when "0000"=> --and operation
resultx<= a1 and a2;
when "0001"=> --or operation
resultx<= a1 or a2;
when "0010"=> --add operation
resultx<= std_logic_vector(unsigned(a1) + unsigned(a2));
when "0110"=> --sub operation
resultx<= std_logic_vector(unsigned(a1) - unsigned(a2));
when "0111"=> --set on less than operation
if(a1<a2) then
resultx<=x"00000001";
else
resultx<=x"00000000";
end if;
when "1100"=>--nor operation 
resultx<=a1 nor a2;
when others=>null; 
resultx<=x"00000000";
end case;
end process;
alu_result<=resultx;
Zero<='1' when resultx<=x"00000000" else
		'0';
end Behavioral;

