from Structs import TreeNode

"""
二叉树的最大深度

思路：需要一个游标去遍历， 更新深度值   x

二叉树有左右两个子节点，还是按照递归的思路，分别取计算两边的最大深度
取较大值即可

"""

class Solution(object):

    def maxDepth(self, root: TreeNode) -> int:
        if root is None:
            return 0
        leftDepth = self.maxDepth(root.left)
        rightDepth = self.maxDepth(root.right)
        currentDepth = max(leftDepth, rightDepth)
        return currentDepth + 1