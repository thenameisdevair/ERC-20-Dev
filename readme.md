Understanding Structs, Arrays, and Mappings in
Solidity

This document answers three core questions:
1. Where are structs, arrays, and mappings stored?
2. How do they behave when executed or called?
3. Why don’t we specify memory or storage for mappings?


1. Where Are Structs, Arrays, and Mappings Stored?

Solidity has three data locations:

- storage: Permanent data stored on-chain

- memory: Temporary data during function execution

- calldata: Read-only external function input


Contract-level variables live in storage:
struct Student {
 string name;
 uint age;
 bool present;
}
Student public s;
Student[] public students;
mapping(address => Student) public studentByWallet;


These persist between transactions and cost gas when modified.


Function-level reference types usually live in memory:

function createStudent() external pure returns (Student memory) {
 Student memory temp = Student("Ada", 20, true);
 return temp;
}


These exist only during execution and do not change blockchain state.


2. How Do They Behave When Executed or Called?

Key difference: storage = reference, memory = copy.

Storage example:
students.push(Student("John", 25, true));

This modifies blockchain state permanently.

Memory example:
Student memory copy = students[0];
copy.age = 50;
This does not modify stored data.

Mapping behavior:

studentByWallet[msg.sender].present = true;
Mappings compute storage slots using keccak256(key, mapping_slot).
Mappings do not store keys, have no length, and cannot be iterated.


3. Why Don’t We Specify memory or storage for Mappings?

Mappings are storage-only by design.

They cannot exist in memory, cannot be copied, and cannot be ABI-encoded.

Valid:
mapping(address => Student) public studentByWallet;
mapping(address => Student) storage ref = studentByWallet;

Invalid:
mapping(address => Student) memory temp; // Not allowed


Final Mental Model:

storage = permanent blockchain state
memory = temporary execution workspace
Structs and arrays can live in both.
Mappings live only in storage.
