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
// time complexity O(n) 
// space complexity O(1)
class Solution {
    public:
        ListNode * mergeTwoLists(ListNode* l1, ListNode* l2) {
            if (l1 == NULL) {
                return l2;
            } else if (l2 == NULL) {
                return l1;
            }
            ListNode* prev = new ListNode(); // create new pointer
            ListNode* cur = prev; // keep track of head using prev
            while (l1 != NULL && l2 != NULL) { // make sure none of them get to NULL
                // **splices the linked list**
                if (l1 -> val < l2 -> val) { // we check for smallest value
                    cur -> next = l1;
                    l1 = l1 -> next; // go to next value
                } else {
                    cur -> next = l2;
                    l2 = l2 -> next; // otherwise l2 move to next value
                }
                cur = cur -> next; 
            }
            if (l1 == NULL) { // if l1 is NULL append rest of l2 to cur
                cur -> next = l2;
            } else { // if l2 is NULL append rest of l1 to cur
                cur -> next = l1;
            }
            return prev -> next; // dont return original prev (by itself is 0 *line 6* default constructor) , 
                                 //return updated prev->next
        }
};