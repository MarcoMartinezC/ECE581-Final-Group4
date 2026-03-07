# ==========================================================================
# SDC Constraints for Ibex Demo System
# Location: constraints/ibex_demo_system.sdc
# ==========================================================================

# 1. Default Clock Definition
# (The TCL sweep script will dynamically override this 2.0ns period during the loop)
create_clock -name sys_clk -period 2.0 [get_ports clk_sys_i]

# 2. Input and Output Delays
# Reserving a percentage of the clock cycle for external peripheral routing
set_input_delay  0.4 -clock sys_clk [remove_from_collection [all_inputs] [get_ports clk_sys_i]]
set_output_delay 0.4 -clock sys_clk [all_outputs]

# 3. Environmental Constraints
# Define the physical electrical load on the output pins
set_load 0.05 [all_outputs]

# Limit how many gates a single input pin can drive 
set_max_fanout 20 [all_inputs]

# Define maximum transition time (slew rate) 
set_max_transition 0.2 [current_design]