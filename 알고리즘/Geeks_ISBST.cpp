int maxValue(Node* root) {
        // leaf node일때 최소값 방출해야지, 전데이터가 max로 될수있음
        if (root==NULL) return INT_MIN;
        int value = root->data;
        int leftMax = maxValue(root->left);
        int rightMax = maxValue(root->right);
        return max(value,max(leftMax, rightMax));
    }
    
    int minValue(Node* root) {
        // leaf node일때 최대값 방출해야지, 전데이터가 minVal로 될수있음
        if (root==NULL) return INT_MAX;
        int value = root->data;
        int leftMin = minValue(root->left);
        int rightMin = minValue(root->right);
        return min(value, min(rightMin, leftMin));
    }
    
    
    bool isBST(Node* root) 
    {
     if (root == NULL) {
         return true;
     }

     if (root->left != NULL && maxValue(root->left) > root->data) return false;
     if (root->right != NULL && minValue(root->right) < root->data) return false;
     
     
     if (!isBST(root->left) || !isBST(root->right)) return false;
     return true;
     
    }