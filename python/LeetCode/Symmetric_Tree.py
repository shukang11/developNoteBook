from Structs import TreeNode

"""
对称二叉树

判断它是否是对称的

    1
   / \
  2   2
 / \ / \
3  4 4  3 -> 对称的

    1
   / \
  2   2
   \   \
   3    3 -> 非对称的
   
递归方法对比
左子树和右子树对比
"""

class Solution(object):
    def isSymmetic(self,root) -> bool:
        if not root: # 空树是对称的
             return True
        return self.symmetric(root.left, root.right)


    def symmetric(self, left, right) -> bool:
        if not left and not right: return True
        if not left or not right: return False
        return self.symmetric(left.right, right.left) and self.symmetric(left.left, right.right) and left.val == right.val
