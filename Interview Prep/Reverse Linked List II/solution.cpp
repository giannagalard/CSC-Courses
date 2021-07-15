/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */
class Solution {
public:
    ListNode* reverseBetween(ListNode* head, int left, int right) {
        
        if(left == right) return head; // if equal, dont have to reverse
        
        stack<int> store; // holds the left and right values in stack
        
        ListNode* prev = NULL;
        ListNode* h = head;
        int i = 1;     
        
        while( h != NULL && i<=right) { // loops until right
            if(i == left) prev = h;
            if(i >= left && i <= right) store.push(h->val); // stacks from left to right
            i++;
            h = h->next;
        }
        
       
        int plswork = store.size(); // <3
        
        for(int j = 0; j < plswork; j++) { 
            prev->val = store.top();
            store.pop();
            prev = prev->next;
        }
        
        return head;
    
    }
        
};