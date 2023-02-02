pragma solidity ^0.4.23;

contract EMRList {
    address doctor; 
    struct BEMR {
        uint256 br; 
        uint256 bs; 
    }

    mapping(bytes32 => BEMR) internal emrMap; 

    constructor() public{
       doctor = msg.sender; 
    }

    function Upload(uint256 br, uint256 bs) public returns (address){
        require(msg.sender == doctor); 
        bytes32 index = keccak256(br, bs); 
        emrMap[index].br = br;
        emrMap[index].bs = bs;
        return msg.sender;
    }

    function Query(uint256 br, uint256 bs) public view returns (bool) {
        bytes32 index = keccak256(br, bs); 
        if(emrMap[index].br == br && emrMap[index].bs == bs)
            return true;
        else
            return false;
    }

    function Revoke(uint256 br, uint256 bs) public{
        require(msg.sender == doctor); 
        bytes32 index = keccak256(br, bs); 
		delete emrMap[index];
    }
}
