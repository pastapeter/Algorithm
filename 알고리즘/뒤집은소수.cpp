#include <iostream>
#include <cmath>
using namespace std;

int reverse(int x) {
    int res=0;
    while(x>0){
        int tmp = x%10;
        res = res*10 + tmp;
        x=x/10;
    }
    return res;
}

bool isPrime(int x) {
    bool res=true;
    if (x < 4) {
        if (x == 1) { return false;}
        return true;
    } 
    for(int d=2;d<sqrt(x)+1;d++){
        if (x % d ==0) return false;
    }
    return res;
}

int main() {
    int n, num, i, tmp;
    scanf("%d", &n);
    for(i=1;i<=n;i++) {
        scanf("%d", &num);
        tmp = reverse(num);
        if (isPrime(tmp)) {
            cout << "YES";
        } else {
            cout << "NO";
        }
    }
}