from PIL import Image
import numpy as np
import scipy.misc

key1 = np.array(Image.open('key1.bmp'))
key2 = np.array(Image.open('key2.bmp'))
key3 = np.array(Image.open('key3.bmp'))
key4 = np.array(Image.open('key4.bmp'))
flag = np.array(Image.open('life.bmp'))
a = np.zeros(160000*3).reshape(400,400,3)

for i in range(400):
    for j in range(400):
        a[i][j] = key1[i][j]^key2[i][j]^key3[i][j]^key4[i][j]^flag[i][j]
        
im = Image.fromarray(np.uint8(a))
im.save('你的人生一團糟.bmp')