`timescale 1ns / 1ps

//
// NOTE: This is a sample testbench, provided to you as a guidance.
//

module testbench_ram(
    );

	// ROM Variables

	reg [2:0] romAddr;
	wire [7:0] romDataOut;
	reg [7:0] expectedROM [7:0];


	// RAM Variables
	reg mode;
	reg	[2:0] index;
	reg	[7:0] number;
	reg clk;
	wire[7:0] result;
	reg [7:0] expectedRamOutput;

	// Local Variables
	integer i,tmp,memAddrTmp;
	reg [7:0] tmpOutput;
	real TEMP_result;

	// At 5, 15, 25, .. clk will change 0->1
	// At 10, 20, 30, .. clk will change 1->0
   	initial clk = 0;
	always #5 clk = ~clk;

	// instance
	ROM ROM(romAddr, romDataOut);
	EncodedMemory INS(mode, index, number, clk, result);

	initial begin

		//... you may add your tests here

		TEMP_result=0;
		$display("Starting Testbench");

		expectedROM[0] = 8'b00000000;
		expectedROM[1] = 8'b01010101;
		expectedROM[2] = 8'b10101010;
		expectedROM[3] = 8'b00110011;
		expectedROM[4] = 8'b11001100;
		expectedROM[5] = 8'b00001111;
		expectedROM[6] = 8'b11110000;
		expectedROM[7] = 8'b11111111;

		$display("Running ROM tests..");
		for (i=0;i<8;i=i+1)
		begin
			#1; 
			romAddr=i;
			#1;
			if (romDataOut==expectedROM[i]) 
			begin
				TEMP_result = TEMP_result + 2;
				$display("PASSED: ROM Address %.2d:%b ",i,romDataOut);
			end
			else $display("FAILED!: ROM Address %.2d:%b  ",i,romDataOut);		
		end
		$display("ROM tests finished.");
		$display("\n");
		$display("Running RAM tests..");
		$display("Checking Initial Values of RAM...");
				//initial values of ram cells should be 0.
		tmp=0;
		for (memAddrTmp=0;memAddrTmp<8;memAddrTmp=memAddrTmp+1)
		begin
			index = memAddrTmp;
			mode = 1'b1; // read
			#0.5;
			if(result == 0) begin end
			else tmp=1;
		end
		
		if(tmp==0) 
		begin
			TEMP_result=TEMP_result+6;
			$display("PASSED: The initial values of the memory cells are 0.");
		end
		else $display("FAILED: The initial values of the memory cells should be 0." );
		$display(" TEST INITAL VALUES OF RAM FINISHED!");
		$display(" ");
		$display("Writing & READING RAM TESTS BEGINNING...");
		
		#1;
		mode=1'b0;   // write
		index=3'b000;
		number=8'b00000010;
		#7;
		#6;
		mode=1;  // read
		index=3'b000;
		#9;
		#1;
		mode=1'b0;  // write
		index=3'b001;
		number=8'b01000000;
		#9;
		if (result==2) begin $display("Case 1: Passed"); TEMP_result=TEMP_result+6; end
		else begin $display("Case 1: Failed"); $display("Expected RAM[0]: 2");$display("Returned:%d",result); end

		#1;
		mode=1'b1;
		index=3'b001;
		#9;

		#1;
		mode=1'b0;
		index= 3'b010;
		number=8'b10101110;

		#9;
		#1;
		if (result==21) begin $display("Case 2: Passed");TEMP_result=TEMP_result+6; end
		else begin $display("Case 2: Failed"); $display("Expected RAM[1]: 21");$display("Returned:%d",result); end
		#9;

		#1;
		mode=1'b1;
		index=3'b010;
		#9;

		#1;
		mode=1'b0;
		index= 3'b011;
		number=8'b00000001;
		#9;
		if (result==4) begin $display("Case 3: Passed");TEMP_result=TEMP_result+6; 	end
		else begin $display("Case 3: Failed"); $display("Expected RAM[2]: 4");$display("Returned:%d",result); end
		
		#1;
		mode=1'b1;
		index=3'b011;
		#9;

		#1;
		mode=1'b0;
		index= 3'b100;
		number=8'b11111111;
		#9;
		if (result==50) begin $display("Case 4: Passed");TEMP_result = TEMP_result+6; end
		else begin $display("Case 4: Failed"); $display("Expected RAM[3]: 50");$display("Returned:%d",result); end
		
		#1;
		mode=1'b1;
		index=3'b100;
		#9;

		#1;
		mode=1'b0;
		index= 3'b101;
		number=8'b00001100;
		#9;
		if (result==51) begin $display("Case 5: Passed"); TEMP_result=TEMP_result+6; end
		else begin $display("Case 5: Failed"); $display("Expected RAM[4]: 51");$display("Returned:%d",result); end

		#1;
		mode=1'b1;
		index=3'b101;
		#9;

		#1;
		mode=1'b0;
		index= 3'b110;
		number=8'b01000000;
		#9;
		if (result==3) begin  $display("Case 6: Passed"); TEMP_result=TEMP_result+6;	end
		else begin $display("Case 6: Failed"); $display("Expected RAM[5]: 3");$display("Returned:%d",result); end

		#1;
		mode=1'b1;
		index=3'b110;
		#9;

		#1;
		mode=1'b0;
		index= 3'b111;
		number=8'b11111001;
		#9;
		if (result==176) begin $display("Case 7: Passed");TEMP_result=TEMP_result+6; 	end
		else begin $display("Case 7: Failed"); $display("Expected RAM[6]: 176");$display("Returned:%d",result); end

		#1;
		mode = 1'b1;
		index=3'b111;
		#9;

		#1;
		mode=1'b0;
		index= 3'b000;
		number=8'b10101010;
		#9;
		if (result==6) begin	$display("Case 8: Passed");TEMP_result=TEMP_result+6; 	end
		else begin $display("Case 8: Failed"); $display("Expected RAM[7]: 6");$display("Returned:%d",result); end

		#1;
		mode=1'b1;
		index=3'b000;
		#9;

		#1;
		mode=1'b0;
		index= 3'b001;
		number=8'b00000111;
		#9;
		if (result==170) begin $display("Case 9: Passed");TEMP_result=TEMP_result+6; 	end
		else begin $display("Case 9: Failed"); $display("Expected RAM[0]: 170");$display("Returned:%d",result); end
		
		#1;
		mode=1'b1;
		index=3'b001;
		#9;

		#1;
		mode=1'b0;
		index= 3'b010;
		number=8'b00001111;
		#9;
		if (result==78) begin	$display("Case 10: Passed"); TEMP_result=TEMP_result+6; end
		else begin $display("Case 10: Failed"); $display("Expected RAM[1]: 78");$display("Returned:%d",result); end
		
		#1;
		mode=1'b1;
		index=3'b010;
		#9;

		#1;
		mode=1'b0;
		index= 3'b011;
		number=8'b11111111;
		#9;
		if (result==155) begin  $display("Case 11: Passed"); TEMP_result=TEMP_result+6; end
		else begin $display("Case 11: Failed"); $display("Expected RAM[2]: 155");$display("Returned:%d",result); end
		
		#1;
		mode=1'b1;
		index=3'b011;
		#9;

		#1;
		mode=1'b0;
		index= 3'b100;
		number=8'b11111110;
		#9;
		if (result==204)  begin $display("Case 12: Passed"); TEMP_result=TEMP_result+6; end
		else begin $display("Case 12: Failed"); $display("Expected RAM[3]: 204");$display("Returned:%d",result); end
		
		#1;
		mode=1'b1;
		index=3'b100;
		#9;

		#1;
		mode=1'b0;
		index= 3'b101;
		number=8'b00000001;
		#9;
		if (result==50) begin $display("Case 13: Passed"); TEMP_result=TEMP_result+6; end
		else begin $display("Case 13: Failed"); $display("Expected RAM[4]: 50");$display("Returned:%d",result); end
		
		$display("RAM TESTS COMPLETED!");
		$display("LAB_4 PART 1 TESTS COMPLETED!");
		$display("TOTAL SCORE:%d",TEMP_result);

		$finish;

	end

endmodule
