import cv2
# count_train=7291
# count_test=2007
W = 128
H = 128


def read(file):
    bmp = cv2.imread(file)
    bmp = cv2.cvtColor(bmp, cv2.COLOR_BGR2GRAY)
    pixels = []
    for row in bmp:
        pixels2=[]
        for pixel in row:
            pixels2.append(pixel)
        pixels.append(pixels2)

    return pixels

def write(image_file,output_file):
    with open(output_file,"w") as image:
        for row in read(image_file):
            for pixel in row:
                image.write(str(pixel)+"\n")
            


write("image1.png","bits1.txt")
write("image2.png","bits2.txt")
write("image3.png","bits3.txt")