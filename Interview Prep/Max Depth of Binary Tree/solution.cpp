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
// space efficiency O(1)
class Solution {
public:
    int helper(TreeNode* root) {
        if(root == NULL) {
            return 0;
        }
        
        int left = helper(root->left);
        int right = helper(root->right);
        int maxDep = max(left, right) + 1;
        
        return maxDep;
    }
    
    int maxDepth(TreeNode* root) {
        return helper(root);
    }
};