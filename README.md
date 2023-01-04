# Dotfile

This repo contains my collection of dot files.

## Structure

All dotfiles are stored within the `home` directory enabling the _stowing_ of everying with a single command.

## Usage

Check out the repository and use GNU Stow to symlink the files/directories to the home folder.

```
$ stow -t ~ home
```

### Removing

To remove all symlinks:

```
$ stow -t ~ -D home
```

### Using direnv for Separating Personal and Work Config Options

[direnv](https://direnv.net/) is sourced from within the `.bashrc` config file. The following is an example `.envrc` file for configuring the git username and email:

```
export GIT_AUTHOR_NAME="***"
export GIT_AUTHOR_EMAIL="***"
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
```

