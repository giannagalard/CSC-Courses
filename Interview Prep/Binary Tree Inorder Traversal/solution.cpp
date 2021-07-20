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

class Solution {
public:
    
    void inorder_imp(TreeNode* root, vector<int>& inorder) {
        
        if(root == NULL) {
            return;
        }
        inorder_imp(root->left, inorder);
        inorder.push_back(root->val);
        inorder_imp(root->right, inorder);
        
    }
    
    vector<int> inorderTraversal(TreeNode* root) {
        
        vector<int> inorder;
        
        if(root == NULL) {
            return inorder;
        }
        
        inorder_imp(root, inorder);
        
        return inorder;
        
    }
};