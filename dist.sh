set -ex

dist() {
  cd $1
  ncu -u
  pnpm i
  ./dist.sh
  cd ..
}

dist vbyte
dist is-change
dist nt
dist replace_n
dist title-case
dist tran_md
dist i18n
dist i18n-bin
