// Black-box stub for prim_ram_2p
// Prevents ELAB-366 multi-driver error from dual-port memory
module prim_ram_2p #(
  parameter int unsigned Width         = 32,
  parameter int unsigned Depth         = 128,
  parameter int unsigned DataBitsPerMask = 1,
  parameter              MemInitFile   = ""
)(
  input  logic             clk_a_i,
  input  logic             clk_b_i,
  input  logic             cfg_i,           // prim_ram_2p_pkg::ram_2p_cfg_t — treated as logic
  input  logic             a_req_i,
  input  logic             a_write_i,
  input  logic [$clog2(Depth)-1:0] a_addr_i,
  input  logic [Width-1:0] a_wdata_i,
  //input  logic [Width/DataBitsPerMask-1:0] a_wmask_i,
  input  logic [Width-1:0] a_wmask_i,
  output logic [Width-1:0] a_rdata_o,
  input  logic             b_req_i,
  input  logic             b_write_i,
  input  logic [$clog2(Depth)-1:0] b_addr_i,
  input  logic [Width-1:0] b_wdata_i,
  //input  logic [Width/DataBitsPerMask-1:0] b_wmask_i,
  input  logic [Width-1:0] b_wmask_i,
  output logic [Width-1:0] b_rdata_o
);
  // intentionally empty — black box
endmodule