#include <linux/init.h>
#include <linux/module.h> // core header for loading linus kernel modules
#include <linux/kernel.h> // contains stuff for the kernel

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Tyler");
MODULE_DESCRIPTION("simple ldb");
MODULE_VERSION("0.1");

static char *name = "world";
module_param(name, charp, S_IRUGO);
MODULE_PARM_DESC(name, "name to display in ...");


static int __init helloBBB_init(void) {
    printk(KERN_INFO "EBB: Hello %s from the BBB LKM!\n", name);
    return 0;
}

static void __exit helloBBB_exit(void) {
    printk(KERN_INFO "EBB: Goodbye %s from the BBB LKM!\n", name);
}

module_init(helloBBB_init);
module_exit(helloBBB_exit);
