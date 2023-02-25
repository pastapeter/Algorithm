#include <iostream>
#include <vector>
#include <sstream>
using namespace std;

string* split(string str, char Delimiter) {
    istringstream iss(str);
    string buffer;
    string* result;
    int index = 0;
    while (getline(iss, buffer, Delimiter)) {
        result = new string[1];
        result[index] = buffer;
        index++;
    }
    return result;
}

int main(void) { 

    int n;
    string commands[10001];
    cin >> n;
    int* queue = new int[n];
    for(int i=0;i<n;i++) {
        cin >> commands[i];
        cout << "print " << commands[i];
    }
    

}