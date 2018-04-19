from Structs import TreeNode
"""
给定一个二叉树，二叉树的每个节点含有一个整数
找出路径和等于给定数的路径总数
路径不需要从根节点开始，也不需要在叶节点结束，路径方向必须是向下的
二叉树不超过1000个节点，节点整数值的范围在[-1000000,1000000]


返回可以获得和的路径数


遍历/

在遍历的同时，以经过的节点为跟，寻找子树中和为sum的路径


"""

class Solution(object):

    def findPath(self, root, target):
        res = 0
        if not root:
            return res
        res = (root.val == target)
        res += self.findPath(root.left, target-root.val) # 寻找下一节点的时候，减去当前节点的值
        res += self.findPath(root.right, target-root.val)
        return res


    def pathSum(self, root, sum):
        if not root:
            return 0
        ans = self.findPath(root, sum)
        ans += self.pathSum(root.left, sum)
        ans += self.pathSum(root.right, sum)
        return ans