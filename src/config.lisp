(skip:def-in-package :cl-ws)

(defclass* <config> ()
  ((root-path )
   (log-path )
   (port 4236)
   (database-type)))
    
(defmacro defconfig (name &body body)
 `(defparameter ,name
    (make-instance '<config> ,@body)))

(defclass* <frontend-config> ()
  ((name :wookie)
   (port 4236)
   (service nil)
   (log-path nil)))

(defmacro def-frontend-config (name &body body)
  `(defparameter ,name
     (make-instance '<frontend-config> ,@body)))

;(defconfig *config*
;  :root-path #p"/"
;  :log-path #p"log/"
;  :contents-path #p"public/"
;  :port 4236
;  :database-type :sqlite3)
