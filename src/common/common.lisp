(in-package :cl-user)

(defpackage :cl-ws-common
  (:use :cl
	:asdf
	:skip)
  (:export :*service-root*
	   :set-service-root
	   :get-service-root
	   :*db-root*
	   :set-db-root
	   :get-db-root
	   :*load-files-root*
	   :set-load-files-root
	   :get-load-files-root))

(in-package :cl-ws-common)

;;
;; cl-ws service-directory.
;;
(defparameter *service-root* (make-pathname :directory '(:relative "service")))

(defun set-service-root (path)
  (setf *service-root* path)
  (let ((service-dirs (directory (merge-pathnames (make-pathname :directory '(:relative :wild)) path))))
    (map nil #'(lambda (d) (push d asdf:*central-registry*)) service-dirs)))

(defun get-service-root () *service-root*)

;;
;; cl-ws db-directory.
;;
(defparameter *db-root* (make-pathname :directory '(:relative "db")))
(defun set-db-root (path) (setf *db-root* path))
(defun get-db-root () *db-root*)

;;
;; cl-ws load-files-directory.
;;
(defparameter *load-files-root* (make-pathname :directory '(:relative "load-files")))
(defun set-load-files-root (path) (setf *load-files-root* path))
(defun get-load-files-root () *load-files-root*)
