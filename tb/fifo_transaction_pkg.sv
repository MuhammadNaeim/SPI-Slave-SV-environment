package slave_transaction_pkg;
import shared_pkg::*;
class slave_transaction;
    rand bit       rst_n, SS_n, MOSI, tx_valid;
    rand bit [7:0] tx_data;
         bit [9:0] rx_data;
         bit       rx_valid, MISO;

         bit [9:0] rx_data_ref_sig;
         bit       rx_valid_ref_sig;
         bit       MISO_ref_sig;

    rand bit [10:0] mosi_arr;
         bit [10:0] mosi_bus;
         bit [ 4:0] cycles;
         bit [ 4:0] mosi_ptr;
    ////////////////// constraints //////////////////
    constraint reset_c {rst_n dist{0:=1, 1:=99};}
    constraint tx_valid_c {
        if (mosi_bus[10:8] == 3'b111)
            tx_valid == 1;
        else
            tx_valid == 0;
    }
    constraint mosi_bits_c {
        (SS_n) -> (mosi_arr[10:8] inside {3'b000, 3'b001, 3'b110, 3'b111});
    }
    constraint ss_n_c {
        if (cycles == 0)
            SS_n == 1;
        else
            SS_n == 0;
    }
    function void post_randomize();
        if (SS_n) mosi_bus = mosi_arr;
        MOSI = mosi_bus[mosi_ptr];
        if (SS_n == 0) begin
            cycles--;
        end
        else begin
            if (mosi_bus[10:8] == 3'b111)
                cycles = 23;
            else
                cycles = 13;
        end
        if (mosi_ptr > 0) begin
            mosi_ptr--;
        end
        else begin
            mosi_ptr = 5'd11;
        end
    endfunction
endclass
endpackage
