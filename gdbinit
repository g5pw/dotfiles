set pagination off

set history save on
set history expansion on
set history filename ~/.gdb_history

python import sys; sys.path.insert(0, '/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/')
python from voidwalker import voidwalker

define hook-stop
    voidwalker hook-stop
end
