To clone on a fresh install run the following (also available in [clone.sh](./clone.sh))

```bash
git clone --bare https://github.com/ash0x0/dotfiles.git $HOME/.dotfiles
function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .dotfiles-backup
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
  else
    echo "Backing up pre-existing dot files.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
dotfiles checkout
dotfiles config status.showUntrackedFiles no
```

The above is sourced from the [Bitbucket dotfiles tutorial](https://www.atlassian.com/git/tutorials/dotfiles)
