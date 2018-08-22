"""
有一个以坐标为元素的列表，找出其中围城最大面积的三个点

"""
import itertools
class Solution:
    def largestTriangleArea(self, points):
        def f(p1, p2, p3):
            (x1, y1), (x2, y2), (x3, y3) = p1, p2, p3
            return 0.5*abs(x1*(y2-y3) + x2*(y3-y1) + x3*(y1-y2))
        result = 0.0
        for a,b,c in itertools.combinations(points, 3):
            print(a, b, c)
            result = max(result, f(a,b,c))
        return result



if __name__ == '__main__':
    points = [[0,0],[0,1],[1,0],[0,2],[2,0]]
    s = Solution()
    result = s.largestTriangleArea(points)
    print(result)