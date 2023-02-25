#include <iostream>
#include <string>
using namespace std;

struct Node {
    Node *left, *right;
    int value;
};

class BST {
    public:
        BST():root(nullptr){};
        ~BST() {};
        void addNode(int value);
        bool searchValue(int value);
        void removeNode(int value);
        void show();

    private:
        Node *root;
        Node *tail;


        void inOrder(Node *cur) {
            if (cur != nullptr) {
                inOrder(cur -> left);
                cout << cur -> value << endl;
                inOrder(cur -> right);
            }
        }

        Node *searchMaxNode(Node *node) {
            if(node == NULL) return NULL;
            while(node -> right != NULL) {
                node = node -> right;
            }
            return node;
        }
        Node *removeSequence(Node *node, int _value);
};

void BST::addNode(int value) {
    Node *node = new Node();
    Node *tmpRoot = nullptr;

    node -> value = value;
    if(root == nullptr) root = node;
    else {
        Node *ptr = root;
        while(ptr != nullptr) {
            tmpRoot = ptr;
            if (node -> value < ptr -> value) {
                ptr = ptr->left;
            } else {
                ptr = ptr->right;
            }
        }
        if (node->value < tmpRoot->value) tmpRoot->left = node;
        else tmpRoot->right = node;

    }
}
Node* BST::removeSequence(Node *node, int _value) {
    if(node == nullptr) return node;
    else if (node->value > _value) node->left = removeSequence(node->left, _value);
    else if (node->value < _value) node->right = removeSequence(node->right, _value);
    else { //찾았어 ㅇㅇ
        Node *ptr = node;
        if(node->right == nullptr && node->left == nullptr) { //리프노드일때
            delete node;
            node = nullptr;
        } else if (node->right == nullptr) { //왼쪽에만 노드가 있음
            node = node->left; //왼쪽노드 위로 옮기기
            delete ptr;
        } else if (node->left == nullptr) {
            node = node->right;
            delete ptr;
        } else { //둘다 있을때는 왼쪽꺼에서 가장 큰놈 찾아
            // 왼쪽꺼 찾는이유는 오른쪽노드들은 무조건 왼쪽거보다 크기 떄문임
            // 왼쪽꺼 중에서 가장 큰놈을 지우려는 노드위치로 넣어줘야함 그래야지 BST가 성립함
            ptr = searchMaxNode(node->left);
            // 찾았으면 node의 값에 해당 값을 넣어줌
            node -> value = ptr -> value;
            // 노드의 왼쪽에서 해당 값을 가지고 있는 노드를 삭제함
            node -> left = removeSequence(node->left, ptr->value);
        }
    }
    return node;
}

void BST::removeNode(int value) {
    Node *ptr = root;
    removeSequence(ptr, value);
}

void BST::show() {
    Node *ptr = root;
    inOrder(ptr);
}

bool BST::searchValue(int value) {
    Node *ptr = root;
    Node *tmpRoot = nullptr;
    while(ptr != nullptr) {
        if(ptr->value == value) {
            cout << value << "Found" << endl;
            return true;
        } else if (ptr->value > value) {
            ptr = ptr->left;
        } else ptr = ptr->right;
    }
    cout << value << "not Found" << endl;
    return false;
}

int main() {
    BST *binaryTree = new BST(); // 동적할당으로 잡아준다.
    binaryTree -> addNode(1);
    binaryTree -> addNode(3);
    binaryTree -> addNode(6);
    binaryTree -> addNode(9);
    binaryTree -> addNode(13);
    binaryTree -> addNode(22);
    binaryTree -> addNode(17);
    binaryTree -> addNode(10);
    binaryTree -> addNode(2);
    binaryTree -> show(); cout << endl;
    binaryTree -> searchValue(4);
    binaryTree -> searchValue(17);
    binaryTree -> removeNode(22);

    binaryTree -> show();

    cout << endl;
    return 0;
}