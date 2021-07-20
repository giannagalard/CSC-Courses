/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */

// time efficiency O(n)
// space efficiency O(n)
class Solution {
public:
    bool balanced = true;
    
    int helper(TreeNode* root) {
        if(root == NULL) {
            return 0;
        }
        
        int left = helper(root->left);
        int right = helper(root->right);
        
        if(abs(right - left) > 1) {
            balanced = false;
        }
        
        return max(left, right) + 1;
    }
    bool isBalanced(TreeNode* root) {
        if(root == NULL) {
            return true;
        }
        
        helper(root);
        
        return balanced;
        
    }
};