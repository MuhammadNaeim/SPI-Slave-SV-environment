module top;
    bit clk;
    initial forever #1 clk = !clk;

    // instace
    slave_if f_if (clk);
    SLAVE    DUT  (f_if.MOSI,f_if.MISO,f_if.SS_n,clk,f_if.rst_n,f_if.rx_data,f_if.rx_valid,f_if.tx_data,f_if.tx_valid);
    tb      TB   (f_if);
    monitor MON  (f_if);



miso_a    : assert property (miso_p);
rx_valid_a: assert property(rx_valid_p);
rx_data_a : assert property(rx_data_p);

property miso_p;
    @(posedge clk) !f_if.rst_n |=> f_if.MISO == 0
endproperty
property rx_valid_p;
    @(posedge clk) !f_if.rst_n |=> f_if.rx_valid == 0
endproperty
property rx_data_p;
    @(posedge clk) !f_if.rst_n |=> f_if.rx_data == 0
endproperty
endmodule
