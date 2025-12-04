class Node<T> {
  T val;
  Node? link;
  Node(this.val, this.link);
}

class Stack<T> {
  Node? top;

  void push(T n) {
    this.top = Node(n, this.top);
  }

  T? peek() {
    return this.top?.val;
  }

  T? pop() {
    var val = this.top?.val;
    this.top = this.top?.link;
    return val;
  }
}

void main() {
  var stack = Stack();
  stack.push(10);
  stack.push(20);
  print(stack.pop());
  print(stack.pop());
}
