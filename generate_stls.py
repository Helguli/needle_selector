import os

# One row - one object
# Read like this:
#       upper part: 1 tooth, 2 spaces
#       lower part: 2 teeth, 1 space
# You may create your own patterns
patterns = (
        ((1,2),(2,1)),
        ((1,7),(3,1)),
        ((3,3),(2,2)),
        ((1,4),(1,5)),
        )

default_length = 24

for pattern in patterns:
    first = pattern[0]
    second = pattern[1]
    a = first[0] + first[1]
    r = default_length % a
    length = default_length - r + first[0]
    if length < default_length - 2:
        length += a
    selected1 = []
    while (len(selected1) < length):
        selected1 += [1] * first[0]
        selected1 += [0] * first[1]
    selected1 = selected1[0:length]
    print(selected1)
    b = second[0] + second[1]
    length_b = default_length - default_length % b + second[0]
    print(length)
    print(length_b)
    if length_b > length:
        length_b -= b
    diff = length - length_b

    selected2 = [0] * int(diff / 2)
    while (len(selected2) < length):
        selected2 += [1] * second[0]
        selected2 += [0] * second[1]
    selected2 = selected2[0:length]
    print(selected2)
    spikes1 = [0] * length
    spikes2 = [0] * length
    spikes1[selected1.index(1)] = 1
    spikes1[len(selected1) - 1 - selected1[::-1].index(1)] = 1
    spikes2[selected2.index(1)] = 1
    spikes2[len(selected2) - 1 - selected2[::-1].index(1)] = 1
    print(spikes1)
    print(spikes2)
    os.system("openscad -D 'selected1=" + str(selected1) +
              "' -D 'spikes1=" + str(spikes1) +
              "' -D 'selected2=" + str(selected2) +
              "' -D 'spikes2=" + str(spikes2) +
              "' -o stl/needle_selector"
              + str(first[0]) + "-" + str(first[1]) + "_"
              + str(second[0]) + "-" + str(second[1]) + "_"
              +".stl needle_selector.scad")

