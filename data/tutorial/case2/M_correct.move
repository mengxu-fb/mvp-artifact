address 0x1 {
module M {
  struct Counter has key, store {
    value : u8,
  }  

  public fun increment(a: address) acquires Counter {
    let r = borrow_global_mut<Counter>(a);
    r.value = r.value + 1;
  }
  spec increment {
    aborts_if !exists<Counter>(a);
    // the fix: adding a new abort condition
    aborts_if global<Counter>(a).value == 255;
    ensures global<Counter>(a).value == old(global<Counter>(a)).value + 1;
  }
}
}
