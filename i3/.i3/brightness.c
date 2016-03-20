#include <stdio.h> 
#include <stdlib.h>
#include <string.h>

int main(void)
{
    char *file_contents;
    long input_file_size;
    FILE *input_file = fopen("/sys/class/backlight/acpi_video0/brightness", "rb");

    fseek(input_file, 0, SEEK_END);
    input_file_size = ftell(input_file);
    rewind(input_file);

    file_contents = malloc(input_file_size * (sizeof(char)));
    fread(file_contents, sizeof(char), input_file_size, input_file);

    // Erster abschnitt ist die Lautstärke
    char* brightness = strtok(file_contents, "\n");

    printf("%s\n", brightness);
    fclose(input_file);
    return 0;
}
