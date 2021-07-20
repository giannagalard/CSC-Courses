// i = current index
// x = balancing string
// y = record last part of fully balanced string
class Solution {
public:
 string removeOuterParentheses(string s) {
        int x = 0,
            y = 0;
        string result = "";
        for(int i=0;i<s.length();i++)
        {
            if(s[i]=='(') x++;
            if(s[i]==')') x--;
            if(x==0) {
                result+=s.substr(y+1,i-y-1);
                y=i+1;
            }
        }
        return result;
    }
};