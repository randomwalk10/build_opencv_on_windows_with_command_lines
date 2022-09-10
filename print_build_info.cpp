#include <opencv2/opencv.hpp>

int main(void)
{
	std::cout << cv::getBuildInformation() << std::endl;
	std::cout << "info printed" << std::endl;
}