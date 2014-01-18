(in-package :cl-user)

(asdf:defsystem :cl-ws-wookie
    :description "cl-ws-wookie"
    :version "0.1"
    :author "mnmkh"
    :defsystem-depends-on (:asdf :cl-ws)
    :serial T
    :encoding :utf-8
    :pathname "src/frontend/"
    :components ((:static-file "cl-ws-wookie.asd")
		 (:file "wookie"))
    :depends-on (:skip
		 :hu.dwim.defclass-star
		 :cl-ws
		 :wookie))

(asdf:defsystem :cl-ws-wookie-test
  :defsystem-depends-on (:asdf :cl-ws-wookie)
  :serial T
  :encoding :utf-8
  :pathname "t/frontend/"
  :components ((:file "run-test"))
  :depends-on (:cl-ws-wookie :fiveAM))

(defmethod perform ((op asdf:test-op) (c (eql (asdf:find-system :cl-ws-wookie))))
  (load (merge-pathnames "t/frontend/run-test.lisp" (system-source-directory c))))
