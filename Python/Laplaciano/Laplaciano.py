import cv2
import numpy as np

def main():
    path = 'wolf.jpg'
    image = cv2.imread(path,0)
    height, width = image.shape
    i = np.array(image)
    x = 0
    y = 0
    img = np.zeros((height,width))
    while x<height:
        y = 0
        while y<width:
            img[x][y] = i[x][y]
            y = y+1
        x = x+1
    x = 1
    y = 1
    A = [[-1,0,-1],[0,4,0],[-1,0,-1]]
    B = np.zeros((height-2,width-2))
    p = 0
    while x<(height-1):
        y = 1
        while y<(width-1):
            k = 0
            p = 0
            while k<3:
                h = 0
                while h<3:
                    p += A[h][k] * img[x+h-1][y+k-1]
                    h = h + 1
                k = k + 1
            B[x-1][y-1] = p
            y = y + 1
        x = x + 1
    window_name = 'Laplaciano'
    cv2.imwrite('Laplaciano.jpg',B)
    r = cv2.imread('Laplaciano.jpg')
    cv2.imshow(window_name,r)
    print("Type a key to close all")
    cv2.waitKey(0)
    cv2.destroyAllWindows()


if __name__ == '__main__':
    main()
