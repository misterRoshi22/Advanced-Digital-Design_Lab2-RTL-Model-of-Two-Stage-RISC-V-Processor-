module register (Clock, Reset_n, Write_En, IN, OUT);
    parameter n = 8;                       
    input Clock, Reset_n, Write_En;
    input [n-1:0] IN;
    output reg [n-1:0] OUT;

    always @ (posedge Clock) begin
        if (Reset_n == 1)  OUT <= 0;        //Reset is active high
        else if (Write_En) OUT <= IN;       //If Write_En is high then write IN onto register
    end
endmodule // register