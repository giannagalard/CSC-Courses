/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
// time complexity O(n)
// space complexity O(1)
class Solution {
    public:
        bool hasCycle(ListNode * head) {
            if(head == NULL) return false; // in constraints range [0,10^4] 
            ListNode* s = head;
            ListNode* f = head -> next;
            while (f != NULL && f -> next != NULL) {
                if (s == f) {
                    return true;
                }
                s = s -> next;
                f = f -> next -> next;
            }
            return false;
        }
};