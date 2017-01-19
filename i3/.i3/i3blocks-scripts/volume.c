#include <stdio.h> 
#include <stdlib.h>
#include <string.h>

#include "concat.c"

int main(void)
{
    char *file_contents;
    char *home = getenv("HOME");
    long input_file_size;
    FILE *input_file = fopen(concat(home, "/.i3/info/volume_info"), "rb");

    fseek(input_file, 0, SEEK_END);
    input_file_size = ftell(input_file);
    rewind(input_file);

    file_contents = malloc(input_file_size * (sizeof(char)));
    fread(file_contents, sizeof(char), input_file_size, input_file);

    // Volume first
    char* volume = strtok(file_contents, "\n");
    // Then mute status
    char* mute = volume;
    mute = strtok(NULL, "\n");

    // Get any block buttons to do stuff
    char* block_button = getenv("BLOCK_BUTTON");
    int mouse_button = atoi(block_button);

    switch (mouse_button) {
        case 1:
            // Left Click
            popen(concat(home, "/.i3/volnoti-set.sh"), "r");
            break;
        case 3:
            // Right Click
            break;
        case 4:
            // Scroll Up
            popen(concat(home, "/.i3/volnoti-set.sh +"), "r");
            break;
        case 5:
            // Scroll Down
            popen(concat(home, "/.i3/volnoti-set.sh -"), "r");
            break;
    }

    if (strcmp(mute, "[on]"))
    {
        printf("<span foreground='#AFD7FF'>    </span>");
        printf("%s\n%s\n%s\n", volume, "", "#666666");
    }
    else
    {
        printf("<span foreground='#AFD7FF'>  </span>");
        printf("%s\n%s\n%s\n", volume, "", "#CCCCCC");
    }
    fclose(input_file);
    return 0;
}
