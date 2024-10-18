#!/bin/bash

# 检查是否在 Git 仓库中
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "当前目录不是一个 Git 仓库"
    exit 1
fi

# 获取所有冲突文件
conflict_files=$(git diff --name-only --diff-filter=U)

# 如果没有冲突文件，退出
if [ -z "$conflict_files" ]; then
    echo "没有冲突文件"
    exit 0
fi

# 解决冲突，使用远程分支的代码
echo "正在解决冲突..."
for file in $conflict_files; do
    echo "处理文件: $file"
    git checkout --theirs "$file"
    git add "$file"
done

# 提交解决冲突后的更改
git commit -m "解决合并冲突，使用远程分支的代码"

echo "所有冲突已解决并提交"
