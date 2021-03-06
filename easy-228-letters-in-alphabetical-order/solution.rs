use std::io;
use std::io::BufRead;

fn is_in_order(word: String) -> bool {
    let mut last = 'a';
    for i in word.chars() {
        if i >= last {
            last = i;
        } else {
            return false
        }
    }
    return true
}

fn main(){
    let reader = io::stdin();
    for line in reader.lock().lines() {
        let word = line.unwrap();
        let ordered = is_in_order(word.clone());
        println!("{} {}", word, if ordered {"IN ORDER"} else {"NOT IN ORDER"});
    }
}
