(in-package :cl-user)

(asdf:defsystem :cl-ws
  :description "cl-ws"
  :version "0.1"
  :author "mnmkh"
  :defsystem-depends-on (:cl-ws-common :cl-ws-object)
  :serial T
  :encoding :utf-8
  :pathname "src/"
  :components ((:static-file "cl-ws.asd")
	       (:file "packages")
	       (:file "config")
	       (:file "frontend")
	       (:file "service-op")
	       (:file "server"))
;		 (:file "acceptor")
;	       (:file "markup-template-file"))
  :depends-on (:skip
	       :hu.dwim.defclass-star
	       :cl-markup))

(asdf:defsystem :cl-ws-test
  :version "0.1"
  :defsystem-depends-on (:cl-ws-common)
  :serial T
  :encoding :utf-8
  :pathname "t/"  
  :components ((:file "packages"))
  :depends-on (:cl-ws :fiveAM))

;;
;; 
;;
(defmethod perform ((op asdf:test-op) (c (eql (asdf:find-system :cl-ws))))
  (load (merge-pathnames "t/run-test.lisp" (system-source-directory c))))
