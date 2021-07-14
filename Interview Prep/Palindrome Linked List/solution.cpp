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
    
    bool isPalindrome(ListNode* head) {
        ListNode* s = head;
        ListNode* f = head;
        
        ListNode* next = NULL;
        ListNode* prev = NULL;
        
        if(head == NULL || head->next == NULL) return true;
        
        while(true) {
            f = f->next->next;
            next = s->next;
            s->next = prev;
            prev = s;
            
            if(f == NULL) break;
            
            if(f->next == NULL) {
                next = next->next;
                break;
            }
            s = next;
        }
        
        while(s != NULL) {
            if(s->val != next->val) return false;
            s=s->next;
            next = next->next;   
        }
        
        return true;
    }
    
};