(require 'json)

(let ((json-array-type 'list))
    (setq json (json-read-file "../data.json")))

(setq talks (alist-get 'talks json))
(setq publications (alist-get 'publications json))

(defun format-publication (talk-alist)
  (let ((year (alist-get 'year talk-alist))
	(journal (alist-get 'journal talk-alist))
	(title (alist-get 'title talk-alist))
	(url (alist-get 'url talk-alist))
	(arxiv (alist-get 'arxiv talk-alist)))
    (format "
<dt>%s</dt>
<dd>
  <strong>%s</strong>
  <br>%s
  <br>Available at <a href='%s'>%s</a>%s<a href='%s'>%s</a>
</dd>
" year title journal url (if url "[journal]" "") (if url ", " "") arxiv (if arxiv "[arxiv]" ""))))

(defun format-talk (talk-alist)
  (let ((title (alist-get 'title talk-alist))
	(venue (alist-get 'venue talk-alist))
	(institution (alist-get 'institution talk-alist))
	(year (alist-get 'year talk-alist))
	(website (alist-get 'website talk-alist))
	(file (alist-get 'file talk-alist)))
    (format "<dt>%s</dt>
  <dd>
    <b>%s</b> <a href='%s'>%s</a><br />
    %s <a href='static/pdfs/%s.pdf'>%s</a><br />
    %s
  </dd>" year institution website (if website "[website]" "") title file (if file "[pdf]" "") venue)))

(defun talks-dl ()
  (let ((x (mapcar 'format-talk talks)))
    (format "
<h1>Talks</h1>
<dl class='dl-horizontal'>%s</dl>" (mapconcat 'identity x "\n"))))
(talks-dl)

(defun papers-dl ()
  (let ((x (mapcar 'format-publication publications)))
    (format "
<h1>Papers</h1>
<dl class='dl-horizontal'>%s</dl>
<h3 id='essay-and-thesis'>Essay and Thesis</h3>
<dl class='dl-horizontal'>
        <dt>2015.05.01</dt>
        <dd>
            <strong>Synthetic Lie Theory</strong>
            <br>Ph.D. Thesis, Macquarie University, Sydney
            <br>After minor corrections: <a href='static/pdfs/2015-09burke-thesis.pdf'>pdf</a>
        </dd>
        <dt>2011</dt>
        <dd>
            <strong>Synthetic Differential Geometry</strong>
            <br>Part III Essay, University of Cambridge
            <br>Original: <a href='static/pdfs/2011burke.pdf'>pdf</a>
        </dd>
</dl>
" (mapconcat 'identity x "\n"))))
(papers-dl)
