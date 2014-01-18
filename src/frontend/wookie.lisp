(skip:def-in-package :cl-ws-wookie
  (:use :cl-ws 
	:cl-ws-object
	:wookie)
  (:export :launch-instance
	   :make-routes))

(defmethod launch-instance ((frontend-config <frontend-config>))
   (wookie:load-plugins)
   (as:with-event-loop (:catch-app-errors t)
     ;; create a listener object, and pass it to start-server, which starts Wookie
     (let* ((listener (make-instance 'wookie:listener
				     :bind nil  ; equivalent to "0.0.0.0" aka "don't care"
				     :port (cl-ws:port-of frontend-config)))
	    ;; start it!!
	    (server (start-server listener)))
       (map nil #'(lambda (s) (load-service s)) (cl-ws:service-of frontend-config))
       ;; stop server on ctrl+c
       (as:signal-handler 2 
			  (lambda (sig)
			    (declare (ignore sig))
			    ;; remove our signal handler (or the event loop will just sit indefinitely)
			    (as:free-signal-handler 2)
			    ;; graceful stop...rejects all new connections, but lets current requests
			    ;; finish.
			    (as:close-tcp-server server))))))

;; todo route wrapper.
;(defmacro make-routes (method path action)
;  "defroute wrapper"
;  `(wookie:defroute (,method ,path) (req res) ,(funcall action req res)))
