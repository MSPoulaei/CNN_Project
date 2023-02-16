from PIL import Image
import numpy as np


# W = 128
# H = 128


def read(pixels,output_file):
    
    # Convert the pixels into an array using numpy
    # array = np.array(pixels)
    array = np.array(pixels, dtype='uint8')

    # print(array)

    # Use PIL to create an image from the new array of pixels
    new_image = Image.fromarray(array, 'L')
    new_image.save(output_file)
def write(res_file,output_file):
    with open(res_file,"r") as pixels_file:
        pixels=[]
        for line in pixels_file.readlines():
            pixels.append(line.replace(",\n","").replace("\n","").split(","))
        read(pixels,output_file)

write("output_results1.txt","output1.png")
write("output_results2.txt","output2.png")
write("output_results3.txt","output3.png")
