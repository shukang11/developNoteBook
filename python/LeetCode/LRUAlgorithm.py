"""
LRU 缓存淘汰算法

Least Recently Used （最近最少使用）

如果一块数据最近被访问，那么它将来被访问到的概率也很高，根据数据的访问历史来淘汰长时间未使用的数据
"""


class CacheNode:

    def __init__(self, val, prev, next):
        """
        双向链表
        :param val: 当前值
        :param prev: 向前引用 如果没有的话，说明是第一个
        :param next: 向后引用 如果没有的话，说明是最后一个
        """
        if val is None:
            raise ValueError('val must has a value')
        self.val = val
        self.prev = prev
        self.next = next


class SSSimpleCache:

    kLOTCacheSize = 5

    def __init__(self):
        self.valuesCache = {}
        self.lruOrderArray = []

    def addValue(self, value, key):
        if len(self.lruOrderArray) > self.kLOTCacheSize: # 超过了最大缓存数
            oldKey = self.lruOrderArray.pop(0)
            # 移除旧的
            del self.valuesCache[oldKey]
        if  key in self.lruOrderArray:
            self.lruOrderArray.remove(key)
        self.lruOrderArray.append(key)
        self.valuesCache.update({key: value})


    def valueForKey(self, key):
        if not key:
            return None
        value = self.valuesCache.get(key)
        self.lruOrderArray.remove(key)
        self.lruOrderArray.append(key)
        return value

    def clearCache(self):
        self.lruOrderArray = []
        self.valuesCache = {}

    def removeValue(self, key):
        if not key:
            return
        self.lruOrderArray.remove(key)
        del self.valuesCache[key]

if __name__ == '__main__':
    cache = SSSimpleCache()
    cache.addValue('11', '1')
    cache.addValue('22', '2')
    cache.addValue('33', '3')
    cache.addValue('44', '4')
    cache.addValue('55', '5')
    cache.addValue('66', '6')
    cache.addValue('66', '6')
    cache.addValue('55', '5')
    cache.addValue('66', '6')
    cache.addValue('77', '7')
    cache.addValue('66', '6')
    value = cache.valueForKey('7')
    print(cache.lruOrderArray)