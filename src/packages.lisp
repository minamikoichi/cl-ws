(in-package :cl-user)

(defpackage :cl-ws
  (:use :cl
	:cl-ppcre
	:sb-mop	
	:skip
	:hu.dwim.defclass-star
	:cl-ws-common
	:cl-ws-object
	:cl-markup)
  ;; (:import-from :hunchentoot :acceptor-dispatch-request
  ;; 		             :handle-static-file
  ;; 		             :script-name*
  ;; 			     :log-message*
  ;; 			     :redirect
  ;; 			     :*reply*
  ;; 			     :return-code
  ;; 			     :+http-not-found+)

  (:export :<config> 
	   :defconfig
	   :<frontend-config>
	   :def-frontend-config
	   :port-of
	   :service-of
	   :name-of
	   :log-path-of
	   :launch-instance
	   :load-service
	   ))
  ;; 	   :setroutes
  ;; 	   :launch-instance
  ;; 	   :stop-instance
  ;; 	   ;; from cl-ws-common
  ;; 	   :get-service-root
  ;; 	   :set-service-root
  ;; 	   :get-db-root
  ;; 	   :set-db-root
  ;; 	   :set-load-files-root
  ;; 	   :get-load-files-root
  ;; 	   ;; view function
  ;; 	   :*service-path*
  ;; 	   :make-host-link
  ;; 	   ;; view function
  ;; 	   :*view-template-root*
  ;; 	   :markup-template-file))
