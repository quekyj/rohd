module ShiftRegister(
  input wire clk,
  input wire reset,
  input wire shift_in,
  output wire [7:0] shift_out
);

reg [7:0] register;

always @(posedge clk or posedge reset) begin
  if (reset)
    register <= 8'b0;
    else begin
      register <= {register[6:0], shift_in};
    end
end

assign shift_out = register;

endmodule