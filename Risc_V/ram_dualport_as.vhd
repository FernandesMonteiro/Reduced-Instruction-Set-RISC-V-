library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;

entity ram_dualport_as is
    generic (
        DATA_WIDTH :integer := 32;
        --ADDR_WIDTH :integer := 32
		  ADDR_WIDTH :integer := 8
    );
    port (
        address_0 :in    std_logic_vector (ADDR_WIDTH-1 downto 0);  -- address_0 Input
        data_0    :in    std_logic_vector (DATA_WIDTH-1 downto 0);  -- data_0 bi-directional inout
        cs_0      :in    std_logic;                                 -- Chip Select
        we_0      :in    std_logic;                                 -- Write Enable/Read Enable
        oe_0      :in    std_logic;                                 -- Output Enable
        switches  :in    std_logic_vector (9 downto 0);
		  keys      :in    std_logic_vector (3 downto 0);
		  LEDS      :out    std_logic_vector (9 downto 0);
		  HEX_raw   :out STD_LOGIC_VECTOR (31 downto 0);
		  --address_1 :in    std_logic_vector (ADDR_WIDTH-1 downto 0);  -- address_1 Input
        data_1    :out std_logic_vector (DATA_WIDTH-1 downto 0);  -- data_1 bi-directional
        --cs_1      :in    std_logic;                                 -- Chip Select
        we_1      :in    std_logic                                 -- Write Enable/Read Enable
        --oe_1      :in    std_logic                                  -- Output Enable
    );
end entity;
architecture rtl of ram_dualport_as is
    ----------------Internal variables----------------

    constant RAM_DEPTH :integer := 2**8;
    
    --signal data_0_out :std_logic_vector (DATA_WIDTH-1 downto 0);
    --signal data_1_out :std_logic_vector (DATA_WIDTH-1 downto 0);

    type RAM is array (integer range <>)of std_logic_vector (DATA_WIDTH-1 downto 0);
    signal mem : RAM (0 to RAM_DEPTH-1);
	 
	 signal OUT_IO: std_logic_vector (DATA_WIDTH-1 downto 0);
	 
begin


	 
    ----------------Code Starts Here------------------
    -- Memory Write Block
    -- Write Operation : When we_0 = 1, cs_0 = 1
	 
    MEM_WRITE:
    process (address_0, cs_0, we_0) begin --,data_1) data_0, address_1 cs_1, we_1
      if (cs_0 = '1' and we_0 = '1') then      --SW
			if (address_0 = x"00000000") then
			OUT_IO <= data_0;
			else
         mem(conv_integer(address_0)) <= data_0;
   --   --elsif  (cs_1 = '1' and we_1 = '1') then
   --   --   mem(conv_integer(address_1)) <= data_1;
			end if;
		else
		OUT_IO <= OUT_IO;
      end if;
    end process;
	 

	 LEDS <= OUT_IO(9 downto 0);
	 HEX_raw <= "0000000000" & OUT_IO(31 downto 10);
    -- Tri-State Buffer control
  --  --data_0 <= data_0_out when (cs_0 = '1' and oe_0 = '1' and we_0 = '0') else (others=>'Z');

  --  -- Memory Read Block
  -- -- MEM_READ_0:
  -- -- process (address_0, cs_0, we_0, oe_0, mem) begin
  --   -- if (cs_0 = '1' and we_0 = '0' and oe_0 = '1') then
  --   --   data_0_out <= mem(conv_integer(address_0));
  --   -- else
  --  --    data_0_out <= (others=>'0');
  --  --  end if;
  --  --end process;

    -- Second Port of RAM
    -- Tri-State Buffer control
    --  --data_1 <= data_1_out when (cs_1 = '1' and oe_1 = '1' and we_1 = '0') else (others=>'Z');

    -- Memory Read Block 1
    MEM_READ_1:
    process (address_0, cs_0, we_1, oe_0, mem, switches, keys) begin  --address_1  cs_1  oe_1
        if (cs_0 = '1' and we_1 = '1' and oe_0 = '1') then
				if (address_0 = x"00000000") then
				data_1 <= "000000000000000000" & keys & switches;
				else
				data_1 <= mem(conv_integer(address_0));
				end if;
        else
            --data_1_out <= (others=>'0');
				data_1 <= x"00000000";
        end if;
    end process;

end architecture;