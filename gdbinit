set pagination off

python import sys; sys.path.insert(0, '/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/')
python from voidwalker import voidwalker

define hook-stop
    voidwalker hook-stop
end
