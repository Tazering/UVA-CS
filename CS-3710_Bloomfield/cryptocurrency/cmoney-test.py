import cmoney
import sys
import subprocess
import os

def main(argv):
    print("Running Tests\n")
    name = cmoney.NAME

    if sys.argv[1] == "--all":

        print("Testing \"-name\" extension...\n")
        test_name(name)

    else: # test specific cases
        match sys.argv[1]:

            case "-name":
                test_name(name)
            case "-genesis":
                if sys.argv[2] == "T":
                    test_genesis_block(True)
                else:
                    test_genesis_block(False)
          





# testing methods

# test name
def test_name(name):
    count = 0
    totalTests = 1
    cmd_run = subprocess.Popen("python3 cmoney.py name",\
                               shell = True, stdout=subprocess.PIPE)
    
    output = cmd_run.stdout.read()
    name = name.encode('utf-8')

    if output.strip() == name:
        count += 1
        print("Test", count, "PASSED...")
        
    else:
        print("Test FAILED for \"python3 cmoney.py name\"\n")
        print("Your output:", output)
        print("Correct output:", name)

    print(count, "out of", totalTests, "tests passed...")

# genesis block
def test_genesis_block(runCommand):
    count = 0
    totalTests = 1

    if runCommand:
        cmd_run = subprocess.Popen("python3 cmoney.py genesis",\
                               shell = True, stdout=subprocess.PIPE)

    if os.path.exists("./block_0.txt"):
        count += 1
        print("Test PASSED", count, "PASSED...")
    else:
        print("Test FAILED for \"python3 cmoney.py genesis\", could not find block_0.txt\n")
    
    print(count, "out of", totalTests, "tests passed...")

# test wallet
def test_wallet_existence(fileName):

    if os.path.exists("./" + fileName):
        print("Test PASSED....")
    else:
        print("TEST FAILED...")

main(sys.argv)