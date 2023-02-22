#include <iostream>
#include <boost/crc.hpp>
#include <fstream>
#include <string>
#include <vector>

using namespace std;
int main(int argc, char *argv[]) {

    string saltPassword(string msg, string ownMessage, string salt);
    uint32_t GetCrc16(const string& my_string);

    fstream inputFile;
    inputFile.open(argv[1]);    
    string myString = "";
    string ownMessage = "We all must suffer one of two pains: the pain of discipline or the pain of regret";

    // grab the strings from the file and find the checksum
    if(inputFile.is_open()) {
        string line;

        while (getline(inputFile, line)) {
            myString = line;
        }

        inputFile.close();
    }

    //string checksum = argv[2];

    // create a salt
    int asciiMax = 128;
    string output = "";
    int checksum = stoi(argv[2], 0, 16);


        // for a salt of size one
    // for(int i = 32; i < asciiMax; i++) {
    //     char charVal0 = static_cast<char>(i);
    //     string s = "";
    //     s.push_back(charVal0);
    //     output = saltPassword(myString, ownMessage, s);
    // }

    
        // for salt of size three
    for(int i = 32; i < asciiMax; i++) {
        for(int j = 32; j < asciiMax; j++) {

            for(int k = 32; k < asciiMax; k++) {
                char charVal1 = static_cast<char>(i);
                char charVal2 = static_cast<char>(j);
                char charVal3 = static_cast<char>(k);

                string s = "";

                s.push_back(charVal1);
                s.push_back(charVal2);
                s.push_back(charVal3);

                output = saltPassword(myString, ownMessage, s);
                int code = GetCrc16(output);
                cout << s << endl;
            }

            
        }
    }
    

    // concatenate with message
    // string concatString = saltPassword(myString, ownMessage, "ABCD");

    // find the hash value

    // compare with checksum

    //write to output file


    
    return 0;
}

string saltPassword(string msg, string ownMessage, string salt) {
    string output = "";
    output.append(msg);
    output.append(ownMessage);
    output.append(salt);
    return output;
}

uint32_t GetCrc16(const string& my_string) {
    boost::crc_16_type result;
    result.process_bytes(my_string.data(), my_string.length());
    return result.checksum();
}



