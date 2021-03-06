(skip:def-in-package :markup-template-file
  (:use :cl
	:cl-markup)
  (:nicknames :tmpl)
  (:export #:markup-template-file))

;(defvar *view-template-root*)

;; bad code...
;; @todo: create template reader
(defmacro with-progn-in-package (package &body body)
  (let ((gpkg (gensym))
	(ret (gensym)))
    `(let ((,gpkg *package*) (,ret nil))
       (eval-when (:compile-toplevel :load-toplevel :execute)
	 (setq *package* (sb-int:find-undeleted-package-or-lose ,package)))
       (setq ,ret ,@body)
       (eval-when (:compile-toplevel :load-toplevel :execute)
	 (setq *package* (sb-int:find-undeleted-package-or-lose ,gpkg)))
       ,ret)))

(set-dispatch-macro-character #\# #\,
  (lambda (s c m)
    (eval (read s t nil t))))

(set-dispatch-macro-character #\# #\@
  (lambda (s c m)
    (read-from-file (symbol-name (read s t nil t)))))

(defun file-to-string (path)
;  (let ((path (make-pathname :directory (pathname-directory *view-template-root*)
;			     :name tmpl :type "tmpl")))
    (with-open-file (in path)
      (when in
	(with-output-to-string (out)
	  (loop for line = (read-line in nil nil)
	     while line
	     do (write-line line out))))))

(defun read-from-file (path)
  (read-from-string (file-to-string path)))

(defun markup-template-file (path &key eval-package)
  (eval-when (:compile-toplevel :load-toplevel :execute)
    (setf cl-markup:*markup-language* :html5)
    (with-progn-in-package (package-name (find-package eval-package))
      (constr (cl-markup:doctype :html)
	      (cl-markup:markup* (read-from-file path))))))
