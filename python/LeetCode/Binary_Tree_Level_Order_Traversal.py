from Structs import TreeNode

"""
给定一个二叉树，返回每层的节点值（一层一层，从左到右）

Input：
     3
   / \
  9  20
    /  \
   15   7

OutPut：
[
  [3],
  [9,20],
  [15,7]
]


Tips:

层序遍历二叉树是典型的广度优先搜索BFS的应用，但是这里稍微复杂一点的是，我们要把各个层数分开，存到一个二维向量里面

建立一个queue，先把根节点存放进去，这时候寻找左右两个子树，去掉根节点。
"""



class Solution:
    def levelOrder(self, root):
        res = []
        if not root: return res
        queue = []
        queue.append(root)
        while len(queue) != 0:
            tr = []
            nextqueue = []
            for i in range(len(queue)):
                node = queue[i]
                tr.append(node.val)
                if node.left: nextqueue.append(node.left)
                if node.right: nextqueue.append(node.right)
            res.append(tr)
            queue = nextqueue
        return res

if __name__ == '__main__':
    r = [1,3,4,5]
    while len(r) != 0:
        for i in range(len(r)):
            v = r.pop(i)
            print(i, v)