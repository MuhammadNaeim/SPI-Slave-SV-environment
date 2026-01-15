package slave_coverage_pkg;
import slave_transaction_pkg::*;
class slave_coverage;
// handel
slave_transaction f_cvg_txn;

///////////////// cover group /////////////////
covergroup cov_gp;
    rx_data_cp : coverpoint f_cvg_txn.rx_data[9:8];
    rx_trans_cp: coverpoint f_cvg_txn.rx_data[9:8] {
        bins t_00_00 = (2'b00 => 2'b00);
        bins t_00_01 = (2'b00 => 2'b01);
        bins t_00_10 = (2'b00 => 2'b10);
        bins t_01_00 = (2'b01 => 2'b00);
        bins t_01_01 = (2'b01 => 2'b01);
        bins t_01_11 = (2'b01 => 2'b11);
        bins t_10_00 = (2'b10 => 2'b00);
        bins t_10_10 = (2'b10 => 2'b10);
        bins t_10_11 = (2'b10 => 2'b11);
        bins t_11_00 = (2'b11 => 2'b00);
        bins t_11_01 = (2'b11 => 2'b01);
        bins t_11_10 = (2'b11 => 2'b10);
        bins t_11_11 = (2'b11 => 2'b11);
        }
    ss_n_cp : coverpoint f_cvg_txn.SS_n {
        bins normal_tr   = (1 => 0[*13] => 1);
        bins extended_tr = (1 => 0[*23] => 1);
    }
    mosi_cp : coverpoint f_cvg_txn.MOSI {
        bins write_addr = (0 => 0 => 0);
        bins write_data = (0 => 0 => 1);
        bins read_addr  = (1 => 1 => 0);
        bins read_data  = (1 => 1 => 1);
    }
    patterns_by_protocol : cross ss_n_cp, mosi_cp {
        ignore_bins wr_addr = binsof(ss_n_cp.extended_tr) && binsof(mosi_cp.write_addr);
        ignore_bins wr_data = binsof(ss_n_cp.extended_tr) && binsof(mosi_cp.write_data);
        ignore_bins rd_addr = binsof(ss_n_cp.extended_tr) && binsof(mosi_cp.read_addr);
    }

endgroup

// sample data function
function void sample_data(slave_transaction f_txn);
    f_cvg_txn = f_txn;
    cov_gp.sample;
endfunction

// constructor function
function new();
    cov_gp = new;
endfunction
endclass
endpackage
