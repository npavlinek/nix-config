(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Put custom, backups and auto save files into the temporary file directory on
;; the current system.
(let ((custom-temporary-file-directory
       (concat temporary-file-directory "emacs-tmp")))
  (ignore-errors
    (make-directory custom-temporary-file-directory))
  (setq custom-file
        (expand-file-name "custom.el" custom-temporary-file-directory))
  (setq backup-directory-alist
        `((".*" . ,custom-temporary-file-directory)))
  (setq auto-save-file-name-transforms
        `((".*" ,custom-temporary-file-directory t))))

;; Appearance

(setq inhibit-startup-screen t)

(use-package color-theme-sanityinc-tomorrow
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

(use-package cmake-mode)

(use-package ledger-mode
  :mode "\\.ledger\\'")

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package nov
  :mode "\\.epub\\'"
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  (setq nov-text-width 80))
