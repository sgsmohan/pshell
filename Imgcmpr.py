import cv2

import numpy as np

# Load the images

imageA = cv2.imread("image1.jpg")

imageB = cv2.imread("image2.jpg")

# Check the shape of the images

if imageA.shape != imageB.shape:

    print("The images have different shapes.")

    exit()

# Loop through the pixels

diff = 0

for i in range(imageA.shape[0]):

    for j in range(imageA.shape[1]):

        for k in range(imageA.shape[2]):

            diff += abs(imageA[i][j][k] - imageB[i][j][k])

# Calculate the average difference

average_diff = diff / (imageA.shape[0] * imageA.shape[1] * imageA.shape[2])

# Compare the average difference

threshold = 50

if average_diff < threshold:

    print("The images are similar with an average difference of", average_diff)

else:

    print("The images are different with an average difference of", average_diff)

