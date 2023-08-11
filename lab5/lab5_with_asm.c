#include <stdio.h>
#define STB_IMAGE_WRITE_IMPLEMENTATION
#define STB_IMAGE_IMPLEMENTATION
#include "include/stb_image.h"
#include "include/stb_image_write.h"
#include <time.h>

int main() {
    clock_t start_time, end_time;
    start_time = clock();
    extern void AssemblyDesaturation(unsigned char *data,unsigned char* image_data,int width, int height);
    const char *filename="kot.jpg";
    const char *filename_output="kot2.jpg";
    int width,height,channels,ok;
    unsigned char *data;
    ok = stbi_info(filename, &width, &height, &channels);
    if (ok)
        data = stbi_load(filename, &width, &height, &channels, 0);
    else{
        printf("LoadImage Error\n");
        return 0;
    }
    //создание нового изображения с одним каналом
    unsigned char* image_data = malloc( sizeof(unsigned char)*(width * height * 1));
    AssemblyDesaturation(data,image_data,width,height);
    if (stbi_write_jpg(filename_output,width,height,1,image_data,0) == 0) {
        printf("Ошибка записи в файл\n");
        free(image_data);
        stbi_image_free(data);
        return 0;
    }
    free(image_data);
    stbi_image_free(data);
    end_time = clock();
    double time_used = ((double) (end_time - start_time)) / CLOCKS_PER_SEC;
    printf("Новое изображение в файле %s\nВремя выполнения программы: %.6f сек\n",filename_output,time_used);
    return 0;
}
