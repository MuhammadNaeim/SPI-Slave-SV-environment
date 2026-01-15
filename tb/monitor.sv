import shared_pkg::*;
import slave_transaction_pkg::*;
import slave_coverage_pkg::*;
import slave_scoreboard_pkg::*;
module monitor(slave_if.MON f_if);

// handels
slave_transaction f_txn;
slave_coverage    f_cov;
slave_scoreboard  f_scb;

logic [9:0] rx_data_ref_sig;
logic       rx_valid_ref_sig;
logic       MISO_ref_sig;

initial begin
f_txn = new;
f_cov = new;
f_scb = new;

forever begin
    @start_sampling;
    // inputs
    f_txn.MOSI     = f_if.MOSI;
    f_txn.rst_n    = f_if.rst_n;
    f_txn.SS_n     = f_if.SS_n;
    f_txn.tx_valid = f_if.tx_valid;
    f_txn.tx_data  = f_if.tx_data;
    // outputs
    f_txn.rx_data  = f_if.rx_data;
    f_txn.rx_valid = f_if.rx_valid;
    f_txn.MISO     = f_if.MISO;

    // golden model
    f_txn.rx_data_ref_sig  = rx_data_ref_sig;
    f_txn.rx_valid_ref_sig = rx_valid_ref_sig;
    f_txn.MISO_ref_sig     = MISO_ref_sig;

    fork
        begin
            f_cov.sample_data(f_txn);
        end
        begin
            f_scb.check_data(f_txn);
        end
    join

    if (test_finished) begin
        $display("Correct: %6d, Error: %6d", correct_count, error_count);
        $stop;
    end
end
end

// Instantiate golden_model
golden_model golden (
    .SS_n     (f_if.SS_n),
    .MOSI     (f_if.MOSI),
    .clk      (f_if.clk),
    .rst_n    (f_if.rst_n),
    .tx_data  (f_if.tx_data),
    .tx_valid (f_if.tx_valid),
    .rx_data  (rx_data_ref_sig),
    .rx_valid (rx_valid_ref_sig),
    .MISO     (MISO_ref_sig)
);
endmodule
