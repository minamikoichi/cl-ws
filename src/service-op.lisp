(in-package :cl-ws)

;;
;; global service list.
;;
(defvar *service-list* (make-hash-table :test 'equal))

(defun register-service (name service)
  (setf (gethash name *service-list*) service))
(defun unregister-service (name)
  (remhash name *service-list*))
(defun find-service (name) (gethash name *service-list*))

(defmacro constr (&rest rest) `(concatenate 'string ,@rest))

(defun load-service (name &key (service-dir *service-root*))
  (skip:whenbind service (make-service name)
    (boot service)
    (register-service name service)))

(defun shutdown-service (name &key (service-dir *service-root*))
  (skip:whenbind service (find-service name)
    (shutdown service)
    (unregister-service name)))
