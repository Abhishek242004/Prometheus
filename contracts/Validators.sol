//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Validators{
    struct validator{
        string name;
        string institution;
        bool isadmin;
    }

    struct student{
        string name;
        string institution;
        string file_link;
        string accountcreate;
    }

    mapping (address=>validator) public  val;
    mapping (address=>student) public  studentCredentials;     

    constructor(string memory nam, string memory inst){
        val[msg.sender]=validator({
            name : nam,
            isadmin : true,
            institution : inst
        });
    }

    modifier isValidator(){
        require(val[msg.sender].isadmin==true,"These functions can only be accessed by the validators");
        _;
    }
    
    // modifier sameInstitute(string memory inst ){
    //     require(keccak256(abi.encodePacked(inst)) == keccak256(abi.encodePacked(val[msg.sender].institution)),
    //         "Should be from the same institute");
    //     _;
    // }

    function addValidator(address addr, string memory nam) public isValidator {
        // val[addr].name=nam;
        // val[addr].isadmin=true;
        // val[addr].institution=val[msg.sender].institution;
        val[addr]=validator({
            name : nam,
            isadmin : true,
            institution : val[msg.sender].institution
        });
    }
    
    function addCredentials(address ad,string memory nam , string memory inst , string memory file_lin)public isValidator{
            
        studentCredentials[ad].name = nam;
        studentCredentials[ad].institution = inst;
        studentCredentials[ad].file_link = file_lin;
            
    }

    function getStudent(address studentAddr) public view returns (string memory, string memory, string memory, string memory) {
        student memory s = studentCredentials[studentAddr];
        return (s.name, s.institution, s.file_link, s.accountcreate);
    }

}