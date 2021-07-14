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
// time complexity O(n/2)
// space complexity O(1)
class Solution {
public:
    ListNode* middleNode(ListNode* head) {
        ListNode* s = head; // initialize slow pointer as head
        ListNode* f = head; // initialize fast pointer as head
        while(f != NULL && f->next != NULL) { // loop until last node or crosses the boundary
            s = s->next; // move by one distance
            f = f->next->next; // move by two distance
        }
        return s; // middle of the linked list
    }
};