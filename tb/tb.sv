import shared_pkg::*;
import slave_transaction_pkg::*;
module tb(slave_if.TEST f_if);
slave_transaction f_txn;

initial begin
    f_txn = new;
    test_finished = 0;

    // reset
    assert_reset;

    repeat (10000) begin
    @(negedge f_if.clk);
    assert(f_txn.randomize());
    drive_signals();
    -> start_sampling;
    end

    test_finished = 1;
end

task assert_reset;
    f_if.rst_n = 0;
    repeat(3) @(negedge f_if.clk);
    f_if.rst_n = 1;
endtask

task drive_signals();
    f_if.MOSI     = f_txn.MOSI;
    f_if.rst_n    = f_txn.rst_n;
    f_if.SS_n     = f_txn.SS_n;
    f_if.tx_valid = f_txn.tx_valid;
    f_if.tx_data  = f_txn.tx_data;
endtask

endmodule
