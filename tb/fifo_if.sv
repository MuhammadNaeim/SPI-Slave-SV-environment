import shared_pkg::*;
interface slave_if(clk);
    input clk;
    logic MOSI, rst_n, SS_n, tx_valid;
    logic [7:0] tx_data;
    logic [9:0] rx_data;
    logic       rx_valid, MISO;

    modport TEST (
    output MOSI,SS_n,rst_n,tx_data,tx_valid,
    input  MISO,clk,rx_data,rx_valid
    );
    modport MON (
    input MOSI,MISO,SS_n,clk,rst_n,rx_data,rx_valid,tx_data,tx_valid
    );
endinterface
