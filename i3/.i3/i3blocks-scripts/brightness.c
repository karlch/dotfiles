#include <stdio.h> 
#include <stdlib.h>
#include <string.h>

#include "concat.c"

int main(void)
{
    char *file_contents;
    char *home = getenv("HOME");
    char *brightness_script = concat(home, "/.i3/brightness-show.sh");
    long input_file_size;
    FILE *input_file = fopen("/sys/class/backlight/acpi_video0/brightness", "rb");

    fseek(input_file, 0, SEEK_END);
    input_file_size = ftell(input_file);
    rewind(input_file);

    file_contents = malloc(input_file_size * (sizeof(char)));
    fread(file_contents, sizeof(char), input_file_size, input_file);

    // First section is the brightness
    char* brightness = strtok(file_contents, "\n");
    int bri = atoi(brightness);

    // Get any block buttons to do stuff
    char* block_button = getenv("BLOCK_BUTTON");
    int mouse_button = atoi(block_button);

    switch (mouse_button) {
        case 1:
            // Left Click
            popen(concat("sudo xbacklight -set 30 && ", brightness_script), "r");
            break;
        case 2:
            // Middle Click
            popen(concat("sudo xbacklight -set 50 && ", brightness_script), "r");
            break;
        case 3:
            // Right Click
            popen(concat("sudo xbacklight -set 70 && ", brightness_script), "r");
            break;
        case 4:
            // Scroll Up
            popen(concat("sudo xbacklight -inc 5 -time 0 -steps 1  && ", brightness_script), "r");
            break;
        case 5:
            // Scroll Down
            popen(concat("sudo xbacklight -dec 5 -time 0 -steps 1  && ", brightness_script), "r");
            break;
    }

    printf("<span foreground='#AFD7FF'>  </span>");
    printf("%d\n", bri);
    fclose(input_file);
    return 0;
}
