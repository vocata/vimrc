# Personal vim configaration

## Prerequisite

Use **Homebrew/Linuxbrew** to install and manager software, see [Installation](https://docs.brew.sh/Installation).

```bash
brew install \
    cmake \
    curl \
    git \
    python \
    vim
```

## How To Use

### Install vim-plug

[vim-plug](https://github.com/junegunn/vim-plug) is a powerful plugin manager designed for vim/neovim.

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Clone vim configuration

Clone this reposition to any directory, typically **$HOME** is a good choice to place configurations.

```bash
cd $HOME
git clone --depth 1 --branch main https://github.com/vocata/vimrc.git
```

Backup your own **.vimrc** file before creating a soft link to vimrc/vimrc.

```bash
ln -s vimrc/vimrc $HOME/.vimrc
```

### Install vim plugin

1. Open vim and enter command mode, then execute **:PlugInstall** to clone plugin into **.vim/plugged**.

2. [YcmCompleteMe](https://github.com/vocata/vimrc
): a code-completion engine for vim

    By default, YCM only supports python/c/c++ completer, you can install other language completers, here providing some installation instructions of common-used language completers in my daily coding. For more details, refer to [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe).

    **golang**

    Before installing golang completer, **golang** development tools must be available in current environment.
    ```bash
    berw install go
    ```

    then

    ```bash
    cd ~/.vim/plugged/YouCompleteMe
    python3 install.py --go-completer
    ```

    **rust**

    Install **rust** tool chain using homebrew

    ```bash
    brew install rust
    ```

    then

    ```bash
    cd ~/.vim/plugged/YouCompleteMe
    python3 install.py --rust-completer
    ```

3. [LeaderF](https://github.com/Yggdroot/LeaderF): an efficient fuzzy finder

    Ripgrep is a powerful command-line search tool, which can be integrated into LeaderF to implement global fuzzy search, here is repgrep installation using homebrew.


    ```bash
    brew install ripgrep
    ```

4. [ALE](https://github.com/dense-analysis/ale): asynchronous lint engine

    ALE is a lint engine noly providing functionality of linting, you must install specified language linter to enbale it, here are some common language linters and its installation.

    **python**

    Use **pylint** as linter

    ```base
    brew install pylint
    ```

    **c/c++**

    Use **clang** as linter

    ```bash
    brew install llvm
    ```

    **golang**

    Use **staticcheck** as linter

    ```bash
    brew install staticcheck
    ```

    **rust**

    Use **cargo** as linter

    ```bash
    brew install rust
    ```

    **sh/zsh**

    Use **shellcheck** as linter

    ```bash
    brew install shellcheck
    ```

    **vim**

    Use **vim-vint** as linter

    ```bash
    brew install vint
    ```

5. [vim-codefmt](https://github.com/google/vim-codefmt)

    **python** formatter

    ```bash
    brew install black
    ```

    **c/c++** formatter

    ```bash
    brew install clang-format
    ```

    **golang** formatter

    ```bash
    brew install go
    ```

    **rust** formatter

    ```bash
    brew install rustfmt
    ```

    **sh/zsh** formatter

    ```bash
    brew install shfmt
    ```
