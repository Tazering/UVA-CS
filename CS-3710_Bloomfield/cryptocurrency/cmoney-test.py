import cmoney
import sys
import subprocess

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



# testing methods

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
 

    

main(sys.argv)