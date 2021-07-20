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
    vector<int> preorderTraversal(TreeNode* root) {
        stack<TreeNode *> stak;
        vector<int> result;
        
        if(root==NULL)  return result;
        stak.push(root);
        
        while(!stak.empty()) {
            
        TreeNode*curr = stak.top();
        stak.pop();
        result.push_back(curr->val);
       
         if(curr->right != NULL)
            stak.push(curr->right);    
        if(curr->left != NULL) 
            stak.push(curr->left);
            
        }
        
        return result;
    }
};