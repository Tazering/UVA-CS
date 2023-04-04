import hashlib
import binascii
import rsa
import sys
from datetime import datetime
import os
import fnmatch

# global variables
NAME = "4narchy"
ID = "t3mpest"
currentBlockID = 0

# user balance dictionary
userBalanceDict = {}

# main method
def main(argv):

    match argv[1]:
        case "name": # get the name of the cryptocurrency
            print(NAME)

        case "genesis": # make a genesis block
            make_genesis_block()

        case "generate": # generates a wallet
            fileName = argv[2]
            generate_wallet(fileName)
        
        case "address": # grab the tag
            fileName = argv[2]
            print(get_tag_of_file(fileName))
        
        case "fund": # funding
            destinationWalletTag = argv[2]
            amount = argv[3]
            fileName = argv[4]

            # ask about id with hash of public
            fund(destinationWalletTag, amount, fileName)
        
        case "transfer": # transfer money
            sourceFileName = argv[2]
            destinationWalletTag = argv[3]
            amount = argv[4]
            transactionFile = argv[5]

            transfer(sourceFileName, destinationWalletTag, amount, transactionFile)

        case "balance": # balance function
            walletTag = argv[2]
            print(balance(walletTag))
        
        case "verify": # verify if tag has enough money
            walletFileName= argv[2]
            transactionStatement = argv[3]
            verify(walletFileName, transactionStatement)
        
        case "mine": # mine the block
            leadingZeros = argv[2]
            mine(leadingZeros)

        case "validate":
            print(validate())

        case default:
            print("")

# make genesis block
def make_genesis_block():
    
    # open the new file and add some fun quote
    genesisBlock = open("./block_0.txt", "w")
    genesisBlock.write("We must all suffer from one of two pains: the pain of discipline or the pain of regret. The difference is discipline weighs ounces while regret weight tons.\n- Jim Rohn")
    
    print("Genesis block created in \'block_0.txt\'")

# generates a wallet
def generate_wallet(fileName):
    # create key set "wallet"
    (publicKey, privateKey) = rsa.newkeys(1024)

    # save into wallet file
    saveWallet(publicKey, privateKey, fileName)
    
    # grab tag of file
    tag = get_tag_of_file(fileName)

    print("New wallet generated in \'", fileName, "\' with tag", tag)

# grab tag
def get_tag_of_file(fileName):
    (pubKey, privKey) = loadWallet(fileName)

    derFile = pubKey.save_pkcs1("DER")
    tag = hashlib.sha256(derFile).hexdigest()

    return tag[0:16]

# funding
def fund(destinationWalletTag, amount, fileName):
    date = datetime.now()
    transactionLine = "Funded wallet " + destinationWalletTag + "with " + amount + " " + NAME + "s on " + formatDate(date)

    sourceLine = "From: " + ID
    destLine = "To: " + destinationWalletTag
    amountLine = "Amount: " + amount
    dateLine = "Date: " + formatDate(date)
    transactionStatement = sourceLine + "\n" + destLine + "\n" + amountLine + "\n" + dateLine + "\n"

    transactionFile = open("./" + fileName, "w")
    transactionFile.write(transactionStatement)
    print(transactionLine)

# transfer money
def transfer(sourceFileName, destinationTag, amount, transactionFile):
    date = datetime.now() # grab date
    (pubkey, privkey) = loadWallet(sourceFileName)

    # output message
    transactionLine= "Transferred " + amount + " from "  + sourceFileName + " to " + destinationTag + " and the statement to \'" + transactionFile + "\' on " + formatDate(date)
    
    # write to file
    sourceLine = "From: " + get_tag_of_file(sourceFileName)
    destLine = "To: " + destinationTag
    amountLine = "Amount: " + amount
    dateLine = "Date: " + formatDate(date)
    transactionStatement = sourceLine + "\n" + destLine + "\n" + amountLine + "\n" + dateLine + "\n\n"

    # signature
    signature = rsa.sign(transactionStatement.encode(), privkey, "SHA-256")
    stringSignature = binascii.hexlify(signature).decode()

    transactionStatement = transactionStatement + stringSignature

    file = open("./" + transactionFile, "w")
    file.write(transactionStatement)

    print(transactionLine)

# balance
def balance(walletTag):
    # look through block chain
    blockNumber = 1
    filename = "block_1.txt"
    
    while(True):

        filename = "block_" + str(blockNumber) + ".txt"

        if os.path.exists("./" + filename):
        
            record_transactions(filename)

        else: 
            break

        blockNumber+= 1
    
    # look through the mempool
    try: 
        record_transactions("mempool.txt")
    except: 
        file = open("./mempool.txt", "w")
    
    return userBalanceDict[walletTag] if walletTag in userBalanceDict else 0

    # look through mempool

# transactions recorder
def record_transactions(fileName):
    file = open(fileName, "r")
    lines = file.readlines()
    file.close()
    
    for line in lines:
        line = line.split(" ")

        if len(line) < 3:
            continue

        source = line[0]
        amount = int(line[2])
        destination = line[4]

        # source
        if source != ID:
            if source in userBalanceDict:
                userBalanceDict[source] -= amount
            else:
                userBalanceDict[source] = 0 - amount
        
        # destination
        if destination != ID:
            if destination in userBalanceDict:
                userBalanceDict[destination] += amount
            else:
                userBalanceDict[destination] = amount

# verify if funds are enough AND check signature
def verify(sourceFileName, transactionStatement):
    file = open(transactionStatement, "r")
    lines = file.readlines()
    (pubKey, privKey) = loadWallet(sourceFileName)

    # grab source and amount
    source = lines[0].split(" ")[1].strip()
    amount = lines[2].split(" ")[1].strip()
    hashValue = lines[-1]
    destination = lines[1].split(" ")[1].strip()
    date = lines[3].split(": ")[1].strip()

    if source == ID:
        return 

    statement = lines[0] + lines[1] + lines[2] + lines[3] + lines[4]

    signature = hashValue.encode("ascii")
    signature = stringToBytes(signature)

    # verify signature and funds

    try: 

        transactionLine = get_tag_of_file(sourceFileName) + " transferred " + amount + " to " + destination + " on " + date

        if balance(get_tag_of_file(sourceFileName)) >= int(amount) and rsa.verify(statement.encode("ascii"), signature, pubKey) == "SHA-256": # signature verification
            file = open("./mempool.txt", "r")
            lines = file.readlines()

            try:
                file = open("./mempool.txt", "a")

                if len(lines) == 0:
                    file.write(transactionLine)
                else:
                    file.write("\n" + transactionLine)
                file.close()

            except FileNotFoundError:
                file = open("./mempool.txt", "w")
                file.write(transactionLine)
                file.close()
             # write to mempool
            
            print("The transaction in file \'" + transactionStatement + "\' with wallet \'" + sourceFileName + "\' is valid, and was written to the mempool")
        
    except rsa.VerificationError:
        
        return

# mining
def mine(difficulty):
    # empty mempool into current block
    blockId = findNextBlock()

    blockName = "block_" + str(blockId) + ".txt"

    file = open("mempool.txt", "r")
    lines = file.readlines()
    file.close()

    file = open("mempool.txt", "w")
    file.truncate()
    file.close()

    nonce = -1

    # create the block
    prevHash = hashFile("block_" + str(blockId - 1) + ".txt") + "\n"
    with open("tempBlock.txt", "w") as file:
        file.write(prevHash)
        file.write("\n")
        for line in lines:
            file.write(line)
        file.write("\n\n")
        file.write("nonce: " + str(nonce))
    file.close()       

    # read from file
    file = open("tempBlock.txt", "r")
    lines = file.readlines()
    file.close()

    testString = ""
    for i in range(int(difficulty)):
        testString = testString + "0"
    
    # loop until hash is has enough leading zeroes
    while(True):

        nonce += 1
        lines[len(lines) - 1] = "nonce: " + str(nonce)

        # rewrite to file
        file = open("tempBlock.txt", "w")
        for line in lines:
            file.write(line)
        file.close()
    
        # get hash of file
        hashWithNonce = hashFile("tempBlock.txt")
        
        # check if has enough leading zeroes
        if hashWithNonce[0:int(difficulty)] == testString:
            print(hashWithNonce)
            
            file = open("tempBlock.txt", "r")
            lines = file.readlines()
            file.close()

            with open(blockName, "w") as file:
                file.write(prevHash)
                file.write("\n")
                for line in lines:
                    file.write(line)
                file.write("\n\n")
                file.write("nonce: " + str(nonce))
            file.close()
            
            break


    print("Mempool transactions moved to " + blockName + " and mined with difficulty " + str(difficulty) + " and nonce " + str(nonce))
# validating
def validate():
    blockID = 1

    while(True):

        try:
            prevHash = hashFile("block_" + str(blockID - 1) + ".txt")
            fileName = "block_" + str(blockID) + ".txt"
            file = open(fileName, "r")
            lines = file.readlines()

            if prevHash != lines[0]:
                return False
            blockID += 1

        except FileNotFoundError:
            return True

# find most recent block made
def findNextBlock():
    blockID = 0
    
    while(True):
        if os.path.exists("block_" + str(blockID) + ".txt"):
            blockID+=1
            continue
        else:
            return blockID

# helper 
# format date
def formatDate(date):
    return date.strftime("%a %b %d %X") + " EDT " + date.strftime("%Y")

# gets the hash of a file; from https://stackoverflow.com/a/44873382
def hashFile(filename):
    h = hashlib.sha256()
    with open(filename, 'rb', buffering=0) as f:
        for b in iter(lambda : f.read(128*1024), b''):
            h.update(b)
    return h.hexdigest()

# given an array of bytes, return a hex reprenstation of it
def bytesToString(data):
    return binascii.hexlify(data)

# given a hex reprensetation, convert it to an array of bytes
def stringToBytes(hexstr):
    return binascii.a2b_hex(hexstr)

# Load the wallet keys from a filename
def loadWallet(filename):
    with open(filename, mode='rb') as file:
        keydata = file.read()
    privkey = rsa.PrivateKey.load_pkcs1(keydata)
    pubkey = rsa.PublicKey.load_pkcs1(keydata)
    return pubkey, privkey

# save the wallet to a file
def saveWallet(pubkey, privkey, filename):
    # Save the keys to a key format (outputs bytes)
    pubkeyBytes = pubkey.save_pkcs1(format='PEM')
    privkeyBytes = privkey.save_pkcs1(format='PEM')
    # Convert those bytes to strings to write to a file (gibberish, but a string...)
    pubkeyString = pubkeyBytes.decode('ascii')
    privkeyString = privkeyBytes.decode('ascii')
    # Write both keys to the wallet file
    with open(filename, 'w') as file:
        file.write(pubkeyString)
        file.write(privkeyString)
    return


main(sys.argv)