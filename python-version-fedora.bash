sudo dnf install tox
sudo dnf install python36
sudo dnf downgrate python36

sudo dnf downgrade --releasever=28 python3

pip3 install tf-nightly-gpu

python3 -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"
