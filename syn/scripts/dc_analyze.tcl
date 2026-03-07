puts "INFO: Starting Analyze and Elaborate stage for Ibex"

# 1. Compile Packages first
foreach file [glob ${rtl_dir}/*_pkg.sv] {
    analyze -format sverilog $file -define SYNTHESIS
}

# 2. Explicit files: black-box stub and compressed decoder
analyze -format sverilog ${rtl_dir}/prim_ram_2p_bbox.sv -define SYNTHESIS
analyze -format sverilog ${rtl_dir}/ibex_compressed_decoder.sv -define SYNTHESIS

# 3. Compile ibex core files (skip compressed decoder, already done above)
foreach file [glob ${rtl_dir}/ibex_*.sv] {
    set fname [file tail $file]
    if { $fname ne "ibex_compressed_decoder.sv" } {
        catch { analyze -format sverilog $file -define SYNTHESIS }
    }
}

# 4. Compile remaining SoC/peripheral files
foreach file [glob ${rtl_dir}/*.sv] {
    set fname [file tail $file]
    if { $fname ne "prim_ram_2p.sv" && \
         $fname ne "ibex_compressed_decoder.sv" && \
         ![string match "*_pkg.sv" $fname] } {
        catch { analyze -format sverilog $file -define SYNTHESIS }
    }
}

# 5. Elaborate and clean up names
elaborate $top_design
change_names -rules verilog -hierarchy
puts "INFO: Analyze and Elaborate stage completed"