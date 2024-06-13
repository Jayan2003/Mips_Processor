library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit is
    Port (clk: in STD_LOGIC;
        opcode : in STD_LOGIC_VECTOR(5 downto 0);
        reg_dst, jump, branch, mem_read, mem_to_reg, reg_write, mem_write, alu_src : out STD_LOGIC;
        alu_op : out STD_LOGIC_VECTOR(1 downto 0)
    );
end ControlUnit;

architecture Behavioral of ControlUnit is
constant OP_MOV : std_logic_vector(5 downto 0) := "000001";
constant OP_INP : std_logic_vector(5 downto 0) := "000010";
constant OP_OUT : std_logic_vector(5 downto 0) := "000011";
constant OP_MUL : std_logic_vector(5 downto 0) := "000100";
constant OP_BUN : std_logic_vector(5 downto 0) := "000101";
constant OP_SKP : std_logic_vector(5 downto 0) := "000110";
signal add: std_logic_vector(9 downto 0) := "0000000001";
signal data_in : STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
signal data_out : STD_LOGIC_VECTOR (31 downto 0):=x"00000000";
signal memory_read: STD_LOGIC:='1';
signal memory_write: STD_LOGIC:='0';
begin
DRM: entity work.DataMemory(Behavioral)
		port map(
			address=>add,
			data_in=>data_in,
			data_out=>data_out,
			memory_read=>memory_read,
			memory_write=>memory_write,
			clk=>clk
		);
    process(opcode)
    begin
        case opcode is
				when OP_MOV =>
                reg_dst <= '1';
                jump <= '0';
                branch <= '0';
                mem_read <= '0';
                mem_to_reg <= '0';
                alu_op <= "00"; -- No ALU operation needed for MOV
                mem_write <= '0';
                alu_src <= '0';
                reg_write <= '1' after 10 ns; -- Assuming delayed write
				when OP_INP =>
                reg_dst <= '1'; -- Input data will be written to a register
                jump <= '0';
                branch <= '0';
                mem_read <= '0';
                mem_to_reg <= '0';
                alu_op <= "00"; -- No ALU operation needed for INP
                mem_write <= '0';
                alu_src <= '0';
                reg_write <= '1' after 10 ns; -- Assuming delayed write
            when OP_OUT =>
                reg_dst <= '0';
                jump <= '0';
                branch <= '0';
                mem_read <= '0';
                mem_to_reg <= '0';
                alu_op <= "00"; -- No ALU operation needed for OUT
                mem_write <= '0';
                alu_src <= '0';
                reg_write <= '0';
                -- You may need additional signals or interfaces to handle output
            when OP_MUL =>
                reg_dst <= '1'; -- Result of multiplication will be written to a register
                jump <= '0';
                branch <= '0';
                mem_read <= '0';
                mem_to_reg <= '0';
                alu_op <= "01"; -- ALU operation for multiplication
                mem_write <= '0';
                alu_src <= '1'; -- Second ALU operand comes from memory
                reg_write <= '1' after 10 ns; -- Assuming delayed write
            when OP_BUN =>
                reg_dst <= 'X';
                jump <= '1'; -- Jump to the address specified by the effective address
                branch <= '0';
                mem_read <= '0';
                mem_to_reg <= 'X';
                alu_op <= "00"; -- No ALU operation needed for BUN
                mem_write <= '0';
                alu_src <= '0';
                reg_write <= '0';
            when OP_SKP =>
					 if data_out>x"00000000" then
                reg_dst <= 'X';
                jump <= '0';
                branch <= '0';
                mem_read <= '0';
                mem_to_reg <= 'X';
                alu_op <= "00"; -- No ALU operation needed for SKP
                mem_write <= '0';
                alu_src <= '0';
                reg_write <= '0';
                else
                    reg_dst <= '0';
                    jump <= '0';
                    branch <= '0';
                    mem_read <= '0';
                    mem_to_reg <= '0';
                    alu_op <= "00"; -- Define the appropriate ALU operation
                    mem_write <= '0';
                    alu_src <= '0';
                    reg_write <= '0';
                end if; 
				when "000000" => --and,add,sub,etc
					reg_dst<='1';
					jump<='0';
					branch<='0';
					mem_read<='0';
					mem_to_reg<='0';
					alu_op<="10";
					mem_write<='0';
					alu_src<='0';
					reg_write<='1' after 10 ns;
				when "100011" => --lw
					reg_dst<='0';
					jump<='0';
					branch<='0';
					mem_read<='1';
					mem_to_reg<='1';
					alu_op<="00";
					mem_write<='0';
					alu_src<='1';
					reg_write<='1' after 10 ns;
				when "101011" => --sw
					reg_dst<='X';
					jump<='0';
					branch<='0';
					mem_read<='0';
					mem_to_reg<='X';
					alu_op<="00";
					mem_write<='1';
					alu_src<='1';
					reg_write<='0';
				when "010000" => --branch
					reg_dst<='X';
					jump<='0';
					branch<='1' after 2 ns;
					mem_read<='0';
					mem_to_reg<='X';
					alu_op<="01";
					mem_write<='0';
					alu_src<='0';
					reg_write<='0';
				when "001000" => --jump
					reg_dst<='X';
					jump<='1';
					branch<='0';
					mem_read<='0';
					mem_to_reg<='X';
					alu_op<="00";
					mem_write<='0';
					alu_src<='0';
					reg_write<='0';
				when others=>null;
				reg_dst<='0';
					jump<='0';
					branch<='0';
					mem_read<='0';
					mem_to_reg<='0';
					alu_op<="00";
					mem_write<='0';
					alu_src<='0';
					reg_write<='0';
				end case;
    end process;
end Behavioral;

