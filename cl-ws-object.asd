(in-package :cl-user)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:oos 'asdf:load-op :cl-ws-common))

(defpackage :cl-ws-object-asd
  (:use :cl :asdf))

(in-package :cl-ws-object-asd)

(defsystem :cl-ws-object
    :description "cl-ws-object"
    :version "0.1"
    :author "mnmkh"
    :serial T
    :components ((:static-file "cl-ws-object.asd")
		 (:module :src/object
			  :serial T
			  :components ((:file "service"))))
    :depends-on (:cl-ppcre
		 :skip
		 :hu.dwim.defclass-star))

(defsystem :cl-ws-object-test
  :components ((:module :t/object
                        :serial t
                        :components ((:file "service"))))
  :depends-on (:cl-ws-object :fiveAM))

(defmethod perform ((op asdf:test-op) (c (eql (find-system 'cl-ws-object))))
  (load (merge-pathnames "t/object/run-test.lisp" (system-source-directory c))))
