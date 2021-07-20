class MinStack {
public:
    stack<pair<int,int>>stak;
    MinStack() { // data structure
    }
    
    void push(int val) {
        // compare input with top value of min stack then push value stack
        if(!stak.empty() && stak.top().second<val) stak.push({val,stak.top().second});
        // otherwise push current min value again into min stack so theres two same values
        else stak.push({val,val});
    }
    
    void pop() {
        stak.pop();
    }
    
    int top() {
        return stak.top().first;
    }
    
    int getMin() {
        return stak.top().second;
    }
};

/**
 * Your MinStack object will be instantiated and called as such:
 * MinStack* obj = new MinStack();
 * obj->push(val);
 * obj->pop();
 * int param_3 = obj->top();
 * int param_4 = obj->getMin();
 */