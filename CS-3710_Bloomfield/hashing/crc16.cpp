#include <iostream>
#include <boost/crc.hpp>
#include <fstream>
#include <string>
#include <vector>
#include <stdlib.h>

using namespace std;
int main(int argc, char *argv[]) {

    string saltPassword(string msg, string ownMessage, string salt);
    uint32_t GetCrc16(const string& my_string);
    void outputFile(int checksum, int textHash, string msg, string myMessage, string salt);

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
                outputFile(checksum, code, myString, ownMessage, s);
            }

            
        }
    }

        //size salt is four
    for(int i = 32; i < asciiMax; i++) {
        for(int j = 32; j < asciiMax; j++) {

            for(int k = 32; k < asciiMax; k++) {

                for(int l = 32; l < asciiMax; l++) {

                    char charVal1 = static_cast<char>(i);
                    char charVal2 = static_cast<char>(j);
                    char charVal3 = static_cast<char>(k);
                    char charVal4 = static_cast<char>(l);

                    string s = "";

                    s.push_back(charVal1);
                    s.push_back(charVal2);
                    s.push_back(charVal3);
                    s.push_back(charVal4);

                    output = saltPassword(myString, ownMessage, s);
                    int code = GetCrc16(output);
                    outputFile(checksum, code, myString, ownMessage, s);

                }    
            }
            
        }
    }


        //size salt is five
    for(int i = 32; i < asciiMax; i++) {
        for(int j = 32; j < asciiMax; j++) {

            for(int k = 32; k < asciiMax; k++) {

                for(int l = 32; l < asciiMax; l++) {
                    
                    for(int m = 32; m < asciiMax; m++) {
                        char charVal1 = static_cast<char>(i);
                        char charVal2 = static_cast<char>(j);
                        char charVal3 = static_cast<char>(k);
                        char charVal4 = static_cast<char>(l);
                        char charVal5 = static_cast<char>(m);

                        string s = "";

                        s.push_back(charVal1);
                        s.push_back(charVal2);
                        s.push_back(charVal3);
                        s.push_back(charVal4);
                        s.push_back(charVal5);

                        output = saltPassword(myString, ownMessage, s);
                        int code = GetCrc16(output);
                        outputFile(checksum, code, myString, ownMessage, s);
                    }

                    

                }    
            }
            
        }
    }


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

                            string s = "";

                            s.push_back(charVal1);
                            s.push_back(charVal2);
                            s.push_back(charVal3);
                            s.push_back(charVal4);
                            s.push_back(charVal5);
                            s.push_back(charVal6);

                            output = saltPassword(myString, ownMessage, s);
                            int code = GetCrc16(output);
                            outputFile(checksum, code, myString, ownMessage, s);
                        }
                        
                    }

                    

                }    
            }
            
        }
    }


            //size salt is seven
    for(int i = 32; i < asciiMax; i++) {
        for(int j = 32; j < asciiMax; j++) {

            for(int k = 32; k < asciiMax; k++) {

                for(int l = 32; l < asciiMax; l++) {
                    
                    for(int m = 32; m < asciiMax; m++) {

                        for(int n = 32; n < asciiMax; n++) {

                            for(int o = 32; o < asciiMax; o++) {
                                char charVal1 = static_cast<char>(i);
                                char charVal2 = static_cast<char>(j);
                                char charVal3 = static_cast<char>(k);
                                char charVal4 = static_cast<char>(l);
                                char charVal5 = static_cast<char>(m);
                                char charVal6 = static_cast<char>(n);
                                char charVal7 = static_cast<char>(o);

                                string s = "";

                                s.push_back(charVal1);
                                s.push_back(charVal2);
                                s.push_back(charVal3);
                                s.push_back(charVal4);
                                s.push_back(charVal5);
                                s.push_back(charVal6);
                                s.push_back(charVal7);

                                output = saltPassword(myString, ownMessage, s);
                                int code = GetCrc16(output);
                                outputFile(checksum, code, myString, ownMessage, s);
                            }
                            
                        }
                        
                    }

                    

                }    
            }
            
        }
    }

            //size salt is eight
    for(int i = 32; i < asciiMax; i++) {
        for(int j = 32; j < asciiMax; j++) {

            for(int k = 32; k < asciiMax; k++) {

                for(int l = 32; l < asciiMax; l++) {
                    
                    for(int m = 32; m < asciiMax; m++) {

                        for(int n = 32; n < asciiMax; n++) {

                            for(int o = 32; o < asciiMax; o++) {

                                for(int p = 32; p < asciiMax; p++) {
                                    char charVal1 = static_cast<char>(i);
                                    char charVal2 = static_cast<char>(j);
                                    char charVal3 = static_cast<char>(k);
                                    char charVal4 = static_cast<char>(l);
                                    char charVal5 = static_cast<char>(m);
                                    char charVal6 = static_cast<char>(n);
                                    char charVal7 = static_cast<char>(o);
                                    char charVal8 = static_cast<char>(p);

                                    string s = "";

                                    s.push_back(charVal1);
                                    s.push_back(charVal2);
                                    s.push_back(charVal3);
                                    s.push_back(charVal4);
                                    s.push_back(charVal5);
                                    s.push_back(charVal6);
                                    s.push_back(charVal7);
                                    s.push_back(charVal8);

                                    output = saltPassword(myString, ownMessage, s);
                                    int code = GetCrc16(output);
                                    outputFile(checksum, code, myString, ownMessage, s);
                                    }
                                
                            }
                            
                        }
                        
                    }

                    

                }    
            }
            
        }
    }

           //size salt is nine
    for(int i = 32; i < asciiMax; i++) {
        for(int j = 32; j < asciiMax; j++) {

            for(int k = 32; k < asciiMax; k++) {

                for(int l = 32; l < asciiMax; l++) {
                    
                    for(int m = 32; m < asciiMax; m++) {

                        for(int n = 32; n < asciiMax; n++) {

                            for(int o = 32; o < asciiMax; o++) {

                                for(int p = 32; p < asciiMax; p++) {

                                    for(int q = 32; q < asciiMax; q++) {
                                        char charVal1 = static_cast<char>(i);
                                        char charVal2 = static_cast<char>(j);
                                        char charVal3 = static_cast<char>(k);
                                        char charVal4 = static_cast<char>(l);
                                        char charVal5 = static_cast<char>(m);
                                        char charVal6 = static_cast<char>(n);
                                        char charVal7 = static_cast<char>(o);
                                        char charVal8 = static_cast<char>(p);
                                        char charVal9 = static_cast<char>(q);

                                        string s = "";

                                        s.push_back(charVal1);
                                        s.push_back(charVal2);
                                        s.push_back(charVal3);
                                        s.push_back(charVal4);
                                        s.push_back(charVal5);
                                        s.push_back(charVal6);
                                        s.push_back(charVal7);
                                        s.push_back(charVal8);
                                        s.push_back(charVal9);
                                        
                                        output = saltPassword(myString, ownMessage, s);
                                        int code = GetCrc16(output);
                                        outputFile(checksum, code, myString, ownMessage, s);
                                        
                                    }
                                    }
                                
                            }
                            
                        }
                        
                    }

                    

                }    
            }
            
        }
    }


          //size salt is ten
    for(int i = 32; i < asciiMax; i++) {
        for(int j = 32; j < asciiMax; j++) {

            for(int k = 32; k < asciiMax; k++) {

                for(int l = 32; l < asciiMax; l++) {
                    
                    for(int m = 32; m < asciiMax; m++) {

                        for(int n = 32; n < asciiMax; n++) {

                            for(int o = 32; o < asciiMax; o++) {

                                for(int p = 32; p < asciiMax; p++) {

                                    for(int q = 32; q < asciiMax; q++) {

                                        for(int r = 32; r < asciiMax; r++) {
                                        char charVal1 = static_cast<char>(i);
                                        char charVal2 = static_cast<char>(j);
                                        char charVal3 = static_cast<char>(k);
                                        char charVal4 = static_cast<char>(l);
                                        char charVal5 = static_cast<char>(m);
                                        char charVal6 = static_cast<char>(n);
                                        char charVal7 = static_cast<char>(o);
                                        char charVal8 = static_cast<char>(p);
                                        char charVal9 = static_cast<char>(q);
                                        char charVal10 = static_cast<char>(r);

                                        string s = "";

                                        s.push_back(charVal1);
                                        s.push_back(charVal2);
                                        s.push_back(charVal3);
                                        s.push_back(charVal4);
                                        s.push_back(charVal5);
                                        s.push_back(charVal6);
                                        s.push_back(charVal7);
                                        s.push_back(charVal8);
                                        s.push_back(charVal9);
                                        s.push_back(charVal10);
                                        
                                        output = saltPassword(myString, ownMessage, s);
                                        int code = GetCrc16(output);
                                        outputFile(checksum, code, myString, ownMessage, s);
                                        
                                        }
                                        
                                    }
                                    }
                                
                            }
                            
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

uint32_t GetCrc16(const string& my_string) {
    boost::crc_16_type result;
    result.process_bytes(my_string.data(), my_string.length());
    return result.checksum();
}

void outputFile(int checksum, int textHash, string msg, string myMessage, string salt) {
    if(textHash == checksum) {
        ofstream outfile("output.txt");
        outfile << msg + "\n\n" + myMessage + "\n\n\t" + salt << endl;

        outfile.close();
        exit(0);
    }
}



