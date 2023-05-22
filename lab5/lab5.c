#include <stdio.h>
#define STB_IMAGE_WRITE_IMPLEMENTATION
#define STB_IMAGE_IMPLEMENTATION
#include "include/stb_image.h"
#include "include/stb_image_write.h"
#include <time.h>
void FindMinAndMax(unsigned char red,unsigned char green,unsigned char blue, unsigned char * min, unsigned char * max){
    if (red<green){
        if (green<blue){
            *min=red;
            *max=blue;
        }
        else{
            *max=green;
            if (red<blue)
                *min=red;
            else
                *min=blue;
        }
    }
    else{
        if (red<blue){
            *min=green;
            *max=blue;
        }
        else{
            *max=red;
            if (green<blue)
                *min=green;
            else
                *min=blue;
        }
    }
}

int main() {
    clock_t start_time, end_time;
    start_time = clock();
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
    unsigned char min;
    unsigned char max;
    unsigned char* image_data = malloc( sizeof(unsigned char)*(width * height * 1));
    for (int i = 0; i < width * height * channels; i += channels) {
//        red = data[i];
//        green = data[i + 1];
//        blue = data[i + 2];
        FindMinAndMax(data[i],data[i+1],data[i+2],&min,&max);
        image_data[i/channels]=(min+max)/2;
    }
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
