
"""
单例模式
"""

class Singleton(object):

    def __new__(cls):
        singleton = cls.__dict__.get('__singleton__')
        if singleton is not None:
            return singleton
        
        cls.__singleton__ = singleton = object.__new__(cls)
        return singleton

    def __setattr__(self, name, value):
        if name in (""):
            raise ValueError
        object.__setattr__(self, name, value)

if __name__ == "__main__":
    single = Singleton()
    single.name = "1"

    single2 = Singleton()
    print(single2.name)