// This is a simple Rust program that prints three lines of text to the console.
// @date 2026-05-28
 
fn main() {
  let name = "Diana";
  let age = 30;
  let my_num =5;
  let second = 10.23;
  let myletter = '';
  let mybool = false; 
  const BIRTHYEAR: i32 = 1980;

  let add = 5 + 3;
  let sub = 10 - 4;
  let mul = 6 * 2;
  let div = 12 / 3;
  let rem = 10 % 3;

  println!("Add: {}", add);
  println!("Sub: {}", sub);
  println!("Mul: {}", mul);
  println!("Div: {}", div);
  println!("Rem: {}", rem);

  println!("Hello!", name);
  println!("His name is {} and he is {} years old.", name, age);
  age = 31;
  println!("His name is {} and now he is {} years old.", name, age);
  name = "D";
  println!("His name is {} and now he is {} years old.", name, age);
  println!("Hello World!");
  println!("I am \n \nlearning Rust.");
  println!("\n");
  println!("funny!");

  let mut x = 5;
  println!("Before: {}", x);
  x = 10;
  println!("After: {}", x);

}