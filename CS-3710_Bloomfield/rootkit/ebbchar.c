#include <linux/init.h> //macros used to mark up functions e.g __init __exit
#include <linux/module.h> //core header for LKM
#include <linux/device.h> //support kernel driver model
#include <linux/kernel.h> //types, macros, functions for the kernel
#include <linux/fs.h> // file operations
#include <linux/uaccess.h> // copery to user function
#define DEVICE_NAME "ebbchar" //name of the driver
#define CLASS_NAME "ebb" // class of the driver -- character device driver 

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Tyler Kim");
MODULE_DESCRIPTION("simple char driver");
MODULE_VERSION("0.1");

static int majorNumber; //used by kernel to identify which device to use
static char message[256] = {0}; 
static short size_of_message;
static int numberOpens = 0; //counts # of times device is opened
static struct class* ebbcharClass = NULL; // device-driver class struct pointer
static struct device* ebbcharDevice = NULL; //device struct pointer

// prototype functions for the character driver
static int dev_open(struct inode*, struct file*);
static int dev_release(struct inode*, struct file*);
static ssize_t dev_read(struct file*, char *, size_t, loff_t *);
static ssize_t dev_write(struct file *, const char *, size_t, loff_t *);

static struct file_operations fops = {
    .open = dev_open,
    .read = dev_read,
    .write = dev_write,
    .release = dev_release,
};

// initialization function
static int __init ebbchar_init(void) {
    printk(KERN_INFO "EBBChar: Initializing the EBBChar LKM\n");

    // dynamically allocate a major number
    majorNumber = register_chrdev(0, DEVICE_NAME, &fops);
    if (majorNumber < 0) {
        printk(KERN_ALERT "EBBChar failed to register a major number\n");
        return majorNumber;
    }
    printk(KERN_INFO "EBBChar: registered correctly with major number &d\n", majorNumber);

    //register device class
    ebbcharClass = class_create(THIS_MODULE, CLASS_NAME);
    if (IS_ERR(ebbcharClass)) {
        unregister_chrdev(majorNumber, DEVICE_NAME);
        printk(KERN_ALERT "Failed to register device class\n");
        return PTR_ERR(ebbcharClass);
    }
    printk(KERN_INFO "EBBChar: device class registered correctly\n");

    //register the device driver
    ebbcharDevice = device_create(ebbcharClass, NULL, MKDEV(majorNumber, 0), NULL, DEVICE_NAME);
    if (IS_ERR(ebbcharDevice)) {
        class_destroy(ebbcharClass);
        unregister_chrdev(majorNumber, DEVICE_NAME);
        printk(KERN_ALERT "Failed to create the device\n");
        return PTR_ERR(ebbcharDevice);
    }
    printk(KERN_INFO "EBBChar: device class created correctly\n");
    return 0;
}

// exit function
static void __exit ebbchar_exit(void) {
    device_destroy(ebbcharClass, MKDEV(majorNumber, 0)); // remove the device
    class_unregister(ebbcharClass);
    class_destroy(ebbcharClass);
    unregister_chrdev(majorNumber, DEVICE_NAME);
    printk(KERN_INFO "EBBChar: Goodbye from the LKM!\n");
}

// called each time device is opened
static int dev_open(struct inode *inodep, struct file *filep) {
    numberOpens++;
    printk(KERN_INFO "EBBChar: Device has been opened %d time(s)\n", numberOpens);
    return 0;
}

//called whenever device is being read from user space
static ssize_t dev_read(struct file *filep, char *buffer, size_t len, loff_t *offset) {
    printk(KERN_INFO "Entering the dev_read function");
    int error_count = 0;

    // (*to, *from, size)
    error_count = copy_to_user(buffer, message, size_of_message);
    //printk(KERN_INFO "the message POST: %s", message);

    if (error_count==0) {
        printk(KERN_INFO "EBBChar: Sent %d characters to the user\n", size_of_message);
        return(size_of_message=0);
    } else {
        printk(KERN_INFO "EBBChar: Failed to send %d characters to the user\n", error_count);
        return -EFAULT;
    }
}

//called whenever device is being write from user space
static ssize_t dev_write(struct file *filep, const char *buffer, size_t len, loff_t *offset) {
    int error_count = 0;

    //printk(KERN_INFO "BEFORE writing the message: %s", message);
    printk(KERN_INFO "size of the message %d", len);
    error_count = copy_from_user(message, buffer, len);
    printk(KERN_INFO "POST writing the message: %s", message);

    size_of_message = strlen(message);
    printk(KERN_INFO "EBBChar: Received %zu characters from the user\n", len);
    return len;
}

static int dev_release(struct inode *inodep, struct file *filep) {
    printk(KERN_INFO "EBBChar: Device successfully closed\n");
    return 0;
}

module_init(ebbchar_init);
module_exit(ebbchar_exit);