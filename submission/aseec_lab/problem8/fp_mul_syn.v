module float_multi(a, b, result);
  //Operands
  input [15:0] a, b;
  output [15:0] result;
  //Flags
  //Flags
  output result;//overflow flag
  //decode-encode numbers
  assign {signR, exR, fraR} = a;
  assign ex1 = {4'd0, ~|ex1};
  assign ex2 = {4'd0, ~|ex2};
  assign exR_calc = exSum[4:0] + {4'd0, float_res[11]} + (~exSubCor & {5{subNormal}}) + {4'd0, subNormal};
  assign float_res_fra = (float_res[11]) ? float_res[10:1] : float_res[9:0];
  assign float_res = float_res_preround + {10'd0,dump_res[9]}; 
  assign {float_res_preround, dump_res} = res_full;
  assign res_full_preshift = mid[0] + mid[1] + mid[2] + mid[3] + mid[4] + mid[5] + mid[6] + mid[7] + mid[8] + mid[9] + mid[10];
  assign exSum_fault = exSubCor - exSum_abs[4:0];
  always@*
    begin
      case(ex_full)
        22'b001xxxxxxxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd1;
          end
        22'b0001xxxxxxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd2;
          end
        22'b00001xxxxxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd3;
          end
        22'b000001xxxxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd4;
          end
        22'b0000001xxxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd5;
          end
        22'b00000001xxxxxxxxxxxxxx:
          begin
            exSubCor = 5'd6;
          end
        22'b000000001xxxxxxxxxxxxx:
          begin
            exSubCor = 5'd7;
          end
        22'b0000000001xxxxxxxxxxxx:
          begin
            exSubCor = 5'd8;
          end
        22'b00000000001xxxxxxxxxxx:
          begin
            exSubCor = 5'd9;
          end
        22'b000000000001xxxxxxxxxx:
          begin
            exSubCor = 5'd10;
          end
        22'b0000000000001xxx:
          begin
            exSubCor = 5'd11;
          end
        22'b00000000000001xx:
          begin
            exSubCor = 5'd12;
          end
        22'b000000000000001x:
          begin
            exSubCor = 5'd13;
          end
        22'b0000000000000001:
          begin
            exSubCor = 5'd14;
          end
        default:
          begin
            exSubCor = 5'd0;
          end
      endcase
  end
  
  //Calculate result
  assign exSum = exSum_prebais - 7'd15;
  assign exSum_prebais = {1'b0,ex1} + {1'b0,ex2};
  assign exSum_abs = (exSum_sign) ? (~exSum[5:0] + 6'd1) : exSum[5:0];
  assign exSum_sign = exSum[6];

  //Get floating numbers
  assign float1 = {|ex1_pre, fra1, 10'd0};
  assign float2 = {|ex2_pre, fra2};

  //Partial flags
  assign zero_num_in = ~(|a[14:0] & |b[14:0]);
  assign zero_calculated = (subNormal & (fraSub == 10'd0)) | (exSum_sign & (~|res_full[20:11]));
  assign inf_num = (&a[14:10] & ~|a[9:0]) | (&b[14:10] & ~|b[9:0]);
  assign overflow = inf_num | (~exSum[6] & exSum[5]);
  assign subNormal = ~|float_res[11:10];
  assign precisionLost = |dump_res | (exSum_prebais < 6'd15);
endmodule

