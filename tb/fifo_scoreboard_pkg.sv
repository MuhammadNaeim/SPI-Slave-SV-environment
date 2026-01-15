package slave_scoreboard_pkg;
import shared_pkg::*;
import slave_transaction_pkg::*;
class slave_scoreboard;

// check data
function void check_data(slave_transaction f_txn);
    if (f_txn.rx_data === f_txn.rx_data_ref_sig)
        correct_count++;
    else begin
        error_count++;
        $display("ERROR: data_out = %h, expected: %h",f_txn.rx_data ,f_txn.rx_data_ref_sig);
    end
endfunction
endclass
endpackage
