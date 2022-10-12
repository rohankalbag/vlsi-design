import random
no_of_testcases = 10

with open("testcases.txt", 'w') as t:
    for i in range(10):
        cin = random.randint(0, 1)
        a = random.randint(0, 65536)
        b = random.randint(0, 65536)
        s = a + b + cin
        cout = 0 if (s <= 65536) else 1
        s = s & 0xFFFF
        line = str(cin) + str("{0:b}".format(a).zfill(16)) + str("{0:b}".format(b).zfill(16)) + " " + str(cout) + str("{0:b}".format(s).zfill(16))
        t.write(line+'\n')  