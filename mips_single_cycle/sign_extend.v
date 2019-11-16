module sign_extend(dataOut,dataIn);
    output [31:0] dataOut;
    input [15:0] dataIn;
    assign dataOut = $signed(dataIn);
endmodule