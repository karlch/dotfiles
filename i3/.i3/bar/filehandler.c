#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "filehandler.h"

char* filecontent(char* file)
{
    char *file_contents;
    long input_file_size;
    FILE *input_file = fopen(file, "rb");

    fseek(input_file, 0, SEEK_END);
    input_file_size = ftell(input_file);
    rewind(input_file);

    file_contents = malloc(input_file_size * (sizeof(char)));
    fread(file_contents, sizeof(char), input_file_size, input_file);

    return file_contents;
}
