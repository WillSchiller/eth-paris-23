use dep::std;

fn main(preimage : [u8; 2],  hash : pub [u8; 32]) {
    let h = std::hash::sha256(preimage);
    std::println(h);
    assert(h == hash);
}

#[test]
fn test_main() {
  let preimage = [10, 10];
    let hash = [117, 161, 29, 164, 76, 128, 36, 134, 188, 111, 101, 100, 10, 164, 138, 115, 15, 15, 104, 76, 92, 7, 164, 43, 163, 205, 23, 53, 235, 63, 176, 112];
    main(preimage, hash);
 }
