#include<bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef unsigned long long ull;
#define forn(i, n) for (ll i = 0; i < ll(n); i++)
#define form(i, n) for (ll i = 1; i <= ll(n); i++)
#define cin(a,n) forn(i,n) cin >> a[i]
#define cout(a,n) forn(i,n) cout << a[i] << ' '
#define FastIO ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0)
#define all(a) a.begin(), a.end()
#define rall(a) a.rbegin(), a.rend()
#define yes "YES"
#define no "NO"
#define yn(b) cout<<(b?yes:no)<<'\n'
#define pb push_back

const int oo = 1000000010;
const int N = 200010;

// Function to convert decimal to two's complement
std::bitset<32> dec_to_bin(int decimal) {
    std::bitset<32> binary; // Initialize a bitset to hold the binary representation

    // If the decimal number is negative
    if (decimal < 0) {
        // Convert the absolute value of the decimal to binary
        binary = std::bitset<32>(-decimal);
        // Invert all bits
        binary = ~binary;
        // Add 1
        binary = (binary.to_ulong() + 1);
    } else {
        // If decimal is positive, its two's complement is the same as the binary representation
        binary = std::bitset<32>(decimal);
    }

    return binary;
}

// Function to convert binary to hexadecimal
std::string bin_to_hex(std::bitset<32> binary) {
    std::stringstream hex_stream;
    hex_stream << std::hex << std::uppercase << binary.to_ulong();
    return hex_stream.str();
}

// Function to convert decimal to hexadecimal
std::string dec_to_hex(int decimal) {
    std::bitset<32> binary = dec_to_bin(decimal);
    return bin_to_hex(binary);
}

string func(string x){
    //if last character is comma then remove it
    if(x[x.size()-1] == ',') x.pop_back();

    //convert x to number
    int n = stoi(x);

    //convert n to hex
    string hex = "32'h";
    hex += dec_to_hex(n);

    //return hex
    return hex;

}

int func2(string x){
    //if last character is comma then remove it
    if(x[x.size()-1] == ',') x.pop_back();

    //convert x to number
    int n = stoi(x);

    return n;
}

void memory_maker(vector<string> v){
    int n = v.size();

    int max = n*4;

    for(int i = 0; i < n; i++){
        cout << "{";
        cout << "memory[" << 4*i+3 << "]" << ",";
        cout << "memory[" << 4*i+2 << "]" << ",";
        cout << "memory[" << 4*i+1 << "]" << ",";
        cout << "memory[" << 4*i << "]" << "}";
        cout << " = ";
        cout << std::hex << v[i] << std::dec << ";" << std::endl;
    }
}

void solve() {
    string x;
    vector<string> v;
    vector<int> a;
    while(cin >> x) {
        a.pb(func2(x));
        v.pb(func(x));
    }

    memory_maker(v);
}

int main(void) {
    FastIO;
#ifndef ONLINE_JUDGE
    freopen("input.text.txt", "r", stdin);
    freopen("output.txt.txt","w",stdout);
#endif
    int t = 1;
    //cin >> t;
    while (t--) {
        solve();
    }
    return 0;
}
