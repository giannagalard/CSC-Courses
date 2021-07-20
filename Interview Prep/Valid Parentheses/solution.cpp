// create stack to store the last valid left part of ()
// if next char is valid right , pop left

class Solution {
public:
    bool isValid(string str) {
        stack<char> s;
        for(int i = 0; i < str.size(); i++)
        {
            if(str[i]=='(' || str[i]=='{' || str[i]=='[')
                s.push(str[i]);
            else if(str[i]==')' && !s.empty() && s.top()=='(')
                s.pop();
            else if(str[i]=='}' && !s.empty() && s.top()=='{')
                s.pop();
                else if(str[i]==']' && !s.empty() && s.top()=='[')
                    s.pop();
            else
            return false;
        }
        if(s.empty())  return true;
        else return false;
    }
};