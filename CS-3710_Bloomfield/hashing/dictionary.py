import sys, hashlib

def main(argv):
    #grabs the actual parameters
    dictionaryFile = open(argv[1])
    passwordFile = open(argv[2])
    salt = argv[3]

    passwordLines = passwordFile.readlines()
    dictionaryLines = dictionaryFile.readlines()


    # actual algorithm
    for line in passwordLines:
        meta = line.split(" ")
        
        for word in dictionaryLines:
            
            newWord = word[0:len(word)].strip() + salt
            m = hashlib.sha256(newWord.encode('UTF-8')).hexdigest()
            
            if m.strip() == meta[1].strip():
                print("password for " + meta[0] + " is: " + word)


main(sys.argv)