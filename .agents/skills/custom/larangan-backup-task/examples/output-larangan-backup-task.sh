// commit: 0b0b564f3f2a9b4342facd6a318b7a5c16edb9c0
# BENAR: Hanya commit file yang diperlukan
git add task.md
git commit -m "task: tandai tugas selesai"

# Versi lama via git history, bukan file .bak
git show HEAD~1:task.md
git stash
git reflog