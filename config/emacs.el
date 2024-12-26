(pixel-scroll-precision-mode 1)
(setq scroll-conservatively 101)
(display-battery-mode 1)
(setq display-time-24hr-format t)
(display-time-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(load-theme 'catppuccin :no-confirm)
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'org-mode-hook #'display-line-numbers-mode)
(setq org-confirm-babel-evaluate nil)
(set-face-attribute 'default nil :height 120)
(setq use-short-answers t)
(setq make-backup-files nil)
(setq org-export-with-broken-links t)
(setq org-src-fontify-natively t)
;; (setq org-highlight-latex-and-related '(latex script entities))
(setq warning-minimum-level :emergency)
(add-hook 'text-mode-hook 'visual-line-mode)
(and window-system (server-start))
(setq debug-ignored-errors
      (cons 'remote-file-error debug-ignored-errors))
(set-face-attribute 'default nil :font "Iosevka Nerd Font" :height 140)
(setq org-preview-latex-image-directory "/home/preston/.cache/ltximg/")

(setq-default fill-column 100)
(add-hook 'text-mode-hook #'auto-fill-mode)
(add-hook 'prog-mode-hook #'auto-fill-mode)
(add-hook 'org-mode-hook #'auto-fill-mode)

(setopt display-fill-column-indicator-column 100)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'org-mode-hook #'display-fill-column-indicator-mode)

(add-hook 'prog-mode-hook
	  (lambda ()
	    (setq prettify-symbols-alist
		  '(("lambda" . ?λ)
		    ("->"     . ?→)
		    ("map"    . ?↦)
		    ("/="     . ?≠)
		    ("!="     . ?≠)
		    ("=="     . ?≡)
		    ("<="     . ?≤)
		    (">="     . ?≥)
		    ("&&"     . ?∧)
		    ("||"     . ?∨)
		    ("sqrt"   . ?√)
		    ("..."    . ?…)))
	    (prettify-symbols-mode)))

(add-hook 'org-mode-hook (lambda ()
			   (setq prettify-symbols-alist
				 '(("#+begin_src" . ?)
				   ("#+BEGIN_SRC" . ?)
				   ("#+end_src" . ?)
				   ("#+END_SRC" . ?)
				   ("#+begin_example" . ?)
				   ("#+BEGIN_EXAMPLE" . ?)
				   ("#+end_example" . ?)
				   ("#+END_EXAMPLE" . ?)
				   ("#+header:" . ?)
				   ("#+HEADER:" . ?)
				   ("#+name:" . ?﮸)
				   ("#+NAME:" . ?﮸)
				   ("#+results:" . ?)
				   ("#+RESULTS:" . ?)
				   ("#+call:" . ?)
				   ("#+CALL:" . ?)
				   (":PROPERTIES:" . ?)
				   (":properties:" . ?)
				   ("lambda" . ?λ)
				   ("->"     . ?→)
				   ("map"    . ?↦)
				   ("/="     . ?≠)
				   ("!="     . ?≠)
				   ("=="     . ?≡)
				   ("<="     . ?≤)
				   (">="     . ?≥)
				   ("&&"     . ?∧)
				   ("||"     . ?∨)
				   ("sqrt"   . ?√)
				   ("..."    . ?…))))
	  (prettify-symbols-mode))
(global-prettify-symbols-mode 1)

(use-package unicode-fonts
  :init (unicode-fonts-setup))

(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)

(require 'org-habit)
(setq org-agenda-files (list "~/org/agenda.org"
			     "~/org/notes.org"))
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-habit-preceding-days 1)

(require 'ox-publish)
(setq org-publish-project-alist
      '(("website-org"
	 :base-directory "~/org/website"
	 :base-extension "org"
	 :publishing-directory "~/website_html"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4
	 :html-preamble t
	 :html-preamble-format (("en" "<p class=\"preamble\"><a href=\"/index.html\">home</a> | <a href=\"./index.html\">section main page</a></p><hr>")))
	("website-static"
	 :base-directory "~/org/website"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|ico"
	 :publishing-directory "~/website_html/"
	 :recursive t
	 :publishing-function org-publish-attachment)
	("website" :auto-sitemap t :components ("website-org" "website-static"))))
;; (setq org-export-html-postamble-format '(("en" "<p class=\"preamble\"><a href=\"../index.html\">previous page</a> | <a href=\"/index.html\">home</a></p>")))
(setq org-html-postamble "Copyright © 2024 Preston Pan")

(defun electric-pair ()
  "If at end of line, insert character pair without surrounding spaces.
Otherwise, just insert the typed character."
  (interactive)
  (if (eolp) (let (parens-require-spaces) (insert-pair)) (self-insert-command 1)))

(add-hook 'org-mode-hook
	    (lambda ()
	      (define-key org-mode-map "\"" 'electric-pair)
	      (define-key org-mode-map "(" 'electric-pair)
	      (define-key org-mode-map "[" 'electric-pair)
	      (define-key org-mode-map "{" 'electric-pair)))

(add-hook 'prog-mode-hook
	  (lambda ()
	      (define-key prog-mode-map "\"" 'electric-pair)
	      (define-key prog-mode-map "(" 'electric-pair)
	      (define-key prog-mode-map "[" 'electric-pair)
	      (define-key prog-mode-map "{" 'electric-pair)))
(electric-pair-mode)

(use-package lyrics-fetcher
  :after (emms)
  :config
  (setq lyrics-fetcher-genius-access-token
    (password-store-get "genius_api"))
  (lyrics-fetcher-use-backend 'genius))

(use-package org-fragtog :hook (org-mode . org-fragtog-mode))

(use-package yasnippet
  :config
  (add-to-list 'yas-snippet-dirs "~/org/website/yasnippet/")
  (yas-global-mode 1))
(add-hook 'org-mode-hook
	(lambda () (yas-minor-mode)
	    (yas-activate-extra-mode 'latex-mode)))

(eval-after-load "company" '(add-to-list 'company-backends '(company-ispell company-capf company-yasnippet company-files))) (add-hook 'after-init-hook 'global-company-mode)
(use-package ispell
  :init
  (setq ispell-program-name "aspell")
  (setq ispell-silently-savep t)
  (setq ispell-dictionary "en")
  (setq ispell-alternate-dictionary "/home/preston/.local/share/my.dict"))

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(org-babel-do-load-languages 'org-babel-load-languages
    '(
	(shell . t)
	(python . t)
	(latex . t)
    )
)

(require 'org-tempo)
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-redo))

(use-package evil-collection
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-collection-init))
(with-eval-after-load 'evil-maps
(define-key evil-motion-state-map (kbd "SPC") nil)
(define-key evil-motion-state-map (kbd "RET") nil)
(define-key evil-motion-state-map (kbd "TAB") nil))

(use-package evil-commentary
  :config
  (evil-commentary-mode))

(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package which-key
  :config
  (which-key-mode))

(use-package page-break-lines
  :init
  (page-break-lines-mode))
(evil-set-initial-state 'pdf-view-mode 'normal)

(use-package org-journal
  :after (org)
  :init
    (setq org-journal-dir "~/org/website/journal/")
    (setq org-journal-date-format "%A, %d %B %Y")

    (defun org-journal-file-header-func (time)
    "Custom function to create journal header."
    (concat
      (pcase org-journal-file-type
	(`daily "#+TITLE: Daily Journal\n#+STARTUP: showeverything\n#+DESCRIPTION: My daily journal entry\n#+AUTHOR: Preston Pan\n#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"../style.css\" />\n#+html_head: <script src=\"https://polyfill.io/v3/polyfill.min.js?features=es6\"></script>\n#+html_head: <script id=\"MathJax-script\" async src=\"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js\"></script>\n#+options: broken-links:t")
	(`weekly "#+TITLE: Weekly Journal\n#+STARTUP: folded")
	(`monthly "#+TITLE: Monthly Journal\n#+STARTUP: folded")
	(`yearly "#+TITLE: Yearly Journal\n#+STARTUP: folded"))))

  (setq org-journal-file-header 'org-journal-file-header-func)
  (setq org-journal-file-format "%Y%m%d.org")
  (setq org-journal-enable-agenda-integration t)
)

(use-package doom-modeline
  :config
  (doom-modeline-mode 1))

(use-package writegood-mode)

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (writegood-mode))))

(use-package org-superstar
  :after (org)
  :config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

(use-package eglot 
  :config
  (add-hook 'prog-mode-hook 'eglot-ensure)
  (add-to-list 'eglot-server-programs '(nix-mode . ("nil")))
  (add-hook 'prog-mode-hook 'lsp)
  :hook
  (nix-mode . eglot-ensure))

(use-package projectile
  :init
  (setq projectile-project-search-path '("~/org" "~/src"))
  :config
  (projectile-mode +1))

(use-package dashboard
  :after (projectile)
  :init
  (setq dashboard-banner-logo-title "Welcome, Commander!")
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-set-init-info t)
  (setq dashboard-week-agenda t)
  (setq dashboard-items '((recents   . 5)
		      (bookmarks . 5)
		      (projects  . 5)
		      (agenda    . 5)
		      (registers . 5)))
  :config
  (dashboard-setup-startup-hook))

(use-package counsel)
(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; enable this if you want `swiper' to use it
  ;; (setq search-default-mode #'char-fold-to-regexp)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  :config
  (ivy-mode))
(define-key ivy-minibuffer-map (kbd "C-j") 'ivy-immediate-done)

(use-package magit)

(setq
 erc-nick "prestonpan"
 erc-user-full-name "Preston Pan")

(defun prestonpan ()
  (interactive)
  (erc-tls :server "nullring.xyz"
	   :port   "6697"))

(defun liberachat ()
  (interactive)
  (erc-tls :server "irc.libera.chat"
	   :port   "6697"))

(defun matrix-org ()
  (interactive)
  (ement-connect :uri-prefix "http://localhost:8009"))

(use-package general
  :config
  (general-create-definer leader-key
    :prefix "SPC")
  (leader-key 'normal
    "o a" '(org-agenda :wk "Open agenda")
    "o c" '(org-capture :wk "Capture")
    "n j j" '(org-journal-new-entry :wk "Make new journal entry")
    "n r f" '(org-roam-node-find :wk "Find roam node")
    "n r i" '(org-roam-node-insert :wk "Insert roam node")
    "n r a" '(org-roam-alias-add :wk "Add alias to org roam node")
    "n r g" '(org-roam-graph :wk "Graph roam database")
    "r s s" '(elfeed :wk "rss feed")
    "." '(counsel-find-file :wk "find file")
    "g /" '(magit-dispatch :wk "git commands")
    "g P" '(magit-push :wk "git push")
    "g c" '(magit-commit :wk "git commit")
    "g p" '(magit-pull :wk "Pull from git")
    "g s" '(magit-status :wk "Change status of files")
    "o t" '(vterm :wk "Terminal")
    "o e" '(eshell :wk "Elisp Interpreter")
    "o m" '(mu4e :wk "Email")
    "e w w" '(eww :wk "web browser")
    "e c c" '(ellama-chat :wk "Chat with Ollama")
    "e a b" '(ellama-ask-about :wk "Ask Ollama")
    "e s" '(ellama-summarize :wk "Summarize text with Ollama")
    "e c r" '(ellama-code-review :wk "Review code with Ollama")
    "e c C" '(ellama-code-complete :wk "Complete code with Ollama")
    "e c a" '(ellama-code-add :wk "Add code with Ollama")
    "e c e" '(ellama-code-edit :wk "Edit code with Ollama")
    "e w i" '(ellama-improve-wording :wk "Improve wording with Ollama")
    "e g i" '(ellama-improve-grammar :wk "Improve grammar with Ollama")
    "g s" '(gptel-send :wk "Send to Ollama")
    "g e" '(gptel :wk "Ollama interface")
    "p w" '(ivy-pass :wk "Password manager interface")
    "m P p" '(org-publish :wk "Publish website components")
    "s e" '(sudo-edit :wk "Edit file with sudo")
    "m m" '(emms :wk "Music player")
    "m l" '(lyrics-fetcher-show-lyrics :wk "Music lyrics")
    "o p" '(treemacs :wk "Project Drawer")
    "o P" '(treemacs-projectile :wk "Import Projectile project to treemacs")
    "f f" '(eglot-format :wk "Format code buffer")
    "i p c" '(prestonpan :wk "Connect to my IRC server")
    "i l c" '(liberachat :wk "Connect to libera chat server")
    "h m" '(woman :wk "Manual")
    "h i" '(info :wk "Info")
    "s m" '(proced :wk "System Manager")
    "l p" '(list-processes :wk "List Emacs Processes")
    "m I" '(org-id-get-create :wk "Make org id")
    "y n s" '(yas-new-snippet :wk "Create new snippet")
    "u w" '((lambda () (interactive) (shell-command "rsync -azvP ~/website_html/ root@nullring.xyz:/usr/share/nginx/ret2pop/")) :wk "rsync website update")
    "h r r" '(lambda () (interactive) (org-babel-load-file (expand-file-name "~/org/website/config/emacs.org")))
    ))

(use-package ellama
  :init
  (setopt ellama-sessions-directory "/home/preston/org/ellama/")
  (require 'llm-ollama)
  (with-eval-after-load 'llm-ollama)
  (setopt ellama-provider (make-llm-ollama
	   :host "localhost"
	   :chat-model "gemma:7b")))

(use-package elfeed
  :init
  (add-hook 'elfeed-search-mode-hook #'elfeed-update)
  (setq elfeed-search-filter "@1-month-ago +unread"))
(use-package elfeed-org
  :init
  (setq rmh-elfeed-org-files '("~/org/website/config/elfeed.org"))
  :config
  (elfeed-org))

(use-package treemacs)
(use-package treemacs-evil
  :after (treemacs evil))
(use-package treemacs-projectile
  :after (treemacs projectile))
(use-package treemacs-magit
  :after (treemacs magit))

(setq search-engines
      '(
        (("google" "g") "https://google.com/search?q=%s")
        (("duckduckgo" "d" "ddg") "https://duckduckgo.com/?q=%s")
        (("rfc" "r") "https://www.rfc-editor.org/rfc/rfc%s.txt")
        (("rfc-kw" "rk") "https://www.rfc-editor.org/search/rfc_search_detail.php?title=%s")))

(setq search-engine-default "google")
(setq eww-search-prefix "https://google.com/search?q=")
(setq browse-url-secondary-browser-function 'browse-url-generic browse-url-generic-program "chromium")
(setq browse-url-browser-function 'eww-browse-url)
(add-hook 'eww-mode-hook
          (lambda () (local-set-key (kbd "y Y") #'eww-copy-page-url)))

(use-package org-roam
    :init
    (setq org-roam-db-update-on-save t)
    (setq org-roam-graph-viewer "chromium")
    (setq org-roam-directory (file-truename "~/org/website/mindmap"))
    (setq org-roam-capture-templates '(("d" "default" plain "%?"
    :target (file+head "${title}.org"
	 "#+title: ${title}\n#+author: Preston Pan\n#+html_head: <link rel=\"stylesheet\" type=\"text/css\" href=\"../style.css\" />\n#+html_head: <script src=\"https://polyfill.io/v3/polyfill.min.js?features=es6\"></script>\n#+html_head: <script id=\"MathJax-script\" async src=\"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js\"></script>\n#+options: broken-links:t")
      :unnarrowed t)))
    :config
    (org-roam-db-autosync-mode))

(use-package org-roam-ui
    :after org-roam
    :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
	  org-roam-ui-follow t
	  org-roam-ui-update-on-save t
	  org-roam-ui-open-on-start t))

(use-package pinentry
  :init (setq epa-pinentry-mode `loopback)
  :config (pinentry-start))

(setq TeX-PDF-mode t)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
(setq org-return-follows-link t)
;; (use-package latex-preview-pane
;;   :config
;;   (latex-preview-pane-enable))

;; SMTP settings:
(setq user-mail-address "preston@nullring.xyz")
(setq user-full-name "Preston Pan")
(setq sendmail-program "msmtp"
    send-mail-function 'smtpmail-send-it
    message-sendmail-f-is-evil t
    message-sendmail-extra-arguments '("--read-envelope-from")
    message-send-mail-function 'message-send-mail-with-sendmail)

(require 'smtpmail)
(use-package mu4e
  :init
  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-sent-folder   "/Sent")
  (setq mu4e-trash-folder  "/Trash")
  (setq mu4e-attachment-dir  "~/Downloads")
  (setq mu4e-view-show-addresses 't)
  (setq mu4e-confirm-quit nil)


  (setq message-kill-buffer-on-exit t)
  (setq mu4e-compose-dont-reply-to-self t)
  (setq mu4e-change-filenames-when-moving t)
  (setq mu4e-get-mail-command "mbsync prestonpan")
  (setq mu4e-compose-reply-ignore-address '("no-?reply" "ret2pop@gmail.com"))
  (setq mu4e-html2text-command "w3m -T text/html" ; how to hanfle html-formatted emails
	mu4e-update-interval 300                  ; seconds between each mail retrieval
	mu4e-headers-auto-update t                ; avoid to type `g' to update
	mu4e-view-show-images t                   ; show images in the view buffer
	mu4e-compose-signature-auto-include nil   ; I don't want a message signature
	mu4e-use-fancy-chars t))

(use-package ivy-pass)

(use-package emms
  :init
  (emms-all)
  (setq emms-source-file-default-directory (expand-file-name "~/music/"))
  (setq emms-player-mpd-music-directory (expand-file-name "~/music/"))
  (setq emms-player-mpd-server-name "localhost")
  (setq emms-player-mpd-server-port "6600")
  (setq emms-player-list '(emms-player-mpd))
  (add-to-list 'emms-info-functions 'emms-info-mpd)
  (add-to-list 'emms-player-list 'emms-player-mpd)
:config
  (emms-player-mpd-connect))

(use-package stem-mode)
(add-to-list 'auto-mode-alist '("\\.stem\\'" . stem-mode))

(server-start)
