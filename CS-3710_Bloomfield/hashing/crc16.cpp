#include <iostream>
#include <boost/crc.hpp>
#include <fstream>
#include <string>
#include <vector>
#include <stdlib.h>

using namespace std;
int main(int argc, char *argv[]) {

    string saltPassword(string msg, string ownMessage, string salt);
    uint16_t GetCrc16(const string& my_string);
    void outputFile(string msg, string ownMsg, string salt, int checksum);

    fstream inputFile;
    inputFile.open(argv[1]);    
    string myString = "";
    string ownMessage = "We must all suffer from one of two pains: the pain of discipline or the pain of regret.";
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



        //size salt is six
    for(int i = 32; i < asciiMax; i++) {
        for(int j = 32; j < asciiMax; j++) {

            for(int k = 32; k < asciiMax; k++) {

                for(int l = 32; l < asciiMax; l++) {
                    
                    for(int m = 32; m < asciiMax; m++) {

                        for(int n = 32; n < asciiMax; n++) {
                            char charVal1 = static_cast<char>(i);
                            char charVal2 = static_cast<char>(j);
                            char charVal3 = static_cast<char>(k);
                            char charVal4 = static_cast<char>(l);
                            char charVal5 = static_cast<char>(m);
                            char charVal6 = static_cast<char>(n);

                            string salt = "";

                            salt.push_back(charVal1);

                            //outputFile(myString, ownMessage, salt, checksum);

                            salt.push_back(charVal2);
                           // outputFile(myString, ownMessage, salt, checksum);

                            salt.push_back(charVal3);
                           // outputFile(myString, ownMessage, salt, checksum);

                            salt.push_back(charVal4);
                           // outputFile(myString, ownMessage, salt, checksum);

                            salt.push_back(charVal5);
                           // outputFile(myString, ownMessage, salt, checksum);

                            salt.push_back(charVal6);

                            outputFile(myString, ownMessage, salt, checksum);

                            }
                        
                    }

                    

                }    
            }
            
        }
    }


   
    return 0;
}

string saltPassword(string msg, string ownMessage, string salt) {
    string output = "";
    output.append(msg);
    output.append(ownMessage);
    output.append(salt);
    return output;
}

uint16_t GetCrc16(const string& my_string) {
    boost::crc_16_type result;
    result.process_bytes(my_string.data(), my_string.length());
    return result.checksum();
}

void outputFile(string msg, string ownMsg, string salt, int checksum) {
    string saltedPassword = saltPassword(msg, ownMsg, salt);

    int textHash = GetCrc16(saltedPassword);

    if(textHash == checksum) {
        ofstream outfile("output.txt");
        outfile << msg + "\n\n" + ownMsg + "\n\n" + salt << endl;

        outfile.close();
        exit(0);
    }
}



