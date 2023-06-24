`timescale 1ns / 1ps

module SelectionOfAvatar(
						input [1:0] mode,
						input [5:0] userID,
						input [1:0] candidate, // 00:Air 01:Fire, 10:Water, 11:Earth
						input CLK,
						output reg [1:0] ballotBoxId,
						output reg [5:0] numberOfRegisteredVoters,
						output reg [5:0] numberOfVotesWinner, // number of votes of winner
						output reg [1:0] WinnerId,
						output reg AlreadyRegistered,
						output reg AlreadyVoted,
						output reg NotRegistered,
						output reg VotingHasNotStarted,
						output reg RegistrationHasEnded
);

	reg [7:0] cycle;
	reg [63:0]registeredVoters;
	reg [63:0]votedVoters;
	reg [3:0][5:0] votes;
	reg [5:0] max_value;
	reg [1:0] max_id;

	initial begin
		numberOfVotesWinner = 6'b000000;
		numberOfRegisteredVoters = 6'b000000;
		numberOfVotesWinner = 6'b000000;
		WinnerId = 2'b00;
		cycle = 8'b00000000;
		for (integer i = 0; i < 64; i = i + 1) begin
			registeredVoters[i] = 1'b0;
		end
		for (integer i = 0; i < 64; i = i + 1) begin
			votedVoters[i] = 1'b0;
		end
		for (integer i = 0; i < 4; i = i + 1) begin
			votes[i] = 6'b000000;
		end
		max_value = 6'b000000;
		max_id = 2'b00;
	end

	always @(posedge CLK)
	begin
		cycle = cycle + 1;
		AlreadyRegistered = 1'b0;
		AlreadyVoted = 1'b0;
		NotRegistered = 1'b0;
		VotingHasNotStarted = 1'b0;
		RegistrationHasEnded = 1'b0;
		ballotBoxId = userID[5:4];
		// enrollment time
		if (cycle <= 8'd100) begin
			// register
			if (mode == 1'b0) begin
				// haven't registered yet
				if (registeredVoters[userID] == 1'b0) begin
					registeredVoters[userID] = 1'b1;
					numberOfRegisteredVoters = numberOfRegisteredVoters + 1'b1;
				end
				// already registered
				else begin
					AlreadyRegistered = 1'b1;
				end
			end
			// vote
			else if (mode == 1'b1) begin
				VotingHasNotStarted = 1'b1;
			end
		end
		// voting time
		else if (8'd100 < cycle && cycle <= 8'd200) begin
			// vote
			if (mode == 1'b1) begin
				// registered
				if (registeredVoters[userID] == 1'b1) begin
					// haven't voted yet
					if (votedVoters[userID] == 1'b0) begin
						votes[candidate] = votes[candidate] + 1'b1;
						votedVoters[userID] = 1'b1;
					end
					// already voted
					else begin
						AlreadyVoted = 1'b1;
					end
				end
				// not registered
				else begin
					NotRegistered = 1'b1;
				end	
			end
			// register
			else if (mode == 1'b0) begin
				RegistrationHasEnded = 1'b1;
			end
		end
		// winner announcement time
		else begin
			max_value = votes[0];
			max_id = 2'b00;
			for (integer i = 1; i < 4; i = i + 1) begin
				if (votes[i] > max_value) begin
					max_value = votes[i];
					max_id = i;
				end
			end
			WinnerId = max_id;
			numberOfVotesWinner = max_value;
		end
	end
	
endmodule