(in-package :cl-user)

(defpackage :cl-ws-object
  (:use :cl
	:cl-ppcre
	:skip
	:hu.dwim.defclass-star)
  (:export :<service>
	   :name
	   :name-of
	   :db-contexts
	   :db-contexts-of
	   :dbs
	   :get-db
	   :routes
	   :routes-of
	   :boot
	   :shutdown
	   :route
	   :defservice
	   :make-service
	   :setroutes
	   :get-service-object-root
;	   :; find-dispatcher
	   ;; fomr ht-service-common
))

(in-package :cl-ws-object)

(defun get-service-object-root (name)
  (merge-pathnames (get-service-root)
		   (make-pathname :directory name)))

(defun pick-two (body)
  (cond ((null body) nil)
	((atom body) body)
	((not (consp (cdr body))) (list body))
	((not (consp (cddr body))) (list body))
	((consp (cdr body))
	 (cons (list (car body) (cadr body))
	       (pick-two (cddr body))))))

;;
;; service class
;;
(defclass* <service> ()
  ((name "")
   (db-contexts nil)
   (dbs (make-hash-table :test 'equal))
   ; routeing table.
   (route)))

(defgeneric boot (<service>))
(defgeneric shutdown (<service>))
(defgeneric route (<service> request path))

(defun make-service (name)
  (make-instance (intern (string-upcase name) (string-upcase name))
		 :name name))

(defmacro defservice (name &rest body)
  `(progn (defclass* ,name (<service>) ,(pick-two body))
	  (export ',name)))

;;
;; db function.
;;
(defmethod setup-dbs ((service <service>))
  (map nil #'(lambda (context) (apply #'setup-db (cons service context))) (db-contexts-of service)))
(defgeneric setup-db (<service> &key name scheme type))

(defmethod cleanup-dbs ((service <service>))
  (maphash (^ (key val) (cleanup-db service key)) (dbs-of service)))
(defgeneric cleanup-db (<service> name))

(defmethod get-db ((service <service>) &key name)
  (gethash name (dbs-of service)))

;;
;; routing table
;; 

;; (defmethod find-dispatcher ((service <service>) request)
;;   (loop for dispatcher in routes
;;      for action = (funcall dispatcher request)
;;      when action return (values (funcall action request) t)))

;; (defun make-service-dispatcher (regex handler)
;;   (let ((scanner (create-scanner regex)))
;;     (lambda (request)
;;       (when (scan scanner request) handler))))

;; (defun make-routes (routes)
;;   (mapcar (lambda (args) (apply #'make-service-dispatcher args)) routes))

;; (defmethod route ((service <service>) request path)
;;   (loop for dispatcher in (routes-of service)
;;      for action = (funcall dispatcher path)
;;      when action return (values (funcall action request) t)))

;; ;;
;; ;; default action.
;; ;;
(defmethod boot :before ((service <service>))
  (setup-dbs service))

(defmethod shutdown :after (<service>)
  (cleanup-dbs service))
