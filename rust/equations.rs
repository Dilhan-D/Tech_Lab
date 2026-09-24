fn main() {
  let mut x = 10;
  println!("Start: {}", x);

  x += 5;
  println!("After += 5: {}", x);

  x -= 2;
  println!("After -= 2: {}", x);

  x *= 2;
  println!("After *= 2: {}", x);

  x /= 3;
  println!("After /= 3: {}", x);

  x %= 4;
  println!("After %= 4: {}", x);

  let a = 5;
  let b = 10;

  println!("5 == 10: {}", a == b);
  println!("5 != 10: {}", a != b);
  println!("5 < 10: {}", a < b);
  println!("5 >= 10: {}", a >= b);

 // &&	AND	true if both values are true
 // ||	OR	true if at least one is true
 // !	NOT	inverts the boolean value
}