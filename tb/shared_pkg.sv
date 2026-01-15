package shared_pkg;
    typedef enum bit [2:0] { IDLE,WRITE,CHK_CMD,READ_ADD,READ_DATA } state_e;
    bit test_finished;
    int error_count, correct_count;
    event start_sampling;
endpackage
