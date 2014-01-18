(skip:def-in-package :cl-ws-wookie-test
  (:use :cl-ws
	:cl-ws-wookie))

(cl-ws:def-frontend-config *frontend-config*
  :port 4236)

(defparameter *service* 
  (cl-ws-wookie:launch-instance *frontend-config*))

