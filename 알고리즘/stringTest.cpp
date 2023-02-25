#include <iostream>
#include <vector>
#include <string>
using namespace std;

vector<string> split(string input, string delimiter) {
    vector<string> ret;
    long long pos = 0;
    string token = "";
    while((pos = input.find(delimiter)) != string::npos) {
        token = input.substr(0, pos);
        ret.push_back(token);
        input.erase(0, pos + delimiter.length());
    }
    ret.push_back(input);
    return ret;
}


int main() {
    string a = "love is";
    a += " pain";
    a.pop_back();
    cout << a << " : " << a.size() << "\n";
    cout << char(*a.begin()) << '\n';
    cout << char(* (a.end()-1)) << '\n';
    a.insert(0, "test ");
    cout << a << " : " << a.size() << '\n';
    a.erase(0 ,5);
    cout << a << " : " << a.size() << "\n";
    auto it = a.find("love");
    if (it != string::npos) {
        cout << "포함되어있다." << '\n';
    }
    cout << it << '\n';
    cout << string::npos << '\n';
    cout << a.substr(5,2) << '\n';
    cout << a << '\n';
    // reverse(a.begin(), a.end());
    vector<string> b = split(a, " ");
    for(string c : b) cout << c << "\n";

    int num = 12345;
    string numstr = to_string(num);
    reverse(numstr.begin(), numstr.end());
    cout << stoi(numstr) << '\n';
    

    return 0;
}


