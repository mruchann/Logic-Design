`timescale 1ns / 1ps

//
// NOTE: This is a sample testbench, provided to you as a guidance.
//

module testbench_ballot(
    );

	reg [1:0] mode;
	reg [5:0] userID;
	reg [1:0] candidate; // 00:Air 01:Fire, 10:Earth, 11: Water
	reg clk;
	wire [1:0] ballotBoxId;
	wire [5:0] numberOfRegisteredVoters;
	wire [5:0] numberOfVotesWinner; // number of votes of winner
	wire [1:0] WinnerId;
	wire AlreadyRegistered;
	wire AlreadyVoted;
	wire NotRegistered;
	wire VotingHasNotStarted;
	wire RegistrationHasEnded;

	// Instantiate the Unit Under Test (UUT)
   SelectionOfAvatar uut(
		mode,
		userID,
		candidate,
		clk,
		ballotBoxId,
        numberOfRegisteredVoters,
        numberOfVotesWinner,
        WinnerId,
        AlreadyRegistered,
        AlreadyVoted,
        NotRegistered,
        VotingHasNotStarted,
        RegistrationHasEnded
	);

	// At 5, 15, 25, .. clk will change 0->1
	// At 10, 20, 30, .. clk will change 1->0
   	initial clk = 0;
	always #5 clk = ~clk;


	initial begin

		//... you may add your tests here
		$display("Starting Testbench: Election of the Avatar  ...");
		// Case 1 :  Line 2
		#1;
		mode = 1;
		userID = 6'b000000;
		candidate = 2'b01;
		#7;
		if (VotingHasNotStarted == 1 && 
			AlreadyRegistered == 0 &&
			AlreadyVoted == 0 &&
			NotRegistered == 0 &&
			RegistrationHasEnded == 0 && 
			numberOfRegisteredVoters == 0
			&& ballotBoxId == 2'b00
			&& numberOfVotesWinner == 6'b000000
			&& WinnerId == 2'b00)
			$display("Case 1 : Passed");
		else
		begin
			$display("Case 1 : Failed ");
			$display ("Expected : VotingHasNotStarted = 1 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t RegistrationHasEnded = 0 \t numberOfRegisteredVoters = 0 \t ballotBoxId = 00 \t numberOfVotesWinner = 0 \t WinnerId = 0, numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : VotingHasNotStarted = %b \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t RegistrationHasEnded = %b \t numberOfRegisteredVoters = %d \t ballotBoxId = %b \t numberOfVotesWinner = %b \t WinnerId = %b", VotingHasNotStarted, AlreadyRegistered, AlreadyVoted, NotRegistered, RegistrationHasEnded, numberOfRegisteredVoters, ballotBoxId, numberOfVotesWinner, WinnerId);
		end
		// Case 2 :  Line 3
		#1;
		mode = 0;
		userID = 6'b000000;
		candidate = 2'b01; // its dont care in this case
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b000001 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted == 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		) 
			$display("Case 2 : Passed");
		else
		begin
			$display("Case 2 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 1 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 3 :  Line 4
		#1;
		mode = 0;
		userID = 6'b000000;
		candidate = 2'b00; // its dont care in this case
		#9;
		if (
			ballotBoxId == 2'b00 && 
			numberOfRegisteredVoters == 6'b000001 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		) 
			$display("Case 3 : Passed");
		else	
		begin
			$display("Case 3 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 1 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end

		// display numberOfRegisteredVoters as an integer
		// Case 4 :  Line 5
		#1;
		mode = 0;
		userID = 6'b000001;
		candidate = 2'b01;
		#9;
		if (ballotBoxId == 2'b00 && 
			numberOfRegisteredVoters == 6'b000010 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		) 
			$display("Case 4 : Passed");
		else
		begin
			$display("Case 4 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 2 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		

		// Case 5 :  Line 6
		#1;
		mode = 0;
		userID = 6'b000010;
		candidate = 2'b01;
		#9;
		if (
		ballotBoxId == 2'b00 &&
		numberOfRegisteredVoters == 6'b000011 &&
		AlreadyRegistered == 0 &&
		AlreadyVoted	== 0 &&
		NotRegistered == 0 &&
		VotingHasNotStarted == 0 &&
		RegistrationHasEnded == 0 &&
		numberOfVotesWinner == 6'b000000 &&
		WinnerId == 2'b00
		) 
			$display("Case 5 : Passed");
		else
		begin
			$display("Case 5 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 3 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 6 :  Line 7
		#1;
		mode = 0;
		userID = 6'b000011;
		#9;
		if (
		ballotBoxId == 2'b00 &&
		numberOfRegisteredVoters == 6'b000100 &&
		AlreadyRegistered == 0 &&
		AlreadyVoted	== 0 &&
		NotRegistered == 0 &&
		VotingHasNotStarted == 0 &&
		RegistrationHasEnded == 0 &&
		numberOfVotesWinner == 6'b000000 &&
		WinnerId == 2'b00
		) 
			$display("Case 6 : Passed");
		else
		begin
			$display("Case 6 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 4 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 7 :  Line 8
		#1;
		mode = 0;
		userID = 6'b010000;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b000101 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted	== 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 7 : Passed");
		else
		begin
			$display("Case 7 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 5 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 8 :  Line 9
		#1;
		mode = 0;
		userID = 6'b010001;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b000110 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted	== 0 &&
			RegistrationHasEnded == 0 && 
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 8 : Passed");
		else
		begin
			$display("Case 8 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 6 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 9 :  Line 10
		#1;
		mode = 0;
		userID = 6'b010010;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b000111 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted	== 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 9 : Passed");
		else
		begin
			$display("Case 9 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 7 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 10 :  Line 11
		#1;
		mode = 0;
		userID = 6'b010011;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b001000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted	== 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 10 : Passed");
		else
		begin
			$display("Case 10 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 8 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 11 :  Line 12
		#1;
		mode = 1;
		userID = 6'b011010;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b001000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 11 : Passed");
		else
		begin
			$display("Case 11 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 8 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 12 :  Line 13
		#1;
		mode = 0;
		userID = 6'b100000;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b001001 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 12 : Passed");
		else
		begin
			$display("Case 12 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 9 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 13 :  Line 14
		#1;
		mode = 0;
		userID = 6'b100001;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b001010 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 13 : Passed");
		else
		begin
			$display("Case 13 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 10 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 14 :  Line 15
		#1;
		mode = 0;
		userID = 6'b100010;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b001011 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 14 : Passed");
		else
		begin
			$display("Case 14 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 11 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		
		// Case 15 :  Line 16
		#1;
		mode = 0;
		userID = 6'b100011;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b001100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 15 : Passed");
		else
		begin
			$display("Case 15 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 12 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 16 :  Line 17
		#1;
		mode = 1;
		userID = 6'b100011;	
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b001100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 && 
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 16 : Passed");
		else
		begin
			$display("Case 16 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 12 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \₺ numberOfVotesWinner=%b \t WinnerId=%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 17 :  Line 18
		#1;
		mode = 1;
		userID = 6'b100011;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b001100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 17 : Passed");
		else
		begin
			$display("Case 17 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 12 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 18 :  Line 19
		#1;
		mode = 1;
		userID = 6'b011111;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b001100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 18 : Passed");
		else
		begin
			$display("Case 18 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 12 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 19 :  Line 20
		#1;
		mode = 0;
		userID = 6'b010010;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b001100 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 19 : Passed");
		else
		begin
			$display("Case 19 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 12 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 20 :  Line 21
		#1;
		mode = 0;
		userID = 6'b100010;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b001100 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 20 : Passed");
		else
		begin
			$display("Case 20 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 12 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 21 :  Line 22
		#1;
		mode = 0;
		userID = 6'b110000;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b001101 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 21 : Passed");
		else
		begin
			$display("Case 21 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 13 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		
		// Case 22 :  Line 23
		#1;
		mode = 0;
		userID = 6'b110001;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b001110 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 22 : Passed");
		else
		begin
			$display("Case 22 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 14 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 23 :  Line 24
		#1;
		mode = 0;
		userID = 6'b110010;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b001111 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 23 : Passed");
		else
		begin
			$display("Case 23 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 15 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 24 :  Line 25
		#1;
		mode = 0;
		userID = 6'b110011;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b010000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 && 
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 24 : Passed");
		else
		begin
			$display("Case 24 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 16 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 25 :  Line 26
		#1;
		mode = 0;
		userID = 6'b110000;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b010000 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 25 : Passed");
		else
		begin
			$display("Case 25 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 16 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 26 :  Line 27
		#1;
		mode = 1;
		userID = 6'b110010;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b010000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 26 : Passed");
		else
		begin
			$display("Case 26 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 16 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 27 :  Line 28
		#1;
		mode = 1;
		userID = 6'b101111;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b010000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 27 : Passed");
		else
		begin
			$display("Case 27 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 16 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 28 :  Line 29
		#1;
		mode = 0;
		userID = 6'b010011;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b010000 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 28 : Passed");
		else
		begin
			$display("Case 28 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 16 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 29 :  Line 30
		#1;
		mode=0;
		userID = 6'b000100;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b010001 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 29 : Passed");
		else
		begin
			$display("Case 29 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 17 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 30 :  Line 31
		
		#1;
		mode = 0;
		userID = 6'b000101;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b010010 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 30 : Passed");
		else
		begin
			$display("Case 30 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 18 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 31 :  Line 32
		#1;
		mode = 0;
		userID = 6'b000110;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b010011 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 31 : Passed");
		else
		begin
			$display("Case 31 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 19 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 32 :  Line 33
		#1;
		mode = 0;
		userID = 6'b000100;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b010011 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 32 : Passed");
		else
		begin
			$display("Case 32 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 19 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 33 :  Line 34
		#1;
		mode = 1;
		userID = 6'b110100;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b010011 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 33 : Passed");
		else
		begin
			$display("Case 33 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 19 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 34 :  Line 35
		#1;
		mode = 0;
		userID = 6'b010100;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b010100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 34 : Passed");
		else
		begin
			$display("Case 34 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 20 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 35 :  Line 36
		#1;
		mode = 0;
		userID = 6'b010101;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b010101 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 35 : Passed");
		else
		begin
			$display("Case 35 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 21 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 36 :  Line 37
		#1;
		mode = 0;
		userID = 6'b010111;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b010110 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 36 : Passed");
		else
		begin
			$display("Case 36 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 22 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 37 :  Line 38
		#1;
		mode = 1;
		userID = 6'b010110;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b010110 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 37 : Passed");
		else
		begin
			$display("Case 37 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 22 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 38 :  Line 39
		#1;
		mode = 0;
		userID = 6'b010100;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b010110 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 38 : Passed");
		else
		begin
			$display("Case 38 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 22 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 39 :  Line 40
		#1;
		mode = 0;
		userID = 6'b100101;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b010111 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 39 : Passed");
		else
		begin
			$display("Case 39 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 23 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 40 :  Line 41
		#1;
		mode = 0;
		userID = 6'b100110;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b011000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 40 : Passed");
		else
		begin
			$display("Case 40 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 24 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		
		// Case 41 :  Line 42
		#1;
		mode = 1;
		userID = 6'b010100;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b011000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 41 : Passed");
		else
		begin
			$display("Case 41 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 24 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 42 :  Line 43
		#1;
		mode = 0;
		userID = 6'b010111;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b011000 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 42 : Passed");
		else
		begin
			$display("Case 42 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 24 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 43 :  Line 44
		#1;
		mode = 0;
		userID = 6'b100111;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b011001 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 43 : Passed");
		else
		begin
			$display("Case 43 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 25 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 44 :  Line 45
		#1;
		mode = 0;
		userID = 6'b110100;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b011010 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 44 : Passed");
		else
		begin
			$display("Case 44 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 26 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 45 :  Line 46
		#1;
		mode = 0;
		userID = 6'b110110;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b011011 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 45 : Passed");
		else
		begin
			$display("Case 45 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 27 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 46 :  Line 47
		#1;
		mode = 1;
		userID = 6'b110101;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b011011 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 46 : Passed");
		else
		begin
			$display("Case 46 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 27 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
	 	// Case 47 :  Line 48
		#1;
		mode = 0;
		userID = 6'b110100;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b011011 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 47 : Passed");
		else
		begin
			$display("Case 47 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 27 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
	 	// Case 48 :  Line 49
		#1;
		mode = 0;
		userID = 6'b000000;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b011011 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 48 : Passed");
		else
		begin
			$display("Case 48 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 27 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
	 	// Case 49 :  Line 50
		#1;
		mode = 0;
		userID = 6'b010011;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b011011 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 49 : Passed");
		else
		begin
			$display("Case 49 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 27 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
	 	// Case 50 :  Line 51
		#1;
		mode = 0;
		userID = 6'b100011;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b011011 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 50 : Passed");
		else
		begin
			$display("Case 50 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 27 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 51 :  Line 52
		#1;
		mode = 0;
		userID = 6'b110011;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b011011 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 51 : Passed");
		else
		begin
			$display("Case 51 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 27 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 52 :  Line 53
		#1;
		mode = 0;
		userID = 6'b110111;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b011100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00	
		)
			$display("Case 52 : Passed");
		else
		begin
			$display("Case 52 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 28 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 53 :  Line 54
		#1;
		mode = 0;
		userID = 6'b001000;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b011101 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 53 : Passed");
		else
		begin
			$display("Case 53 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 29 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 54 :  Line 55
		#1;
		mode = 0;
		userID = 6'b001001;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b011110 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 54 : Passed");
		else
		begin
			$display("Case 54 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 30 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 55 :  Line 56
		#1;
		mode = 0;
		userID = 6'b001011;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b011111 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 55 : Passed");
		else
		begin
			$display("Case 55 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 31 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 56 :  Line 57
		#1;
		mode = 1;
		userID = 6'b001011;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b011111 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 56 : Passed");
		else
		begin
			$display("Case 56 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 31 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 57 :  Line 58
		#1;
		mode = 0;
		userID = 6'b001100;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b100000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 57 : Passed");
		else
		begin
			$display("Case 57 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 32 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 58 :  Line 59
		#1;
		mode = 0;
		userID = 6'b001110;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b100001 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 58 : Passed");
		else
		begin
			$display("Case 58 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 33 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 59 :  Line 60
		#1;
		mode = 0;
		userID = 6'b001111;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b100010 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 59 : Passed");
		else
		begin
			$display("Case 59 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 34 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 60 :  Line 61
		#1;
		mode = 0;
		userID = 6'b011000;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b100011 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 60 : Passed");
		else
		begin
			$display("Case 60 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 35 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 61 :  Line 62
		#1;
		mode = 0;
		userID = 6'b011001;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b100100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 61 : Passed");
		else
		begin
			$display("Case 61 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 36 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 62 :  Line 63
		#1;
		mode = 0;
		userID = 6'b011010;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b100101 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 62 : Passed");
		else
		begin
			$display("Case 62 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 37 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 63 :  Line 64
		#1;
		mode = 0;
		userID = 6'b011101;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b100110 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 63 : Passed");
		else
		begin
			$display("Case 63 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 38 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 64 :  Line 65
		#1;
		mode = 0;
		userID = 6'b011110;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b100111 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 64 : Passed");
		else
		begin
			$display("Case 64 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 39 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end

		// Case 65 :  Line 66
		#1;
		mode = 0;
		userID = 6'b011111;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b101000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 65 : Passed");
		else
		begin
			$display("Case 65 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 40 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 66 :  Line 67
		#1;
		mode = 1;
		userID = 6'b100000;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b101000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 66 : Passed");
		else
		begin
			$display("Case 66 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 40 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 67 :  Line 68
		#1;
		mode = 0;
		userID = 6'b001111;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b101000 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 67 : Passed");
		else
		begin
			$display("Case 67 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 40 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 68 :  Line 69
		#1;
		mode = 0;
		userID = 6'b011101;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b101000 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 68 : Passed");
		else
		begin
			$display("Case 68 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 40 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 69 :  Line 70
		#1;
		mode = 0;
		userID = 6'b100101;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b101000 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 69 : Passed");
		else
		begin
			$display("Case 69 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 40 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 70 :  Line 71
		#1;
		mode = 0;
		userID = 6'b110001;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b101000 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 70 : Passed");
		else
		begin
			$display("Case 70 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 40 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 71 :  Line 72
		#1;
		mode = 1;
		userID = 6'b101010;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b101000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 71 : Passed");
		else
		begin
			$display("Case 71 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 40 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 72 :  Line 73
		#1;
		mode = 1;
		userID = 6'b111010;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b101000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 72 : Passed");
		else
		begin
			$display("Case 72 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 40 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 73 :  Line 74
		#1;
		mode = 1;
		userID = 6'b001011;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b101000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 73 : Passed");
		else
		begin
			$display("Case 73 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 40 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 74 :  Line 75
		#1;
		mode = 0;
		userID = 6'b100111;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b101000 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 74 : Passed");
		else
		begin
			$display("Case 74 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 40 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 75 :  Line 76
		#1;
		mode = 0;
		userID = 6'b110110;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b101000 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 75 : Passed");
		else
		begin
			$display("Case 75 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 40 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		
		// Case 76 :  Line 77
		#1;
		mode = 0;
		userID = 6'b101000;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b101001 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 76 : Passed");
		else
		begin
			$display("Case 76 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 41 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 77 :  Line 78
		#1;
		mode = 0;
		userID = 6'b101010;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b101010 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 77 : Passed");
		else
		begin
			$display("Case 77 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 42 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 78 :  Line 79
		#1;
		mode = 0;
		userID = 6'b101011;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b101011 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 78 : Passed");
		else
		begin
			$display("Case 78 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 43 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 79 :  Line 80
		#1;
		mode = 0;
		userID = 6'b101100;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b101100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 79 : Passed");
		else
		begin
			$display("Case 79 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 44 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 80 :  Line 81
		#1;
		mode = 0;
		userID = 6'b101101;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b101101 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 80 : Passed");
		else
		begin
			$display("Case 80 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 45 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 81 :  Line 82
		#1;
		mode = 0;
		userID = 6'b101111;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b101110 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 81 : Passed");
		else
		begin
			$display("Case 81 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 46 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 82 :  Line 83
		#1;
		mode = 1;
		userID = 6'b110000;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b101110 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 82 : Passed");
		else
		begin
			$display("Case 82 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 46 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 83 :  Line 84
		#1;
		mode = 1;
		userID = 6'b000110;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b101110 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 83 : Passed");
		else
		begin
			$display("Case 83 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 46 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 84 :  Line 85
		#1;
		mode = 1;
		userID = 6'b010111;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b101110 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 84 : Passed");
		else
		begin
			$display("Case 84 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 46 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		
		// Case 85 :  Line 86
		#1;
		mode = 1;
		userID = 6'b100011;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b101110 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 85 : Passed");
		else
		begin
			$display("Case 85 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 46 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 86 :  Line 87
		#1;
		mode = 0;
		userID = 6'b111000;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b101111 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 86 : Passed");
		else
		begin
			$display("Case 86 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 47 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 87 :  Line 88
		#1;
		mode = 0;
		userID = 6'b111001;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110000 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 87 : Passed");
		else
		begin
			$display("Case 87 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 48 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 88 :  Line 89
		#1;
		mode = 0;
		userID = 6'b111010;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110001 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 88 : Passed");
		else
		begin
			$display("Case 88 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 49 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 89 :  Line 90
		#1;
		mode = 1;
		userID = 6'b101011;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110001 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 && 
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 89 : Passed");
		else
		begin
			$display("Case 89 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 49 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 90 :  Line 91
		#1;
		mode = 0;
		userID = 6'b111000;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110001 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 90 : Passed");
		else
		begin
			$display("Case 90 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 49 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		
		// Case 91 :  Line 92
		#1;
		mode = 0;
		userID = 6'b011001;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110001 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 91 : Passed");
		else
		begin
			$display("Case 91 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 49 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 92 :  Line 93
		#1;
		mode = 0;
		userID = 6'b001011;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110001 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 && 
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 92 : Passed");
		else
		begin
			$display("Case 92 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 49 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 93 :  Line 94
		#1;
		mode = 0;
		userID = 6'b111100;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110010 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 93 : Passed");
		else
		begin
			$display("Case 93 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 50 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 94 :  Line 95
		#1;
		mode = 1;
		userID = 6'b111101;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110010 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 94 : Passed");
		else
		begin
			$display("Case 94 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 50 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 95 :  Line 96
		#1;
		mode = 0;
		userID = 6'b111101;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110011 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 95 : Passed");
		else
		begin
			$display("Case 95 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 51 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 96 :  Line 97
		#1;
		mode = 1;
		userID = 6'b111111;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110011 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 1 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 96 : Passed");
		else
		begin
			$display("Case 96 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 51 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 1 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
			
		// Case 97 :  Line 98
		#1;
		mode = 0;
		userID = 6'b111111;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 97 : Passed");
		else
		begin
			$display("Case 97 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 98 :  Line 99
		#1;
		mode = 0;
		userID = 6'b000001;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 98 : Passed");
		else
		begin
			$display("Case 98 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 99 :  Line 100
		#1;
		mode = 0;
		userID = 6'b010011;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 99 : Passed");
		else
		begin
			$display("Case 99 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 100 :  Line 101
		#1;
		mode = 0;
		userID = 6'b100000;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 1 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 100 : Passed");
		else
		begin
			$display("Case 100 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 1 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		
		// Case 101 :  Line 102
		#1;
		mode = 0;
		userID = 6'b111111;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 101 : Passed");
		else
		begin
			$display("Case 101 : Failed %t", $time);
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %d \t WinnerId = %d", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 102 :  Line 103
		#1;
		mode = 0;
		userID = 6'b000001;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 102 : Passed");
		else
		begin
			$display("Case 102 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 103 :  Line 104
		#1;
		mode = 0;
		userID = 6'b010011;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 && 
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 103 : Passed");
		else
		begin
			$display("Case 103 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 104 :  Line 105
		#1;
		mode = 0;
		userID = 6'b100000;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 104 : Passed");
		else
		begin
			$display("Case 104 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		
		// Case 105 :  Line 106
		#1;
		mode = 1;
		userID = 6'b000111;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 105 : Passed");
		else
		begin
			$display("Case 105 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 106 :  Line 107
		#1;
		mode = 1;
		userID = 6'b010110;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 && 
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 106 : Passed");
		else
		begin
			$display("Case 106 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 107 :  Line 108
		#1;
		mode = 1;
		userID = 6'b100100;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 107 : Passed");
		else
		begin
			$display("Case 107 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 108 :  Line 109
		#1;
		mode = 1;
		userID = 6'b000000;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 108 : Passed");
		else
		begin
			$display("Case 108 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 109 :  Line 110
		#1;
		mode = 1;
		userID = 6'b000001;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 109 : Passed");
		else
		begin
			$display("Case 109 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 110 :  Line 111
		#1;
		mode = 1;
		userID = 6'b000010;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 110 : Passed");
		else
		begin
			$display("Case 110 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 111 :  Line 112
		#1;
		mode = 1;
		userID = 6'b000011;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 111 : Passed");
		else
		begin
			$display("Case 111 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 112 :  Line 113
		#1;
		mode = 1;
		userID = 6'b000001;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 112 : Passed");
		else
		begin
			$display("Case 112 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 113 :  Line 114
		#1;
		mode = 1;
		userID = 6'b000010;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 113 : Passed");
		else
		begin
			$display("Case 113 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 114 :  Line 115
		#1;
		mode = 1;
		userID = 6'b010000;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 114 : Passed");
		else
		begin
			$display("Case 114 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 115 :  Line 116
		#1;
		mode = 1;
		userID = 6'b010001;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 115 : Passed");
		else
		begin
			$display("Case 115 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 116 :  Line 117
		#1;
		mode = 1;
		userID = 6'b010010;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 116 : Passed");
		else
		begin
			$display("Case 116 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 117 :  Line 118
		#1;
		mode = 1;
		userID = 6'b010011;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 117 : Passed");
		else
		begin
			$display("Case 117 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 118 :  Line 119
		#1;
		mode = 1;
		userID = 6'b010010;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 118 : Passed");
		else
		begin
			$display("Case 118 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 119 :  Line 120
		#1;
		mode = 1;
		userID = 6'b010011;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 119 : Passed");
		else
		begin
			$display("Case 119 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 120 :  Line 121
		#1;
		mode = 1;
		userID = 6'b100000;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 120 : Passed");
		else
		begin
			$display("Case 120 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 121 :  Line 122
		#1;
		mode = 1;
		userID = 6'b100001;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		) 
			$display("Case 121 : Passed");
		else
		begin
			$display("Case 121 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 122 :  Line 123
		#1;
		mode = 1;
		userID = 6'b100010;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 122 : Passed");
		else
		begin
			$display("Case 122 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		
		// Case 123 :  Line 124
		#1;
		mode = 1;
		userID = 6'b100011;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 123 : Passed");
		else
		begin
			$display("Case 123 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 52 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted = 0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner = %b \t WinnerId = %b", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 124 :  Line 125
		#1;
		mode = 1;
		userID = 6'b110000;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 124 : Passed");
		else
		begin
			$display("Case 124 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded=0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 125 :  Line 126
		#1;
		mode = 1;
		userID = 6'b110001;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 125 : Passed");
		else
		begin
			$display("Case 125 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded=0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 126 :  Line 127
		#1;
		mode = 1;
		userID = 6'b110010;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 126 : Passed");
		else
		begin
			$display("Case 126 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded=0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 127 :  Line 128
		#1;
		mode = 1;
		userID = 6'b110011;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 && 
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 127 : Passed");
		else
		begin
			$display("Case 127 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded=0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 128 :  Line 129
		#1;
		mode = 0;
		userID = 6'b110100;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 128 : Passed");
		else
		begin
			$display("Case 128 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 129 :  Line 130
		#1;
		mode = 0;
		userID = 6'b100101;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 129 : Passed");
		else
		begin
			$display("Case 129 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 130 :  Line 131
		#1;
		mode = 1;
		userID = 6'b000100;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 130 : Passed");
		else
		begin
			$display("Case 130 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 131 :  Line 132
		#1;
		mode = 1;
		userID = 6'b000101;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 && 
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 131 : Passed");
		else
		begin
			$display("Case 131 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 132 :  Line 133
		#1;
		mode = 1;
		userID = 6'b000110;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 132 : Passed");
		else
		begin
			$display("Case 132 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 133 :  Line 134
		#1;
		mode = 1;
		userID = 6'b000111;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 133 : Passed");
		else
		begin
			$display("Case 133 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 134 :  Line 135
		#1;
		mode = 1;
		userID = 6'b010100;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 134 : Passed");
		else
		begin
			$display("Case 134 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 135 :  Line 136
		#1;
		mode = 1;
		userID = 6'b010101;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 135 : Passed");
		else
		begin
			$display("Case 135 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 136 :  Line 137
		#1;
		mode = 1;
		userID = 6'b010110;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 136 : Passed");
		else
		begin
			$display("Case 136 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 137 :  Line 138
		#1;
		mode = 1;
		userID = 6'b010111;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 137 : Passed");
		else
		begin
			$display("Case 137 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 138 :  Line 139
		#1;
		mode = 1;
		userID = 6'b100100;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 138 : Passed");
		else
		begin
			$display("Case 138 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 139 :  Line 140
		#1;
		mode = 1;
		userID = 6'b100101;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 139 : Passed");
		else
		begin
			$display("Case 139 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 140 :  Line 141
		#1;
		mode = 1;
		userID = 6'b100110;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 140 : Passed");
		else
		begin
			$display("Case 140 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 141 :  Line 142
		#1;
		mode = 1;
		userID = 6'b100111;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 141 : Passed");
		else
		begin
			$display("Case 141 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 142 :  Line 143
		#1;
		mode = 1;
		userID = 6'b110100;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 142 : Passed");
		else
		begin
			$display("Case 142 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 143 :  Line 144
		#1;
		mode = 1;
		userID = 6'b110101;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 143 : Passed");
		else
		begin
			$display("Case 143 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 144 :  Line 145
		#1;
		mode = 1;
		userID = 6'b110110;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 && 
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 144 : Passed");
		else
		begin
			$display("Case 144 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 145 :  Line 146
		#1;
		mode = 1;
		userID = 6'b110111;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 145 : Passed");
		else
		begin
			$display("Case 145 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end

		// Case 146 :  Line 147
		#1;
		mode = 1;
		userID = 6'b010100;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 146 : Passed");
		else
		begin
			$display("Case 146 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 147 :  Line 148
		#1;
		mode = 1;
		userID = 6'b110001;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 147 : Passed");
		else
		begin
			$display("Case 147 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 148 :  Line 149
		#1;
		mode = 1;
		userID = 6'b010110;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 148 : Passed");
		else
		begin
			$display("Case 148 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 149 :  Line 150
		#1;
		mode = 1;
		userID = 6'b000111;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 149 : Passed");
		else
		begin
			$display("Case 149 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 150 :  Line 151
		#1;
		mode = 1;
		userID = 6'b001000;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 150 : Passed");
		else
		begin
			$display("Case 150 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 151 :  Line 152
		#1;
		mode = 1;
		userID = 6'b001001;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 151 : Passed");
		else
		begin
			$display("Case 151 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 152 :  Line 153
		#1;
		mode = 1;
		userID = 6'b001010;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 152 : Passed");
		else
		begin
			$display("Case 152 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 153 :  Line 154
		#1;
		mode = 1;
		userID = 6'b001011;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 153 : Passed");
		else
		begin
			$display("Case 153 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 154 :  Line 155
		#1;
		mode = 1;
		userID = 6'b011000;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 154 : Passed");
		else
		begin
			$display("Case 154 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 155 :  Line 156
		#1;
		mode = 1;
		userID = 6'b011001;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 155 : Passed");
		else
		begin
			$display("Case 155 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 156 :  Line 157
		#1;
		mode = 1;
		userID = 6'b011010;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 156 : Passed");
		else
		begin
			$display("Case 156 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 157 :  Line 158
		#1;
		mode = 1;
		userID = 6'b011011;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 157 : Passed");
		else
		begin
			$display("Case 157 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 158 :  Line 159
		#1;
		mode = 1;
		userID = 6'b101000;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 158 : Passed");
		else
		begin
			$display("Case 158 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 159 :  Line 160
		#1;
		mode = 1;
		userID = 6'b101001;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 159 : Passed");
		else
		begin
			$display("Case 159 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 160 :  Line 161
		#1;
		mode = 1;
		userID = 6'b101010;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 160 : Passed");
		else
		begin
			$display("Case 160 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 161 :  Line 162
		#1;
		mode = 1;
		userID = 6'b101011;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 161 : Passed");
		else
		begin
			$display("Case 161 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 162 :  Line 163
		#1;
		mode = 1;
		userID = 6'b111000;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 162 : Passed");
		else
		begin
			$display("Case 162 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 163 :  Line 164
		#1;
		mode = 1;
		userID = 6'b111001;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 163 : Passed");
		else
		begin
			$display("Case 163 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 164 :  Line 165
		#1;
		mode = 1;
		userID = 6'b111010;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 164 : Passed");
		else
		begin
			$display("Case 164 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 165 :  Line 166
		#1;
		mode = 1;
		userID = 6'b111011;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 165 : Passed");
		else
		begin
			$display("Case 165 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 166 :  Line 167
		#1;
		mode = 0;
		userID = 6'b111100;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 166 : Passed");
		else
		begin
			$display("Case 166 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 167 :  Line 168
		#1;
		mode = 0;
		userID = 6'b011101;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 167 : Passed");
		else
		begin
			$display("Case 167 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 168 :  Line 169
		#1;
		mode = 1;
		userID = 6'b011010;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 168 : Passed");
		else
		begin
			$display("Case 168 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 169 :  Line 170
		#1;
		mode = 1;
		userID = 6'b001010;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 169 : Passed");
		else
		begin
			$display("Case 169 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 170 :  Line 171
		#1;
		mode = 1;
		userID = 6'b101001;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 170 : Passed");
		else
		begin
			$display("Case 170 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 171 :  Line 172
		#1;
		mode = 0;
		userID = 6'b101001;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 171 : Passed");
		else
		begin
			$display("Case 171 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 172 :  Line 173
		#1;
		mode = 0;
		userID = 6'b111001;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 172 : Passed");
		else
		begin
			$display("Case 172 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 173 :  Line 174
		#1;
		mode = 1;
		userID = 6'b010011;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 173 : Passed");
		else
		begin
			$display("Case 173 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 174 :  Line 175
		#1;
		mode = 1;
		userID = 6'b100111;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&	
			WinnerId == 2'b00
		)
			$display("Case 174 : Passed");
		else
		begin
			$display("Case 174 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 175 :  Line 176
		#1;
		mode = 1;
		userID = 6'b110011;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 175 : Passed");
		else
		begin
			$display("Case 175 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 176 :  Line 177
		#1;
		mode = 1;
		userID = 6'b000001;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 176 : Passed");
		else
		begin
			$display("Case 176 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 177 :  Line 178
		#1;
		mode = 1;
		userID = 6'b011000;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 177 : Passed");
		else
		begin
			$display("Case 177 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 178 :  Line 179
		#1;
		mode = 1;
		userID = 6'b101011;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 178 : Passed");
		else
		begin
			$display("Case 178 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
			
		// Case 179 :  Line 180
		#1;
		mode = 1;
		userID = 6'b111011;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 179 : Passed");
		else
		begin
			$display("Case 179 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 180 :  Line 181
		#1;
		mode = 1;
		userID = 6'b101010;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 180 : Passed");
		else
		begin
			$display("Case 180 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 181 :  Line 182
		#1;
		mode = 1;
		userID = 6'b001100;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 181 : Passed");
		else
		begin
			$display("Case 181 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 182 :  Line 183
		#1;
		mode = 1;
		userID = 6'b001101;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 182 : Passed");
		else
		begin
			$display("Case 182 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 183 :  Line 184
		#1;
		mode = 1;
		userID = 6'b001110;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 && 
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 183 : Passed");
		else
		begin
			$display("Case 183 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 184 :  Line 185
		#1;
		mode = 1;
		userID = 6'b001111;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 184 : Passed");
		else
		begin
			$display("Case 184 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 185 :  Line 186
		#1;
		mode = 1;
		userID = 6'b011100;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 185 : Passed");
		else
		begin
			$display("Case 185 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 186 :  Line 187
		#1;
		mode = 1;
		userID = 6'b011101;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 186 : Passed");
		else
		begin
			$display("Case 186 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 187 :  Line 188
		#1;
		mode = 1;
		userID = 6'b011110;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 187 : Passed");
		else
		begin
			$display("Case 187 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 188 :  Line 189
		#1;
		mode = 1;
		userID = 6'b011111;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 188 : Passed");
		else
		begin
			$display("Case 188 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 189 :  Line 190
		#1;
		mode = 1;
		userID = 6'b101100;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 189 : Passed");
		else
		begin
			$display("Case 189 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 190 :  Line 191
		#1;
		mode = 1;
		userID = 6'b101101;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 190 : Passed");
		else
		begin
			$display("Case 190 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		
		// Case 191 :  Line 192
		#1;
		mode = 1;
		userID = 6'b101110;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 && 
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 191 : Passed");
		else
		begin
			$display("Case 191 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 192 :  Line 193
		#1;
		mode = 1;
		userID = 6'b101111;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		) 
			$display("Case 192 : Passed");
		else
		begin
			$display("Case 192 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 193 :  Line 194
		#1;
		mode = 1;
		userID = 6'b111100;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 193 : Passed");
		else
		begin
			$display("Case 193 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 194 :  Line 195
		#1;
		mode = 1;
		userID = 6'b111101;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 194 : Passed");
		else
		begin
			$display("Case 194 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 195 :  Line 196
		#1;
		mode = 1;
		userID = 6'b111110;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 1 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 195 : Passed");
		else
		begin
			$display("Case 195 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 1 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 196 :  Line 197
		#1;
		mode = 1;
		userID = 6'b111111;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 196 : Passed");
		else
		begin
			$display("Case 196 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 197 :  Line 198
		#1;
		mode = 0;
		userID = 6'b000111;
		candidate= 2'b00;
		#9;
		if (
			ballotBoxId == 2'b00 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 197 : Passed");
		else
		begin
			$display("Case 197 : Failed ");
			$display ("Expected : ballotBoxId = 00 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 198 :  Line 199
		#1;
		mode = 0;
		userID = 6'b011000;
		candidate= 2'b01;
		#9;
		if (
			ballotBoxId == 2'b01 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 0 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 1 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 198 : Passed");
		else
		begin
			$display("Case 198 : Failed ");
			$display ("Expected : ballotBoxId = 01 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 0 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 1 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 199 :  Line 200
		#1;
		mode = 1;
		userID = 6'b101101;
		candidate= 2'b10;
		#9;
		if (
			ballotBoxId == 2'b10 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 199 : Passed");
		else
		begin
			$display("Case 199 : Failed ");
			$display ("Expected : ballotBoxId = 10 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		// Case 200 :  Line 201
		#1;
		mode = 1;
		userID = 6'b111111;
		candidate= 2'b11;
		#9;
		if (
			ballotBoxId == 2'b11 &&
			numberOfRegisteredVoters == 6'b110100 &&
			AlreadyRegistered == 0 &&
			AlreadyVoted	== 1 &&
			NotRegistered == 0 &&
			VotingHasNotStarted == 0 &&
			RegistrationHasEnded == 0 &&
			numberOfVotesWinner == 6'b000000 &&
			WinnerId == 2'b00
		)
			$display("Case 200 : Passed");
		else
		begin
			$display("Case 200 : Failed ");
			$display ("Expected : ballotBoxId = 11 \t numberOfRegisteredVoters = 110100 \t AlreadyRegistered = 0 \t AlreadyVoted = 1 \t NotRegistered = 0 \t VotingHasNotStarted=0 \t RegistrationHasEnded = 0 \t numberOfVotesWinner = 0 \t WinnerId = 0");
			$display ("Returned : ballotBoxId = %b \t numberOfRegisteredVoters = %d \t AlreadyRegistered = %b \t AlreadyVoted = %b \t NotRegistered = %b \t VotingHasNotStarted =%b \t RegistrationHasEnded = %b \t numberOfVotesWinner=%b \t WinnerId =%b ", ballotBoxId, numberOfRegisteredVoters, AlreadyRegistered, AlreadyVoted, NotRegistered,VotingHasNotStarted ,RegistrationHasEnded, numberOfVotesWinner, WinnerId);
		end
		
		// Case 201 :  Line 202
		#1;
		mode = 0;
		userID = 6'b000111;
		candidate= 2'b00;
		#9;
		if (
			numberOfRegisteredVoters == 6'b110100 &&
			numberOfVotesWinner == 6'b011011 &&
			WinnerId == 2'b01
		)
			$display("Case 201 : Passed");
		else
		begin
			$display("Case 201 : Failed ");
			$display ("Expected : numberOfRegisteredVoters = 110100 \t numberOfVotesWinner = 011011 \t WinnerId = 01");
			$display ("Returned : numberOfRegisteredVoters = %b \t numberOfVotesWinner = %b \t WinnerId = %b", numberOfRegisteredVoters, numberOfVotesWinner, WinnerId);
		end
		// Case 202 :  Line 203
		#1;
		mode = 1;
		userID = 6'b110111;
		candidate= 2'b01;
		#9;
		if (
			numberOfRegisteredVoters == 6'b110100 &&
			numberOfVotesWinner == 6'b011011 &&
			WinnerId == 2'b01
		)
			$display("Case 202 : Passed");
		else
		begin
			$display("Case 202 : Failed ");
			$display ("Expected : numberOfRegisteredVoters = 110100 \t numberOfVotesWinner = 011011 \t WinnerId = 01");
			$display ("Returned : numberOfRegisteredVoters = %b \t numberOfVotesWinner = %b \t WinnerId = %b", numberOfRegisteredVoters, numberOfVotesWinner, WinnerId);
		end
		// Case 203 :  Line 204
		#1;
		mode = 1;
		userID = 6'b100111;
		candidate= 2'b11;
		#9;
		if (
			numberOfRegisteredVoters == 6'b110100 &&
			numberOfVotesWinner == 6'b011011 &&
			WinnerId == 2'b01
		)
			$display("Case 203 : Passed");
		else
		begin
			$display("Case 203 : Failed ");
			$display ("Expected : numberOfRegisteredVoters = 110100 \t numberOfVotesWinner = 011011 \t WinnerId = 01");
			$display ("Returned : numberOfRegisteredVoters = %b \t numberOfVotesWinner = %b \t WinnerId = %b", numberOfRegisteredVoters, numberOfVotesWinner, WinnerId);
		end
		// Case 204 :  Line 205
		#1;
		mode = 1;
		userID = 6'b101111;
		candidate= 2'b10;
		#9;
		if (
			numberOfRegisteredVoters == 6'b110100 &&
			numberOfVotesWinner == 6'b011011 &&
			WinnerId == 2'b01
		)
			$display("Case 204 : Passed");
		else
		begin
			$display("Case 204 : Failed ");
			$display ("Expected : numberOfRegisteredVoters = 110100 \t numberOfVotesWinner = 011011 \t WinnerId = 01");
			$display ("Returned : numberOfRegisteredVoters = %b \t numberOfVotesWinner = %b \t WinnerId = %b", numberOfRegisteredVoters, numberOfVotesWinner, WinnerId);
		end
		// Case 205 :  Line 206
		#1;
		mode = 0;
		userID = 6'b111010;
		candidate= 2'b01;
		#9;
		if (
			numberOfRegisteredVoters == 6'b110100 &&
			numberOfVotesWinner == 6'b011011 &&
			WinnerId == 2'b01
		) 
		begin
			$display("Case 205 : Passed");
			$display("The avatar candidate of the Fire Nation was entitled to become an avatar by receiving more than 50 percent of the valid votes.");
			$display("Fire Lord Ozai sends his best wishes to deputies from all nations who have chosen the next avatar from the fire nation.");
			$display("Fire Lord Ozai is giving a speech to the fire nation from the palace balcony.");
			$display("one nation, one flag, one home, one state.");
			$display("FIRE NATION");
		end
		else
		begin
			$display("Case 205 : Failed ");
			$display ("Expected : numberOfRegisteredVoters = 110100 \t numberOfVotesWinner = 011011 \t WinnerId = 01");
			$display ("Returned : numberOfRegisteredVoters = %b \t numberOfVotesWinner = %b \t WinnerId = %b", numberOfRegisteredVoters, numberOfVotesWinner, WinnerId);
		end

	$finish;

	end
endmodule