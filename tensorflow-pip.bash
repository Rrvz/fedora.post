# for fedora29 python 3.7 support
pip3 install tf-nightly-gpu --user

# for python2 and 3.6
pip3 install tensorflow-gpu --user

# libraries
pip3 install graphviz pydot --user


# execute code

python3 -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"


