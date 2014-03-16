(skip:def-in-package :cl-ws-wookie
  (:use :cl-ws 
	:cl-ws-object
	:bordeaux-threads
	:wookie)
  (:export :launch-instance
	   :stop-instance
	   :make-routes))

(defparameter *plugin-lock* (bt:make-lock))

(defmethod launch-instance ((frontend-config <frontend-config>))
  (let ((frontend (make-instance '<frontend>)))
    (bt:make-thread 
     (lambda ()
       ;; this let makes wookie:*state* a thread-local variable
       (let ((wookie:*state* (make-instance 'wookie-state)))
	 ;; lock our ASDF ops!!
	 (bt:with-lock-held (*plugin-lock*)
	   (load-plugins))
	 (map nil #'(lambda (s) (load-service s)) (cl-ws:service-of frontend-config))
	 (as:with-event-loop (:catch-app-errors t)
	   ;; create a listener object, and pass it to start-server, which starts Wookie
	   (let* ((listener (make-instance 'wookie:listener
					   :bind nil  ; equivalent to "0.0.0.0" aka "don't care"
					   :port (cl-ws:port-of frontend-config))))
	    ;; start it!!
	     (setf (instance-of frontend) (start-server listener))
	     (setf (config-of frontend)   frontend-config))))))
	    ;; stop server on ctrl+c
;	    (as:signal-handler 2 
;			       (lambda (sig)
;				 (declare (ignore sig))
				 ;; remove our signal handler (or the event loop will just sit indefinitely)
;				 (as:free-signal-handler 2)
				 ;; graceful stop...rejects all new connections, but lets current requests
				 ;; finish.
;				 (as:close-tcp-server server))))))))
    frontend))

(defmethod stop-instance ((frontend <frontend>))
  (as:close-tcp-server (instance-of frontend)))
