use dep::std;

// Zk circuit. private input is preimage, public input is hash. 
// Noir compiler will generate a circuit that proves that preimage hash is equal to public hash
// Circuit will not see preimage and requires only proof hash is generated correctly
fn main(preimage : [u8; 2],  hash : pub [u8; 32]) {
    let h = std::hash::sha256(preimage);
    std::println(h);
    assert(h == hash);
}

#[test]
fn test_main() {
    // We are using u8 instead of u256 for simplicity but production we should use u256
    // And a better hashing algo: pedersen hash for example. 
    // Preimage could be changed to array with n number of elements. 
    let preimage = [11, 11];
    let hash = [190, 31, 112, 6, 58, 1, 0, 85, 208, 15, 131, 187, 154, 236, 131, 18, 25, 1, 225, 166, 150, 70, 118, 122, 227, 71, 156, 35, 11, 3, 12, 231];
    main(preimage, hash);
 }
