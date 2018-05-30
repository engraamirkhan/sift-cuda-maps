# CudaSift - SIFT features with CUDA

Tested on Visual Studio 2015 with Cuda 9.1 and OpenCV 3.4.1

In build folder type:

cmake -G "Visual Studio 14 2015" ..

after the project is built can be opened in visual studio 2015 and build.
other than opencv include and linking dependency, these cudadevrt.lib
cudart.lib
cublas.lib
cublas_device.lib

needed to be added for linking.

## Usage

There are two different containers for storing data on the host and on the device; *SiftData* for SIFT features and *CudaImage* for images. Since memory allocation on GPUs is slow, it's usually preferable to preallocate a sufficient amount of memory using *InitSiftData()*, in particular if SIFT features are extracted from a continuous stream of video camera images. On repeated calls *ExtractSift()* will reuse memory previously allocated.
~~~c
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <cudaImage.h>
#include <cudaSift.h>

/* Reserve memory space for a whole bunch of SIFT features. */
SiftData siftData;
InitSiftData(siftData, 25000, true, true);

/* Read image using OpenCV and convert to floating point. */
cv::Mat limg;
cv::imread("image.png", 0).convertTo(limg, CV32FC1);
/* Allocate 1280x960 pixel image with device side pitch of 1280 floats. */ 
/* Memory on host side already allocated by OpenCV is reused.           */
CudaImage img;
img.Allocate(1280, 960, 1280, false, NULL, (float*) limg.data);
/* Download image from host to device */
img.Download();

int numOctaves = 5;    /* Number of octaves in Gaussian pyramid */
float initBlur = 1.0f; /* Amount of initial Gaussian blurring in standard deviations */
float thresh = 3.5f;   /* Threshold on difference of Gaussians for feature pruning */
float minScale = 0.0f; /* Minimum acceptable scale to remove fine-scale features */
bool upScale = false;  /* Whether to upscale image before extraction */
/* Extract SIFT features */
ExtractSift(siftData, img, numOctaves, initBlur, thresh, minScale, upScale);
...
/* Free space allocated from SIFT features */
FreeSiftData(siftData);

~~~

## Parameter setting

The requirements on number and quality of features vary from application to application. Some applications benefit from a smaller number of high quality features, while others require as many features as possible. More distinct features with higher DoG (difference of Gaussians) responses tend to be of higher quality and are easier to match between multiple views. With the parameter *thresh* a threshold can be set on the minimum DoG to prune features of less quality. 

In many cases the most fine-scale features are of little use, especially when noise conditions are severe or when features are matched between very different views. In such cases the most fine-scale features can be pruned by setting *minScale* to the minimum acceptable feature scale, where 1.0 corresponds to the original image scale without upscaling. As a consequence of pruning the computational cost can also be reduced.

To increase the number of SIFT features, but also increase the computational cost, the original image can be automatically upscaled to double the size using the *upScale* parameter, in accordings with Lowe's recommendations. One should keep in mind though that by doing so the fraction of features that can be matched tend to go down, even if the total number of extracted features increases significantly. If it's enough to instead reduce the *thresh* parameter to get more features, that is often a better alternative.

Results without upscaling (upScale=False) of 1280x960 pixel input image. 

| *thresh* | #Matches | %Matches | Cost (ms) |
|-----------|----------|----------|-----------|
|    1.0    |   4236   |   40.4%  |    5.8    |
|    1.5    |   3491   |   42.5%  |    5.2    |
|    2.0    |   2720   |   43.2%  |    4.7    |
|    2.5    |   2121   |   44.4%  |    4.2    |
|    3.0    |   1627   |   45.8%  |    3.9    |
|    3.5    |   1189   |   46.2%  |    3.6    |
|    4.0    |    881   |   48.5%  |    3.3    |


Results with upscaling (upScale=True) of 1280x960 pixel input image.

| *thresh* | #Matches | %Matches | Cost (ms) |
|-----------|----------|----------|-----------|
|    2.0    |   4502   |   34.9%  |   13.2    |
|    2.5    |   3389   |   35.9%  |   11.2    |
|    3.0    |   2529   |   37.1%  |   10.6    |
|    3.5    |   1841   |   38.3%  |    9.9    |
|    4.0    |   1331   |   39.8%  |    9.5    |
|    4.5    |    954   |   42.2%  |    9.3    |
|    5.0    |    611   |   39.3%  |    9.1    |
