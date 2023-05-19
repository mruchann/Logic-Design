`timescale 1ns / 1ps
module lab3_2(
			input[5:0] money,
			input CLK,
			input vm, //0:VM0, 1:VM1
			input [2:0] productID, //000:sandwich, 001:chocolate, 11x: dont care
			input sugar, //0: No sugar, 1: With Sugar
			output reg [5:0] moneyLeft,
			output reg [4:0] itemLeft,
			output reg productUnavailable,//1:show warning, 0:do not show warning
			output reg insufficientFund , //1:full, 0:not full
			output reg notExactFund , //1:full, 0:not full
			output reg invalidProduct, //1: empty, 0:not empty
			output reg sugarUnsuitable, //1: empty, 0:not empty
			output reg productReady	//1:door is open, 0:closed
	);

	reg [4:0] numOfSandwiches;
	reg [4:0] numOfChocolate;
	reg [4:0] numOfWaterVM0;
	reg [4:0] numOfWaterVM1;
	reg [4:0] numOfCoffee;
	reg [4:0] numOfTea;

	initial 
	begin
		numOfSandwiches = 5'b01010;
		numOfChocolate = 5'b01010;
		numOfWaterVM0 = 5'b00101;
		numOfWaterVM1 = 5'b01010;
		numOfCoffee = 5'b01010;
		numOfTea = 5'b01010;
	end

	always @(posedge CLK) begin

		productUnavailable = 1'b0;
		insufficientFund = 1'b0;
		notExactFund = 1'b0;
		invalidProduct = 1'b0;
		sugarUnsuitable = 1'b0;
		productReady = 1'b0;

		// invalidProduct

		if (productID == 3'b101 | productID == 3'b110 | productID == 3'b111) begin
				invalidProduct = 1'b1;
		end

		else begin 
			if (vm == 0 & (productID == 3'b011 | productID == 3'b100)) begin
				invalidProduct = 1'b1;
			end
			else if (vm == 1 & (productID == 3'b000 | productID == 3'b001)) begin
				invalidProduct = 1'b1;
			end
			else begin
					invalidProduct = 1'b0;
			end
		end

		//productUnavailable

		if (invalidProduct == 0) begin

			case (productID)

				3'b000: begin
					if (numOfSandwiches == 5'b00000) begin
						productUnavailable = 1'b1;
					end
					else begin
						productUnavailable = 1'b0;
					end
				end

				3'b001: begin
					if (numOfChocolate == 5'b00000) begin
						productUnavailable = 1'b1;
					end
					else begin
						productUnavailable = 1'b0;
					end
				end

				3'b010: begin
					if (vm == 0) begin
						if (numOfWaterVM0 == 5'b00000) begin
							productUnavailable = 1'b1;
						end
						else begin
							productUnavailable = 1'b0;
						end
					end
					else if (vm == 1) begin
						if (numOfWaterVM1 == 5'b00000) begin
							productUnavailable = 1'b1;
						end
						else begin
							productUnavailable = 1'b0;
						end
					end
				end

				3'b011: begin
					if (numOfCoffee == 5'b00000) begin
						productUnavailable = 1'b1;
					end
					else begin
						productUnavailable = 1'b0;
					end
				end

				3'b100: begin
					if (numOfTea == 5'b00000) begin
						productUnavailable = 1'b1;
					end
					else begin
						productUnavailable = 1'b0;
					end
				end

				default: productUnavailable = 1'b0;

			endcase
		end

		else if (invalidProduct == 1) begin
			productUnavailable = 1'b0;
		end

		// sugarUnsuitable
		
		if (vm == 1 & productID == 3'b010 & sugar == 1'b1) begin
			sugarUnsuitable = 1'b1;
		end
		else begin
			sugarUnsuitable = 1'b0;
		end

		// notExactFund

		if (vm == 0 & productID == 3'b000 & money != 6'b010100) begin 
			notExactFund = 1'b1;
		end
		else if (vm == 0 & productID == 3'b001 & money != 6'b001010) begin 
			notExactFund = 1'b1;
		end
		else if (vm == 0 & productID == 3'b010 & money != 6'b000101) begin 
			notExactFund = 1'b1;
		end
		else begin 
			notExactFund = 1'b0;
		end

		// insufficientFund

		if (vm == 1 & productID == 3'b010 & money < 6'b000101) begin
			insufficientFund = 1'b1;
		end
		else if (vm == 1 & productID == 3'b011 & money < 6'b001100) begin
			insufficientFund = 1'b1;
		end
		else if (vm == 1 & productID == 3'b100 & money < 6'b001000) begin
			insufficientFund = 1'b1;
		end
		else begin
			insufficientFund = 1'b0;
		end		

		//productReady

		case (vm) 

			1'b0:
				productReady = !invalidProduct & !productUnavailable & !notExactFund;

			1'b1: 
				productReady = !invalidProduct & !productUnavailable & !sugarUnsuitable & !insufficientFund;

		endcase

		//itemLeft
		// moneyLeft

		if (productReady == 1'b1) begin

			case (productID)
				3'b000: begin
					numOfSandwiches = numOfSandwiches - 1;
					itemLeft = numOfSandwiches;

					case (vm)
						1'b0: begin
							moneyLeft = 6'b000000;
						end
						1'b1: begin
							moneyLeft = money - 6'b010100;
						end
					endcase

				end
				3'b001: begin
					numOfChocolate = numOfChocolate - 1;
					itemLeft = numOfChocolate;

					case (vm)
						1'b0: begin
							moneyLeft = 6'b000000;
						end
						1'b1: begin
							moneyLeft = money - 6'b001010;
						end
					endcase

				end
				3'b010: begin
					if (vm == 0) begin
						numOfWaterVM0 = numOfWaterVM0 - 1;
						itemLeft = numOfWaterVM0;
					end
					else if (vm == 1) begin
						numOfWaterVM1 = numOfWaterVM1 - 1;
						itemLeft = numOfWaterVM1;
					end

					case (vm)
						1'b0: begin
							moneyLeft = 6'b000000;
						end
						1'b1: begin
							moneyLeft = money - 6'b000101;
						end
					endcase

				end
				3'b011: begin
					numOfCoffee = numOfCoffee - 1;
					itemLeft = numOfCoffee;

					case (vm)
						1'b0: begin
							moneyLeft = 6'b000000;
						end
						1'b1: begin
							moneyLeft = money - 6'b001100;
						end
					endcase

				end
				3'b100: begin
					numOfTea = numOfTea - 1;
					itemLeft = numOfTea;

					case (vm)
						1'b0: begin
							moneyLeft = 6'b000000;
						end
						1'b1: begin
							moneyLeft = money - 6'b001000;
						end
					endcase
				end
			endcase
		end

		else begin
			itemLeft = 5'bxxxxx;
			moneyLeft = money;
		end

		// warning precedence

		if (invalidProduct == 1'b1) begin
			productUnavailable = 1'bx;
			sugarUnsuitable = 1'bx;
			notExactFund = 1'bx;
			insufficientFund = 1'bx;
		end
		else if (productUnavailable == 1'b1) begin
			sugarUnsuitable = 1'bx;
			notExactFund = 1'bx;
			insufficientFund = 1'bx;
		end
		else if (sugarUnsuitable == 1'b1) begin 
			notExactFund = 1'bx;
			insufficientFund = 1'bx;
		end
		else if (notExactFund == 1'b1) begin
			insufficientFund = 1'bx;
		end
		else begin
			// nothing
		end

		case (vm) 

			1'b0: begin // VM0
				sugarUnsuitable = 1'bx;
				insufficientFund = 1'bx;
			end
			1'b1: notExactFund = 1'bx;

		endcase
	end

endmodule



