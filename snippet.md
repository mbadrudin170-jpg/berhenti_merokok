# Terminal Linux

1. Clone branch tertentu saja
   git clone -b <nama-branch> --single-branch <url-repo>

## Proyek berhenti merokok

1. pull proyke berhenti merokok
   cd ~/berhenti_merokok && git pull
2. push github
   cd ~/berhenti_merokok && git add . && git commit -m "pesan commit" && git push
3. Pindah ke branch yang sudah ada
   git switch <nama-branch>
4. Buat branch baru lalu pindah ke sana
   git switch -c <nama-branch-baru>
5. Lihat daftar branch:
   git branch # branch lokal
   git branch -a # termasuk branch remote
6. Kembali ke branch sebelumnya:
   git switch -
