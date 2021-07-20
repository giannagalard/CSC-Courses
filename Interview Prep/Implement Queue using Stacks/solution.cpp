class MyQueue {
public:
    stack<int> uno,dos; // two stacks 
    /** Initialize your data structure here. */
    MyQueue() {
    }
    
    /** Push element x to the back of queue. */
    void push(int x) {
        uno.push(x);
    }
    
    /** Removes the element from in front of queue and returns that element. */
    int pop() {
        while(!uno.empty()) {
            dos.push(uno.top());
            uno.pop();
        }
        int ret = dos.top();
        dos.pop();
        while(!dos.empty()) {
            uno.push(dos.top());
            dos.pop();
        }
        return ret;
    }
    
    /** Get the front element. */
    int peek() {
        while(!uno.empty()) {
            dos.push(uno.top());
            uno.pop();
        }
        int ret = dos.top();
        while(!dos.empty()) {
            uno.push(dos.top());
            dos.pop();
        }
        return ret;
    }
    
    /** Returns whether the queue is empty. */
    bool empty() {
        return uno.empty();
    }
};

/**
 * Your MyQueue object will be instantiated and called as such:
 * MyQueue* obj = new MyQueue();
 * obj->push(x);
 * int param_2 = obj->pop();
 * int param_3 = obj->peek();
 * bool param_4 = obj->empty();
 */