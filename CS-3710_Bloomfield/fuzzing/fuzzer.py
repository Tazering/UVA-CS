# Fuzzer skeleton code

import aiohttp, asyncio, args, sys

async def fuzz(args):
    """ 
    Fuzz a target URL with the command-line arguments specified by ``args``.
    Command Line Arguments: (string) url [2], (file) word_list [4]
    """

    #print("Numer of arguments:", len(sys.argv), "arguments.")
    #print("Argument List:", str(sys.argv))
    
    #needed variables
    baseURl = ""
    wordListName = ""
    extensions = [""]
    methodType = "GET"
    headersDict = {}
    data = None
    matchCodes = []
    defaultMatchCodes = [200, 301, 302, 401, 403]


    # extract all arguments based on their extensions
    for i in range(1, len(sys.argv)):
        argString = sys.argv[i]
        extensionType = handle_extensions(argString)
        match extensionType:
            case "url": #url
                i += 1
                baseURL = sys.argv[i]
                continue

            case "wordlist": # wordlist
                i += 1
                wordListName = sys.argv[i]
                continue

            case "extension":
                i += 1
                extensions.append("." + sys.argv[i])
                continue

            case "method":   
                i += 1
                methodType = sys.argv[i].upper()
                continue

            case "header":
                i += 1
                strArr = sys.argv[i].split(": ")
                headersDict[strArr[0]] = strArr[1]
                continue

            case "data":
                i+=1
                body = sys.argv[i]
                continue

            case "matchcode":
                i += 1
                matchCodes.append(int(sys.argv[i]))
                continue         

            case default:
                continue

    #open word list
    wordList = open(wordListName, 'r')
    lines = wordList.readlines()

    # open client session
    async with aiohttp.ClientSession() as session:
        newURL = ""

        for line in lines: # loops through each line in the text
            
            for i in extensions: # go through extensions
                newString = line + i
                newURL = baseURL.replace("FUZZ", newString.strip())

                # asynchronous loading of a URL:
                async with aiohttp.request(method = methodType, url = newURL, headers = headersDict if len(headersDict) != 0 else None, data = data) as response:
                
                    # replace "FUZZ" in url
                    await response.text()
                    status = response.status

                    if len(matchCodes) == 0:
                        if status in defaultMatchCodes:
                            print(status, newURL)
                    else:
                        if status in matchCodes:
                            print(status, newURL)
                

    wordList.close()

# handle the extensions
def handle_extensions(argString):
    if argString == "-u" or argString == "--url":
        return "url"
    elif argString == "-w" or argString == "--wordlist":
        return "wordlist"
    elif argString == "-e" or argString == "--extension":
        return "extension"
    elif argString == "-X" or argString == "--method":
        return "method"
    elif argString == "-H" or argString == "--header":
        return "header"
    elif argString == "-d" or argString == "--data":
        return "data"
    elif argString == "-mc":
        return "matchcode"
    
    return ""



# do not modify this!
if __name__ == "__main__":
    arguments = args.parse_args()
    asyncio.run(fuzz(arguments))


