#!/bin/bash

# Prevent script from overwriting an already existing phonebook file
if [ -f phonebook ]
then
    echo "A file named phonebook already exists; terminating"
    exit 0
fi




# Shorter than 40 --------------------------------------------------------------

echo '
----------------
Shorter than 40:
----------------
'

echo "A Cat Born In An Oven Isn't a Cake	132-9213
Alcoholics Unanimous	890-2214
Barbeque Bob and the Spare Ribs	811-3376
Biff Hitler and the Violent Mood Swings	648-9473
Buck Naked and the Bare Bottom Boys	837-9585
Full Throttle Aristotle	759-9932
JFKFC	909-6583
Manson-Nixon Line	654-8673
Me First and the Gimmee Gimmees	434-9845
Pandora's Lunch Box	121-3421
Rage Against the Coffee Machine	984-3910
REO Speed Dealer	249-1549
Shirley Temple of Doom	817-0837
Snotty Scotty and the Hankies	917-4972" > phonebook

echo '1

0
' | ./exer08.sh | grep '    .*$' | sed 's/^Enter name to look up: \(.*$\)/\1/'




# Longer than 40 --------------------------------------------------------------

echo '
---------------
Longer than 40:
---------------
'

echo "A Cat Born In An Oven Isn't a Cake	132-9213
Alcoholics Unanimous	890-2214
Barbeque Bob and the Spare Ribs	811-3376
Biff Hitler and the Violent Mood Swings	648-9473
Buck Naked and the Bare Bottom Boys	837-9585
Full Throttle Aristotle	759-9932
Gee That's A Large Beetle I Wonder If It’s Poisonous	536-8272
JFKFC	909-6583
Manson-Nixon Line	654-8673
Me First and the Gimmee Gimmees	434-9845
The Only Alternative & His Other Possibilities	878-2452
Pandora's Lunch Box	121-3421
Rage Against the Coffee Machine	984-3910
REO Speed Dealer	249-1549
Shirley Temple of Doom	817-0837
Snotty Scotty and the Hankies	917-4972
The Well I'm Sure I Left It There Yesterday Band	913-3947
Wonderbred, the Refined White Flour Children	163-2802" > phonebook

echo '1

0
' | ./exer08.sh | grep '    .*$' | sed 's/^Enter name to look up: \(.*$\)/\1/'




# Delete phonebook -------------------------------------------------------------

rm phonebook
