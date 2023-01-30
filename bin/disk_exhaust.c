#include<fcntl.h>
#include<sys/types.h>
#include<sys/stat.h>

int main()
{
    int fd;
    char buf[10000];
    fd=open("tempfile", O_WRONLY | O_CREAT, 0777);
    unlink("./tempfile");
    while(1)
        write(fd, buf, sizeof(buf));
	return 0;
}
