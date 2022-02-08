#!/usr/bin/env python

from random import randint

__author__ = 'Alberto Boffi'
__date__ = '2020-12-20'

def main():

    ## Image generator ##

    ## image properties
    shift_lev = randint(0, 8)

    # generates a random delta_val based on shift_lev value
    min_delta_val = (2 ** (8 - shift_lev)) - 1
    max_delta_val = min((2 ** (8 - shift_lev + 1)) - 2, 255)
    delta_val = randint(min_delta_val, max_delta_val)

    # generates random min_px_val and max_px_val based on delta_val value
    min_px_val = randint(0, 255 - delta_val)
    max_px_val = min_px_val + delta_val

    ## image size
    width = randint(1, 128)
    if (width == 1):
        height = randint(2, 128)
    else:
        height = randint(1, 128)
    width = 5
    height = 2
    size = width * height

    ## image content
    img = []
    for i in range (size - 2):
        img.append(randint(min_px_val, max_px_val))
    # adds min_px_val & max_px_val in a random position inside the image
    img.insert(randint(0, size - 2), min_px_val)
    img.insert(randint(0, size - 1), max_px_val)

    ## Test bench file generator ##

    f = open("tb.vhd", "w").close();
    f = open("tb.vhd", "a");

    ## image size
    f.write("signal RAM: ram_type :=\n\t(0 => std_logic_vector(to_unsigned(" + str(width) + ", 8)),\n\t1 => std_logic_vector(to_unsigned(" + str(height) + ", 8)),")

    ## image content
    for i in range (size):
        f.write("\n\t" + str(i+2) + " => std_logic_vector(to_unsigned(" + str(img[i]) + ", 8)),")
    f.write("\n\tothers =>(others =>'0'));\n");

    ## new image content
    for i in range (size):
        new_px_val = min((img[i] - min_px_val) * (2 ** shift_lev), 255)
        f.write("\nassert RAM(" + str(i + size + 2) + ") = std_logic_vector(to_unsigned(" + str(new_px_val) + ", 8)) report \"TEST FALLITO (WORKING ZONE). Expected " + str(new_px_val) + " found \" & integer'image(to_integer(unsigned(RAM(" + str(i+size+2) + ")))) severity failure;")

    ## Log ##

    print ("Delta value = " + str(delta_val))
    print ("Shift level = " + str(shift_lev))

if __name__ == '__main__':
    main()
