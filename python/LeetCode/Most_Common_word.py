"""
返回一句话中出现次数最多的单词，不在禁用词列表中


"""

class Solution:
    def mostCommonWord(self, paragraph, banned):
        def cleanChar(w):
            content = "!?',;."
            for c in content:
                if c in w:
                    w = w[:-1]
                w = w.lower()
            return w

        maxcur = 0
        result = ''
        content = {}
        words = paragraph.split(' ')
        for index in range(len(words)):
            words[index] = cleanChar(words[index])
            w = words[index]
            if w not in banned:
                if w in content.keys():
                    content[w] += 1
                else:
                    content[w] = 1
                maxcur = max(maxcur, content[w])
                result = w if content[w] >= maxcur else result
        return result
        pass

if __name__ == '__main__':
    p = "Bob hit a ball, the hit BALL flew far after it was hit."
    b = ["hit"]
    s = Solution()
    result = s.mostCommonWord(p, b)
