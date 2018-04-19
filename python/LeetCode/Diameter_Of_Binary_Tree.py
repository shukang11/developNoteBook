
from Structs import TreeNode
"""
二叉树的直径问题

给定一个二叉树，计算其直径长度，
是任意两个节点路径长度汇总的最大值，这条路径可能穿过根节点
          1
         / \
        2   3
       / \
      4   5
      
返回3，它的长度是路径[4,2,1,3] 或者 [5,2,1,3]

在递归的过程中，更新最大的左右子树深度和

"""

class Solution(object):

    def diameterOfBinaryTree(self, root):
        self.ans = 0

        def depth(p):
            if not p:
                return 0
            left, right = depth(p.left), depth(p.right)
            self.ans = max(self.ans,left+right)
            return 1+ max(left, right)
        depth(root)
        return self.ans

