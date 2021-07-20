/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */

// time complexity O(logn)
class Solution {
public:
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        // dont need to check if unique or not
        // if (root == NULL) return NULL;

        // if both nodes are smaller than the root, then recursively call the LCA function to compute on the left node of the root.
        if(p->val < root->val && q->val < root->val) return lowestCommonAncestor(root->left,p,q);
        
        // if both nodes are greater than the root, then recursively call the LCA function to compute on the right node of the root.
        else if(p->val > root->val && q->val > root->val) return lowestCommonAncestor(root->right,p,q);
        return root;
    }
};