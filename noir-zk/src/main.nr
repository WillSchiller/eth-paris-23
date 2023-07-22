use dep::std;


fn main(preimage : [u8; 2],  hash : pub [u8; 32]) {
    let h = std::hash::sha256(preimage);
    std::println(h);
    assert(h == hash);
}

#[test]
fn test_main() {
    let preimage = [11081977, 123456789];
    let hash = [121, 13, 145, 140, 30, 74, 212, 191, 84, 80, 248, 124, 234, 174, 203, 68, 79, 20, 192, 114, 159, 47, 232, 127, 80, 125, 4, 183, 247, 32, 68, 186]
;
    main(preimage, hash);
 }
