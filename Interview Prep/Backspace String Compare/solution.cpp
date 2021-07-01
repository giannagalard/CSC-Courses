class Solution {
public:
    bool backspaceCompare(string s, string t) {
    stack<char> a;
        stack<char> b;
        for(char i:s){
            if(!a.empty() && i=='#'){
                a.pop();
            }
            else if(i!='#'){
                a.push(i);
            }
        }
        for(char i:t){
            if(!b.empty() && i=='#'){
                b.pop();
            }
            else if(i!='#'){
                b.push(i);
            }
        }
    return (a==b);
    }
};