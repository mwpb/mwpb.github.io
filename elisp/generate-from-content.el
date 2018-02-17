(load-file "f.el")

(defun generate-page (filepath)
  (let ((html (f-read filepath 'utf-8))
	(filename (f-filename filepath)))
    (f-write (page-from-body html) 'utf-8 (format "../%s" filename))))

(defun generate-pages ()
  (mapc 'generate-page (f-files "../content")))

(generate-pages)
