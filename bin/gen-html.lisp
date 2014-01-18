#!/usr/local/bin/sbcl --script
;;;;
;;;; Author: mnmkh
;;;; generate html script
;;;; 

(load #p"~/.sbclrc")

(add-libpath! #p"./lib/markup-template-file/")
(let ((*standard-output* (make-string-output-stream)))
  (ql:quickload "markup-template-file"))

(defun usage ()
  (format t "[Usage] gen-html TEMPLATE-DIREDTORY TARGET-DIRECTORY ~%"))

(unless (= (length sb-ext:*posix-argv*) 3)
  (usage)
  (exit))

;; variable
(defvar *template-directory* (second sb-ext:*posix-argv*))
(defvar *target-directory* (third sb-ext:*posix-argv*))

;;
;; main program.
;;
(format t "[template directory]: ~a ~%" *template-directory*)
(format t "[target directory]: ~a ~%" *target-directory*)

(let ((template-file-list (directory (make-pathname :directory (pathname-directory (parse-namestring *template-directory*))						     
						     :name :wild
						     :type "tmpl"))))
  (when template-file-list 
    (loop for path in template-file-list
       with output-path = (make-pathname :directory (pathname-directory (parse-namestring *target-directory*))
					 :name (pathname-name path)
					 :type "html")
       do
	 (format t "markup : ~a -> ~a ~%" path output-path)
	 (with-open-file (out output-path :direction :output)
	   (format out (markup-template-file:markup-template-file *template-directory* *target-directory*))))))
