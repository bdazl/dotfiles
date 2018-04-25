# **TODO**

This message was sent to me, by me, as a message in this repository.
If it couldn't be more META, wait until you see what happened next.

Move this log into here, but young Padawan, format it well.

> git log -n 1 >> README.md

commit 42a18092e89d179626345aad3966b3c95091f832
Author: Jacob Peyron <jacob.peyron@gmail.com>
Date:   Wed Apr 25 10:31:44 2018 +0200

    Directory re-structure for VIM plugins (LONG MSG).
    
    I have plans to reorder all of the configurations
    such that all programs have a folder hierarchy like this:
    
    <program>/plugins/this_self
    <program>/plugins/<*plugins>
    <program>/some_small.conf
    
    The small configuration file will idealistically be
    lightweight and just point to a directory of (possibly ordered)
    scripts (or features).
    
    Examples of features:
    
    -> __vim__:
    
    * <leading>: shortcuts.
    * <C-x>: CTRL shortcuts. AKA tab management
    
    -> __ranger__:
    
    * Special directories:
        * ge (goto etc/dotfiles)
        * gj (goto src/jacob)
    * File/Folder management
        * ...
    
    -> __sway__:
    * Options:
        * window-decoration
        * shorcuts
        * login_startup (?)
    
    Okay. Too long log message. Let's put this in a README somewhere ;)
    
    Changes committed:
            modified:   ../../.gitmodules
            renamed:    Vundle.vim -> plugins/Vundle.vim
            new file:   plugins/python-mode
            modified:   vundle-bootstrap.vim
