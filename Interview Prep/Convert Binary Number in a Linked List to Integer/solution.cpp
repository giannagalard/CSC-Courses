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
// space complexity O(1) -- constant
class Solution {
    public:
        int getDecimalValue(ListNode * head) {
            int result = head -> val;
            while (head -> next != NULL) { // check whats after head
                result = result * 2 + head -> next -> val; // 1 * 2 + 0 =2, 2 * 2 + 0 = 4, 4 * 2 + 1 = 9, 9 *2 + 0 = 18
                head = head -> next;
            }
            return result;
        }
};