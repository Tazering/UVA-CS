import cmoney
import sys
import subprocess

def main(argv):
    print("Running Tests\n")
    name = cmoney.NAME

    if sys.argv[1] == "--all":

        print("Testing \"-name\" extension...")
        test_name(name)

    else: # test specific cases
        match sys.argv[1]:
            case "-name":
                test_name(name)



# testing methods

def test_name(name):
    cmd_run = subprocess.Popen("python3 cmoney.py name",\
                               shell = True, stdout=subprocess.PIPE)
    
    output = cmd_run.stdout.read()
    name = name.encode('utf-8')


    if output.strip() == name:
        print("Test PASSED...")
        return True
    
    print("Your output:", output)
    print("Correct output:", name)
    
    return False

main(sys.argv)