import hashlib
import binascii
import rsa
import sys
from datetime import datetime
# global variables
NAME = "4narchy"
ID = "t3mpest"

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
            fund(destinationWalletTag, amount, fileName)

        case "validate":
            print("TODO")

        case "balance":
            print("TODO")
        
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
    transactionMessage = "Funded wallet " + destinationWalletTag + "with " + amount + " " + NAME + "s on " + date.strftime("%a %b %d %X" + " %Z %Y")
    transactionFile = open("./" + fileName, "w")
    transactionFile.write(transactionMessage)
    print(transactionMessage)

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