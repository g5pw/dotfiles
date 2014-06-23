def FlagsForFile(filename):
    return {
        'flags' : [ "-Wall",
                    "-Wpedantic",
                    "-I."],
        'do_cache' : True
        }
