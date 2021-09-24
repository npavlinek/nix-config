(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Put custom, backups and auto save files into the temporary file directory on
;; the current system.
(let ((custom-temporary-file-directory
       (concat temporary-file-directory "emacs-tmp")))
  (setq custom-file
        (concat custom-temporary-file-directory "/custom.el"))
  (setq backup-directory-alist
        `((".*" . ,custom-temporary-file-directory)))
  (setq auto-save-file-name-transforms
        `((".*" ,custom-temporary-file-directory t))))

;; Appearance

(setq inhibit-startup-screen t)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-night t))

(column-number-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq-default indent-tabs-mode nil
              show-trailing-whitespace t
              truncate-lines t
              fill-column 80)

(setq backup-by-copying t
      version-control t
      delete-old-versions t)

(set-frame-font "Iosevka Extended-11" nil t)

(defun np/personal-c++-style ()
  (c-set-style "stroustrup"))

(add-hook 'c++-mode-hook 'np/personal-c++-style)

;; Packages

(use-package cmake-mode
  :ensure t)

(use-package ledger-mode
  :ensure t)

(use-package magit
  :ensure t)

(use-package nov
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  (setq nov-text-width 80))
