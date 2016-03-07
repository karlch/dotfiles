#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Returns the content of the file in a char* */
char* filecontent(char* file, int tokenize)
{
    char *file_contents;
    long input_file_size;
    FILE *input_file = fopen(file, "rb");

    fseek(input_file, 0, SEEK_END);
    input_file_size = ftell(input_file);
    rewind(input_file);

    file_contents = malloc(input_file_size * (sizeof(char)));
    fread(file_contents, sizeof(char), input_file_size, input_file);

    if (tokenize)
    {
        char* token = strtok(file_contents, "\n");
        return token;
    }
    else
        return file_contents;
}

/* Returns the current volume */
char* volume(void)
{
    char* volcontent = filecontent("/home/christian/.i3/info/volume_info", 0);
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

int main(void)
{
    char per = '%';
    char* bri = filecontent("/sys/class/backlight/acpi_video0/brightness", 1);
    char* vol = volume();
    char* bat = filecontent("/sys/class/power_supply/BAT0/capacity", 1);

    printf("BRI %s%c  VOL %s  BAT %s%c\n", bri, per, vol, bat, per);

    return 0;
}
