#include <stdio.h> 
#include <stdlib.h>
#include <string.h>

int main(void)
{
    char *file_contents;
    long input_file_size;
    FILE *input_file = fopen("/home/christian/.i3/info/volume_info", "rb");

    fseek(input_file, 0, SEEK_END);
    input_file_size = ftell(input_file);
    rewind(input_file);

    file_contents = malloc(input_file_size * (sizeof(char)));
    fread(file_contents, sizeof(char), input_file_size, input_file);

    // Erster abschnitt ist die Lautstärke
    char* volume = strtok(file_contents, "\n");
    char* mute = volume;
    mute = strtok(NULL, "\n");

    if (strcmp(mute, "[off]") == 0)
        printf("%d\n", 0);
    else
        printf("%d\n", 1);
    fclose(input_file);
    return 0;
}
