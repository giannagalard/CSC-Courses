class Solution {
public:
// iterative approach 
    // create a pointer @ start 
    // create second pointer @ end
    // swap characters using pointers 
        // midpoint = successful reverse
    void reverseString(vector<char>& s) {
    int x = 0,
        y = s.size() -1;
        
        while(x < y) {
            char c = s[x];
            s[x] = s[y];
            s[y] = c;
            x++;
            y--;
        }
    }
};