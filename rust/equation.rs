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
}