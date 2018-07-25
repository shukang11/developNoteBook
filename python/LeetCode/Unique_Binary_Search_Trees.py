"""
不同的二叉搜索树

给定一个整数n，求以1...n为节点组成的二叉搜索树有多少种


输入: 3
输出: 5
解释:
给定 n = 3, 一共有 5 种不同结构的二叉搜索树:

   1         3     3      2      1
    \       /     /      / \      \
     3     2     1      1   3      2
    /     /       \                 \
   2     1         2                 3


Tips:

BST具有以下性质：
1.若任意节点的左子树不为空，则左子树上所有的节点值均小于它的根节点值
2.若任意节点的右子树不为空，则右子树上所有的节点值均大于它的根节点值
3.任意节点的左、右子树也分别为二叉查找树
4.没有键值相等的节点


动态规划

数组为空 ： 空树 count[0] = 1
数组为1 ： 1 count[1] = 1
数组为2 ： 2 count[2] = 2  =  Count[0] * Count[1]   (1为根的情况)
                             + Count[1] * Count[0]  (2为根的情况

数组为3 ： 5 count[3] = Count[0]*Count[2]  (1为根的情况)
                       + Count[1]*Count[1]  (2为根的情况)
                       + Count[2]*Count[0]  (3为根的情况)
"""

class Solution:
    def numTrees(self, n):
        count = [0 for _ in range(n+1)]
        count[0] = 1
        count[1] = 1
        for i in range(2, n+1):
            count[i] = self.fund(count, i)
        return count[n]

    def fund(self, dp, n):
        count = 0
        for i in range(1, n+1):
            count += (dp[i-1] * dp[n-i])
        return count

if __name__ == '__main__':
    s = Solution()
    result = s.numTrees(3)
    print(result)