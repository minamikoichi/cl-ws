(in-package :cl-ws)

(defgeneric launch-instance (<frontend-config>))
(defgeneric stop-instance (<frontend>))

(defmethod launch-instance :after ((frontend-config <frontend-config>))
  (format t "launch-instance ~a ~%" (name-of frontend-config))
  (map nil #'(lambda (s) (load-service s)) (service-of frontend-config)))

(defmethod stop-instance :after  ((frontend <frontend>))
  (let ((config (config-of frontend)))
    (format t "stop-instance ~a ~%" (name-of config))
    (map nil #'(lambda (s) (shutdown-service s)) (service-of config))))

;(defgeneric launch-instance :after (<frontend-config>))

;(&key (port 4236) (log-dir *default-log-dir*))
;  (with-slots (port) config    
  ;; (lt1 instance (make-instance '<acceptor>
  ;; 		 :port port
  ;; 		 :access-log-destination (concatenate 'string log-dir "/access.log")
  ;; 		 :message-log-destination (concatenate 'string log-dir "/message.log")
  ;; 		 :services (make-hash-table :test 'equal)
  ;; 		 :default-service default-service
  ;; 		 :document-root nil)
  ;;      (map nil #'(lambda (s) (start-service instance s)) services)
  ;;      (setup-hunchentoot)
  ;;      (hunchentoot:start instance)))
