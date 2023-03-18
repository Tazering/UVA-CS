# Fuzzer skeleton code

import aiohttp, asyncio, args, sys

async def fuzz(args):
    """ 
    Fuzz a target URL with the command-line arguments specified by ``args``.
    Command Line Arguments: (string) url [2], (file) word_list [4]
    """

    #print("Numer of arguments:", len(sys.argv), "arguments.")
    #print("Argument List:", str(sys.argv))

    
   

    # open the file as read-only
    wordList = open(sys.argv[4], 'r')
    lines = wordList.readlines()


    # loop through each word in word_list
    baseURL = sys.argv[2]
    
        

    # asynchronous loading of a URL:
    async with aiohttp.ClientSession() as session:

        for line in lines:
            # replace "FUZZ" in url and test if you get an error code
            url = baseURL.replace("FUZZ", line.strip())

            async with session.get(url) as response:
                await response.text()
                status = response.status
                if status == 200:
                    print(status, url)
                #print(response.status)
                #print(response)
    
    wordList.close()
    


# do not modify this!
if __name__ == "__main__":
    arguments = args.parse_args()
    asyncio.run(fuzz(arguments))
