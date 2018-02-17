(load-file "f.el")
(load-file "generate-html.el")
(load-file "generate-site.el")

(f-write (page-from-body (talks-dl)) 'utf-8 "../talks.html")
(f-write (page-from-body (papers-dl)) 'utf-8 "../papers.html")
