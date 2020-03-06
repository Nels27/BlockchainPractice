pragma solidity ^0.4.25;

// Contract to allow users to cast votes and declare a winner
contract SimpleVoting {
    
    // Struct to represent a candidate that people can vote for
    // Has a name and the current number of votes that canddidate has received
    struct Candidate {
        bytes32 name;
        uint numberOfVotes;
    }
    
    // Struct to represent a person who can Voter
    // Has whether or not the user has voted and the index of the candidate they voted for
    struct Voter {
        bool voted;
        uint vote;
    }
    
    // List of candidates to choose from
    Candidate[] public candidates;
    
    // List of users who have voted stored by their address
    mapping(address => Voter) public votes;
    
    //Administrator who controls the voting system
    address chairPerson;
    
    // COnstructor to create a new voting system
    constructor() public {
        chairPerson = msg.sender;
        
        candidates.push(Candidate({
            name: 'Coke',
            numberOfVotes: 0
        }));
        
        candidates.push(Candidate({
            name: 'Pepsi',
            numberOfVotes: 0
        }));
        

        
    }
    
    // Function to cast a votes
    // Takes in the candidate to vote for
    function castVote(uint candidateIndex) public {
        address sender = msg.sender;
        require(!votes[sender].voted,'Voter has already voted');
        candidates[candidateIndex].numberOfVotes += 1;
        votes[sender].voted = true;
        votes[sender].vote = candidateIndex;
    }
    
    //Function to get thenumber of votes that a candidate has received
    // Takes in the index of the candidate and returns the number of votes they have
    function getNumberOfVotes(uint candidateIndex) public view returns (uint){
        return candidates[candidateIndex].numberOfVotes;
        
        
    }
    
    // Function to get whoever is currently in the lead
    // Returns the name of the candidate with the most votes
    function getWinner() public view returns (bytes32 winner) {
        
        //Used a loop to make it more scalable
        
        uint maxNumberOfVotes;
        uint length = candidates.length;
        for(uint i = 0; i < length; i++) {
            if(candidates[i].numberOfVotes > maxNumberOfVotes) {
                winner = candidates[i].name;
            }
        }
        
    }
}