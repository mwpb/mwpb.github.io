(load-file "f.el")

(setq bootstrap-css (f-read "../_includes/bootstrap/css/bootstrap.min.css" 'utf-8))
(setq bootstrap-js (f-read "../_includes/bootstrap/js/bootstrap.min.js" 'utf-8))
(setq jquery (f-read "../_includes/jquery.min.js" 'utf-8))

(defun page-from-body(body)
  (format "<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <meta http-equiv='X-UA-Compatible' content='ie=edge'>
  <style>%s</style>
<style>body {
    padding-top: 50px;
    padding-bottom: 20px;
}

/* Wrapping element */
/* Set some basic padding to keep content from hitting the edges */
.body-content {
    padding-left: 15px;
    padding-right: 15px;
}

input,
select,
textarea {
    max-width: 280px;
}

/* Carousel */
.carousel-caption p {
    font-size: 20px;
    line-height: 1.4;
}

/* Make .svg files in the carousel display properly in older browsers */
.carousel-inner .item img[src$='.svg']
{
    width: 100;
}
/* Hide/rearrange for smaller screens */
@media screen and (max-width: 767px) {
  /* Hide captions */
  .carousel-caption {
    display: none
  }
}
* {
  margin-right: auto;
  margin-left: auto;
  max-width: 800px; /* or 950px */
}
html {
    overflow-y:scroll;
}
p{
    margin: auto;
    padding-bottom: 30px;
    max-width: 75ch;
    text-align:justify;
}
.contact-dl{
    margin: auto;
    max-width: 75ch;
}
h1, h2, h3, h4 {
    text-align: center;
}
h1 {
    padding-top:30px;
    padding-bottom:30px;
}
h2 {
    padding-bottom:20px;
}
h3 {
    padding-bottom:10px;
}
.table th {
    border-top:none !important;
}
dt {
    font-weight:normal;
}
dd {
    padding-bottom:10px;
}
.navbar .navbar-nav {
    display: inline-block;
    float: none;
}

.navbar .navbar-collapse {
    text-align: center;
}
.navbar-default{
    background-color:white;
}

.content-div{
    margin: auto;
    max-width: 75ch;
}</style>
<title>Matthew Burke University of Calgary Mathematics</title>
<meta name='description' content='Personal webpage of Matthew Burke, a postdoctoral scholar at the Department of Mathematics and Statistics at the University of Calgary and a member of the Calgary Peripatetic Research group in logic and category theory.'>
<meta name='keywords' content='mathematics matthew burke university calgary macquarie cambridge'>
</head>
<body>
<div class='navbar navbar-default navbar-fixed-top'>
    <div class='container'>
        <div class='navbar-header'>
            <button type='button' class='navbar-toggle' data-toggle='collapse' data-target='.navbar-collapse'>
                <span class='sr-only'>Toggle navigation</span>
                <span class='icon-bar'></span>
                <span class='icon-bar'></span>
                <span class='icon-bar'></span>
            </button>
        </div>
        <div class='navbar-collapse collapse'>
            <ul class='nav navbar-nav'>
                <li><a href='index.html'>Matthew Burke</a></li>
                <li><a href='papers.html'>Papers</a></li>
                <li><a href='talks.html'>Talks</a></li>
                <li><a href='writing.html'>Writing</a></li>
                <li><a href='software.html'>Software</a></li>
            </ul>
        </div>
    </div>
</div>
<div class='container body-content'>
%s
</div>
</body>
<footer style='padding-top:20px'>
    <hr />
    <a href='#'>Top of page</a>
</footer>
<script>%s</script>
<script>%s</script>
" bootstrap-css body jquery bootstrap-js))
