clone() {
  REPO=$1
  REPO_URL="http://github.com/epeios-q37/$REPO"

  [ -d $REPO ] || ( git ls-remote -h $REPO_URL HEAD &> /dev/null && git clone $REPO_URL )
  [ -d $REPO ] && return 0
  echo "Failed to clone '$REPO'."
  return 1
}

compile() {
  REPO=$1
  BIN=$2

  [ -d $REPO ] || ( echo "Repo '$REPO' not available !!!" && return 1 )
  [ -f $REPO/$BIN ] || ( make -j 5 -C $REPO )
  [ -f $REPO/$BIN ] && return 0
  echo "Failed to compile '$REPO/$BIN'."
  return 1
}

cloneAndCompile() {
  REPO=$1
  BIN=$2
  
  clone $REPO && compile $REPO $BIN
}

cloneAndCompile faasq faasq && cloneAndCompile msfgqxdh libmsfgqxdh.so

pushd msfgqxdh
ATK=none ../faasq/faasq ./msfgqxdh
popd