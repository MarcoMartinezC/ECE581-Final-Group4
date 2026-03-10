##################################################
# Top Level Synthesis Script 
# Sets up top-design name and sources scripts files
# Author: Venkatesh Patil (v.p@pdx.edu)
# ################################################
puts "=== DC TOP START ==="

set top_design "ibex_demo_system"
set script_dir [file dirname [info script]]

# 1. Run the one-time setup and analysis
source -echo -verbose $script_dir/dc_setup.tcl
source -echo -verbose $script_dir/dc_libraries.tcl
source -echo -verbose $script_dir/dc_analyze.tcl

# 2. Define your target frequencies (in MHz)
#set FREQS {500 750 1000 1250}
set FREQS {500}

# 3. The Synthesis Sweep Loop
foreach f $FREQS {
    puts "=========================================="
    puts "   RUNNING SYNTHESIS FOR ${f} MHz"
    puts "=========================================="

    # Calculate period in ns
    set period [expr 1000.0 / $f]

    # Apply baseline constraints
    source -echo -verbose $script_dir/dc_constraints.tcl

    # Override the clock for this specific loop iteration
    create_clock -name sys_clk -period $period [get_ports clk_sys_i]

    # Load UPF for Low Power BEFORE compiling
    #load_upf ../power/ibex_power.upf

    # Black box prim_ram_2p — stub has no internal logic
    # set_dont_touch [get_designs prim_ram_2p*]

    # Compile the design
    source -echo -verbose $script_dir/dc_compile.tcl

    # Generate Reports with the frequency in the filename
    set stage "dc_${f}MHz"

    report_qor                    > ../reports/${top_design}.${stage}.qor.rpt
    report_power                  > ../reports/${top_design}.${stage}.power.rpt
    report_area -hierarchy        > ../reports/${top_design}.${stage}.area.rpt

    # Multi-VT Usage Analyzer requirement
    report_threshold_voltage_group > ../reports/${top_design}.${stage}.vt_usage.rpt

    # DFT Analysis requirement
    dft_drc                       > ../reports/${top_design}.${stage}.dft_check.rpt
}

# 4. Save final outputs (Netlist, DDC, UPF)
source -echo -verbose $script_dir/dc_outputs.tcl

puts "=== DC TOP END ==="
