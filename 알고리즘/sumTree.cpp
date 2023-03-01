class Solution
{
    public:
    
   int dfs(Node* root, bool& ans) {
       if(!root) return 0;
       if(!root->left && !root->right) return root->data;
       //divide&&conquer
       int L = dfs(root->left, ans);
       int R = dfs(root->right, ans);
       if (root->data != L+R) ans = false;
       return root->data + L + R;
   }
    
    
    bool isSumTree(Node* root)
    {
       bool ans = true;
       dfs(root, ans);
       return ans;
    }

    //높이
    int height(Node* root) {
        if(!root) return 0;
        
        return 1 + max(height(root->left), height(root->right));
    }

    //사이즈
    int size(Node* root) {
    // 기본 경우: 빈 트리의 크기는 0입니다.
    if (root == NULL) {
        return 0;
    }
    return size(root->left) + 1 + size(root->right);
}
};