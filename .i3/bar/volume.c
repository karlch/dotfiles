#include <stdlib.h>
#include <string.h>
#include "filehandler.h"
#include "volume.h"

char* volstring(void)
{
    char* volcontent = filecontent("/home/christian/.i3/info/volume_info");
    char* volume = strtok(volcontent, "\n");

    char* mute = volume;
    mute = strtok(NULL, "\n");

    int m;
    if (strcmp(mute, "[off]") == 0)
        m = 0;
    else
        m = 1;

    return volume;
}
