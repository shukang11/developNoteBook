from Structs import TreeNode

"""
这个贼要抢劫一个二叉树的区域，如果有两个相邻的房间被打劫就会报警

     3
    / \
   2   3
    \   \ 
     3   1
能盗取的最高金额 = 3 + 3 + 1 = 7.

"""

class Solution(object):

    def rob(self, root):
        return self._rob(root)[0]
        pass

    def _rob(self, root):
        if not root:
            return [0, 0]

        left = self._rob(root.left)
        right = self._rob(root.right)

        n0 = left[1] + right[1] + root.val
        n1 = left[0] + right[0]
        return [max(n0, n1), n1]
