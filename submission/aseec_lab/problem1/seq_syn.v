module seq_detector_0011(
  input logic clk,
  input logic reset,
  input logic data_in,
  output reg detected
);

  reg [1:0] state = 2'd00;
  reg [1:0] prev_state = 2'd00;
  logic seq_found = 0;

  always @(posedge clk) begin
    if (reset) begin
      seq_found <= 0;
      state <= 2'd00;
      prev_state <= 2'd00;
    end
    else begin
      case (prev_state)
        2'd00: begin
          if (data_in) begin
            state <= 2'd01;
          end
        end
        2'd01: begin
          if (data_in) begin
            if (data_in) begin
              if (data_in) begin
                state <= 2'd11;
              end
              else begin
                seq_found <= 1;
                state <= 2'd00;
                prev_state <= 2'd00;
              end
            end
          end
        end
        2'd11: begin
          if (data_in) begin
            seq_found <= 1;
            state <= 2'd00;
            prev_state <= 2'd00;
          end
          else begin
            seq_found <= 0;
            state <= 2'd00;
            prev_state <= 2'd00;
          end
        end
        default: begin
          seq_found <= 0;
          state <= 2'd00;
          prev_state <= 2'd00;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    detected <= seq_found;
  end

endmodule

