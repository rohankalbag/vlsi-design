import random
no_of_testcases = 10

with open("testcases.txt", 'w') as t:
    for i in range(no_of_testcases):
        a = random.randint(0, 255)
        b = random.randint(0, 255)
        c = random.randint(0, 65536)
        s = a + b + c
        cout = 0 if (s <= 65536) else 1
        s = s & 0xFFFF
        line = str("{0:b}".format(a).zfill(8)) + str("{0:b}".format(b).zfill(8)) + str("{0:b}".format(c).zfill(16)) + " " + str(cout) + str("{0:b}".format(s).zfill(16))
        t.write(line+'\n')  